package com.dfmy.controller.device;

import com.dfmy.controller.common.BaseController;
import com.dfmy.entity.ResultEntity;
import com.dfmy.entity.basedata.AtiMonitorItem;
import com.dfmy.entity.basedata.AtiMonitorParam;
import com.dfmy.entity.basedata.AtiMonitorType;
import com.dfmy.entity.basedata.AtiProjectStructure;
import com.dfmy.entity.device.AtiDevice;
import com.dfmy.entity.device.AtiMonitorParamDevice;
import com.dfmy.service.basedata.AtiMonitorItemService;
import com.dfmy.service.basedata.AtiMonitorParamService;
import com.dfmy.service.basedata.AtiMonitorTypeService;
import com.dfmy.service.basedata.AtiProjectStructureService;
import com.dfmy.service.device.AtiDeviceService;
import com.dfmy.service.device.AtiMonitorParamDeviceService;
import com.dfmy.util.TimeHelper;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/device")
public class AtiDeviceController extends BaseController {

    @Autowired
    private AtiDeviceService atiDeviceService;

    @Autowired
    private AtiMonitorParamService atiMonitorParamService;
    @Autowired
    private AtiMonitorItemService atiMonitorItemService;
    @Autowired
    private AtiMonitorTypeService atiMonitorTypeService;
    @Autowired
    private AtiProjectStructureService atiProjectStructureService;

    @Autowired
    private AtiMonitorParamDeviceService atiMonitorParamDeviceService;

    @RequestMapping("/devicePageInfo")
    public ResultEntity pageList(@RequestParam(value = "pageCurrent", defaultValue = "1") String pageCurrent, AtiDevice atiDevice){
        ResultEntity res = new ResultEntity();
        try {
            Page<AtiDevice> pageInfo = atiDeviceService.pageList(Integer.parseInt(pageCurrent), PAGESIZE, "createTime", atiDevice);

            for(AtiDevice device : pageInfo.getContent()){
                if("1".equals(device.getOpenFlag())){
                    device.setOpenFlag("开启");
                }else {
                    device.setOpenFlag("未开启");
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

    @RequiresPermissions("device:saveDevice")
    @RequestMapping("/saveAtiDevice")
    public ResultEntity saveProject(AtiDevice atiDevice, String id){

        ResultEntity res = new ResultEntity();
        Subject currentUser = SecurityUtils.getSubject();
        try {
            atiDevice.setOperatorName(currentUser.getPrincipal().toString());
            atiDevice.setOperatorCode(currentUser.getPrincipal().toString());
            atiDevice.setUpdateTime(TimeHelper.getCurrentTime());

            //设置设备
            if(StringUtils.isBlank(id)){
                atiDevice.setCreateTime(TimeHelper.getCurrentTime());
            }
            atiDeviceService.saveAtiDevice(atiDevice);
            res.setMessage(OPERATE_SUCCESS);
            res.setSuccess(SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            res.setMessage(OPERATE_ERROR + ":" + e.getMessage());
            res.setSuccess(ERROR);
        }
        return res;
    }

    @RequestMapping("/findAtiDevice")
    public ResultEntity findProjectInfoById(String ID){
        ResultEntity res = new ResultEntity();
        try {
            res.setData(atiDeviceService.findAtiDeviceById(ID));
            res.setMessage(GET_SUCCESS);
            res.setSuccess(SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            res.setMessage(GET_ERROR + ":" + e.getMessage());
            res.setSuccess(ERROR);
        }
        return res;
    }

    @RequestMapping("/delAtiDevice")
    public ResultEntity delProjectInfo(String ID){
        ResultEntity res = new ResultEntity();
        try {
            String[] ids = ID.split(",");
            for(String delId : ids){
                atiDeviceService.deleteAtiDevice(delId);
            }
            res.setMessage(GET_SUCCESS);
            res.setSuccess(SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            res.setMessage(GET_ERROR + ":" + e.getMessage());
            res.setSuccess(ERROR);
        }
        return res;
    }
    

    @RequestMapping("/saveAtiDeviceParam")
    public ResultEntity saveAtiDeviceParam(String deviceId,String paramIds){
        ResultEntity result = new ResultEntity();
        try {
            AtiDevice atiDevice = atiDeviceService.findAtiDeviceById(deviceId);

            String[] paramIdArray = paramIds.split(",");

            Subject subject = SecurityUtils.getSubject();

            List<AtiMonitorParamDevice> atiMonitorParamDevices = new ArrayList<>();
            for(String paramId : paramIdArray){
                AtiMonitorParamDevice atiMonitorParamDevice = new AtiMonitorParamDevice();
                atiMonitorParamDevice.setCreateTime(TimeHelper.getCurrentTime());
                atiMonitorParamDevice.setUpdateTime(TimeHelper.getCurrentTime());
                atiMonitorParamDevice.setDeviceId(deviceId);
                atiMonitorParamDevice.setParamId(paramId);
                atiMonitorParamDevice.setDeviceCode(atiDevice.getDeviceCode());
                atiMonitorParamDevice.setDeviceName(atiDevice.getDeviceName());
                atiMonitorParamDevice.setCreateUser(subject.getPrincipal().toString());
                atiMonitorParamDevice.setState("1");
                atiMonitorParamDevice.setUpdateUser(subject.getPrincipal().toString());
                atiMonitorParamDevices.add(atiMonitorParamDevice);
            }
            atiMonitorParamDeviceService.saveAtiMonitorParamDevice(atiMonitorParamDevices,deviceId);

            result.setSuccess(SUCCESS);
            result.setMessage(GET_SUCCESS);
        }catch (Exception e){
            result.setData(null);
            result.setSuccess(ERROR);
            result.setMessage(OPERATE_ERROR);
            e.printStackTrace();
        }
        return result;
    }

    @RequestMapping("/findActiveDeviceParamByDeviceId")
    public ResultEntity findActiveDeviceParamByDeviceId(String deviceId){
        ResultEntity res = new ResultEntity();
        try {
            List<AtiMonitorParamDevice> atiMonitorParamDevices = atiMonitorParamDeviceService.findAtiMonitorParamDeviceByDeviceId(deviceId);

            if (atiMonitorParamDevices.size() > 0) {
                res.setData(atiMonitorParamDevices);
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
}
