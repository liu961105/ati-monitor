package com.dfmy.controller.project;

import com.dfmy.controller.common.BaseController;
import com.dfmy.entity.ResultEntity;
import com.dfmy.entity.basedata.AtiProjectStructure;
import com.dfmy.entity.project.AtiProject;
import com.dfmy.service.basedata.AtiProjectStructureService;
import com.dfmy.service.device.AtiMonitorParamDeviceService;
import com.dfmy.service.project.AtiProjectService;
import com.dfmy.util.TimeHelper;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.ListUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.*;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/atiProject")
public class AtiProjectController extends BaseController {

    @Autowired
    private AtiProjectService atiProjectService;

    @Autowired
    private AtiProjectStructureService atiProjectStructureService;

    @Autowired
    private AtiMonitorParamDeviceService atiMonitorParamDeviceService;

    @RequestMapping("/projectPageInfo")
    public ResultEntity pageList(@RequestParam(value = "pageCurrent", defaultValue = "1") String pageCurrent, AtiProject atiProject){
        ResultEntity res = new ResultEntity();
        try {
            Page<AtiProject> pageInfo = atiProjectService.pageList(Integer.parseInt(pageCurrent), PAGESIZE, "createTime", atiProject);
            for (AtiProject p : pageInfo.getContent()){
                p.setStateStr("未生效");
                if(p.getState()){
                    p.setStateStr("已生效");
                }
            }
            if (pageInfo.getTotalPages() > 0) {
                res.setData(pageInfo);
                res.setMessage(GET_SUCCESS);
                res.setSuccess(SUCCESS);
            } else {
                res.setMessage(IS_NULL);
                res.setSuccess(NULL);
            }
        } catch (Exception e) {
            e.printStackTrace();
            res.setMessage(GET_ERROR + ":" + e.getMessage());
            res.setSuccess(ERROR);
        }
        return res;
    }

