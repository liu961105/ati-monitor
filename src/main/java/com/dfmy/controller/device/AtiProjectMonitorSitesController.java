package com.dfmy.controller.device;

import com.dfmy.controller.common.BaseController;
import com.dfmy.entity.ResultEntity;
import com.dfmy.entity.device.AtiProjectMonitorSites;
import com.dfmy.service.device.AtiProjectMonitorSitesService;
import com.dfmy.util.TimeHelper;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("atiProjectMonitorSites")
public class AtiProjectMonitorSitesController extends BaseController {

    @Autowired
    private AtiProjectMonitorSitesService atiProjectMonitorSitesService;

    @RequestMapping("/sitesPageInfo")
    public ResultEntity pageList(@RequestParam(value = "pageCurrent", defaultValue = "1") String pageCurrent, AtiProjectMonitorSites atiProjectMonitorSites){
        ResultEntity res = new ResultEntity();
        try {
            List<AtiProjectMonitorSites> pageInfo = atiProjectMonitorSitesService.findMonitorSites(atiProjectMonitorSites);
            if (pageInfo.size() > 0) {
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

    @RequestMapping("/saveMonitorSites")
    public ResultEntity saveMonitorSites(AtiProjectMonitorSites monitorSites, String id){

        ResultEntity res = new ResultEntity();
        Subject currentUser = SecurityUtils.getSubject();

        try {
            //设置项目
            if(StringUtils.isBlank(id)){
                monitorSites.setCreateUser(currentUser.getPrincipal().toString());
                monitorSites.setUpdateUser(currentUser.getPrincipal().toString());
                monitorSites.setCreateTime(TimeHelper.getCurrentTime());
                monitorSites.setUpdateTime(TimeHelper.getCurrentTime());
            }else {
                monitorSites.setUpdateUser(currentUser.getPrincipal().toString());
                monitorSites.setUpdateTime(TimeHelper.getCurrentTime());
            }
            atiProjectMonitorSitesService.save(monitorSites);
            res.setMessage(OPERATE_SUCCESS);
            res.setSuccess(SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            res.setMessage(OPERATE_ERROR + ":" + e.getMessage());
            res.setSuccess(ERROR);
        }
        return res;
    }

    @RequestMapping("/deleteMonitorSites")
    public ResultEntity delMonitorSites(String id){
        ResultEntity res = new ResultEntity();
        try {
            atiProjectMonitorSitesService.delete(id);
            res.setMessage(OPERATE_SUCCESS);
            res.setSuccess(SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            res.setMessage(OPERATE_ERROR + ":" + e.getMessage());
            res.setSuccess(ERROR);
        }
        return res;
    }


    /**
     *
     * @param id
     * @return
     */
    @RequestMapping("/findSitesById")
    public ResultEntity findSitesById(String id){
        ResultEntity res = new ResultEntity();
        try {
            res.setData(atiProjectMonitorSitesService.findMonitorById(id));
            res.setMessage(OPERATE_SUCCESS);
            res.setSuccess(SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            res.setMessage(OPERATE_ERROR + ":" + e.getMessage());
            res.setSuccess(ERROR);
        }
        return res;
    }

    @RequestMapping("/findAllByProjectId")
    public ResultEntity findAllByProjectId(String projectId){
        ResultEntity res = new ResultEntity();
        try {
            res.setData(atiProjectMonitorSitesService.findAllByProjectId(projectId));
            res.setMessage(OPERATE_SUCCESS);
            res.setSuccess(SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            res.setMessage(OPERATE_ERROR + ":" + e.getMessage());
            res.setSuccess(ERROR);
        }
        return res;
    }




}