    @RequestMapping("/saveProjectInfo")
    public ResultEntity saveProject(AtiProject atiProject, String id){

        ResultEntity res = new ResultEntity();
        Subject currentUser = SecurityUtils.getSubject();
        atiProject.setOperatorName(currentUser.getPrincipal().toString());
        atiProject.setOperatorCode(currentUser.getPrincipal().toString());

        AtiProjectStructure atiProjectStructure = atiProjectStructureService.findById(atiProject.getProjectStructureId());

        try {
            //设置项目
            if(StringUtils.isBlank(id)){
               atiProject.setCreateTime(TimeHelper.getCurrentTime());
                atiProject.setUpdateTime(TimeHelper.getCurrentTime());
                atiProject.setStructureName(atiProjectStructure.getName());
                atiProject.setProjectStatus(0);
                atiProject.setWarnCount(0);
                atiProjectService.saveProjectInfo(atiProject);
            }else {
                atiProject.setId(id);
                AtiProject atiProjectDB = atiProjectService.findProjectById(id);
                atiProjectDB.setProjectName(atiProject.getProjectName());
                atiProjectDB.setAddress(atiProject.getAddress());
                atiProjectDB.setProjectStatus(atiProject.getProjectStatus());
                atiProjectDB.setLatitude(atiProject.getLatitude());
                atiProjectDB.setLongitude(atiProject.getLongitude());
                atiProjectDB.setUpdateTime(TimeHelper.getCurrentTime());
                atiProjectDB.setStructureName(atiProjectStructure.getName());
                atiProjectDB.setProjectStructureId(atiProjectStructure.getId());
                atiProjectService.saveProjectInfo(atiProjectDB);
            }
            atiProject.setUpdateTime(TimeHelper.getCurrentTime());

            res.setMessage(OPERATE_SUCCESS);
            res.setSuccess(SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            res.setMessage(OPERATE_ERROR + ":" + e.getMessage());
            res.setSuccess(ERROR);
        }
        return res;
    }

    @RequestMapping("/findProjectInfo")
    public ResultEntity findProjectInfoById(String ID){
        ResultEntity res = new ResultEntity();
        try {
            res.setData(atiProjectService.findProjectById(ID));
            res.setMessage(GET_SUCCESS);
            res.setSuccess(SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            res.setMessage(GET_ERROR + ":" + e.getMessage());
            res.setSuccess(ERROR);
        }
        return res;
    }

    @RequestMapping("/delProjectInfo")
    public ResultEntity delProjectInfo(String ID){
        ResultEntity res = new ResultEntity();
        try {
            String[] ids = ID.split(",");
            for(String delId : ids){
                atiProjectService.deleteProjectId(delId);
            }
            res.setMessage(DELETE_SUCCESS);
            res.setSuccess(SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            res.setMessage(DELETE_ERROR + ":" + e.getMessage());
            res.setSuccess(ERROR);
        }
        return res;
    }

    @RequestMapping("/getProjectDevice")
    public ResultEntity getProjectDevice(String projectId){
        ResultEntity res = new ResultEntity();
        try {
            List<Map<String,Object>> pageData = atiMonitorParamDeviceService.getProjectParamDeviceByProjectId(projectId);
            Long total = atiMonitorParamDeviceService.getProjectParamDeviceByProjectIdCount(projectId);
            Pageable pageable = new PageRequest(1,Integer.MAX_VALUE);
            Page<Map<String,Object>> pageInfo = new PageImpl<>(pageData,pageable,total);
            res.setData(pageInfo);
            res.setMessage(GET_SUCCESS);
            res.setSuccess(SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            res.setMessage(GET_ERROR + ":" + e.getMessage());
            res.setSuccess(ERROR);
        }
        return res;
    }


    @RequestMapping("getProject")
    public ResultEntity getProject(){
        ResultEntity res = new ResultEntity();
        try {
            List<Map<String,String>> result = new ArrayList<>();
            List<AtiProjectStructure> structures = atiProjectStructureService.findByState("1");
            if(CollectionUtils.isNotEmpty(structures)){
                for(AtiProjectStructure s : structures){
                    Map<String,String> node = new HashMap<>();
                    node.put("id",s.getId());
                    node.put("pid","");
                    node.put("name",s.getName());
                    node.put("isProject","0");
                    result.add(node);
                }
            }
            List<AtiProject> projects = atiProjectService.findAllByState("1");
            if(CollectionUtils.isNotEmpty(projects)){
                for(AtiProject p :  projects){
                    Map<String,String> node = new HashMap<>();
                    node.put("id",p.getId());
                    node.put("name",p.getProjectName());
                    node.put("pid",p.getProjectStructureId());
                    node.put("isProject","1");
                    result.add(node);
                }
            }
            res.setData(result);
            res.setMessage(GET_SUCCESS);
            res.setSuccess(SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            res.setMessage(GET_ERROR + ":" + e.getMessage());
            res.setSuccess(ERROR);
        }
        return res;
    }

    @RequestMapping("getProjectByManagerId")
    public ResultEntity getProjectByManagerId(String managerId){
        ResultEntity res = new ResultEntity();
        try {
            res.setData(atiProjectService.findAllByManagerId(managerId));
            res.setMessage(GET_SUCCESS);
            res.setSuccess(SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            res.setMessage(GET_ERROR + ":" + e.getMessage());
            res.setSuccess(ERROR);
        }
        return res;
    }

    @RequestMapping("setProjectManager")
    public ResultEntity getProjectByManagerId(String projects,String managerId){
        ResultEntity res = new ResultEntity();
        try {
            List<String> pids = new ArrayList<>();
            String[] idsArray = projects.split(",");
            for(String pid : idsArray){
                pids.add(pid);
            }
            atiProjectService.updateProjectManagerId(pids,managerId);
            res.setMessage(GET_SUCCESS);
            res.setSuccess(SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            res.setMessage(GET_ERROR + ":" + e.getMessage());
            res.setSuccess(ERROR);
        }
        return res;
    }

    @RequestMapping("findCurrentBeResponsibleForProject")
    public ResultEntity findCurrentBeResponsibleForProject(String projectStructureId){
        ResultEntity res = new ResultEntity();
        try {
            Map<String,Object> result = new HashMap<>();
            result.put("currentProject",atiProjectService.findCurrentBeResponsibleForProject(projectStructureId));
            result.put("projectTotal",atiProjectService.countAllByState());
            res.setData(result);
            res.setMessage(GET_SUCCESS);
            res.setSuccess(SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            res.setMessage(GET_ERROR + ":" + e.getMessage());
            res.setSuccess(ERROR);
        }
        return res;
    }

}
