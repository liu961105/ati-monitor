package com.dfmy.service.device.impl;

import com.dfmy.dao.basedata.AtiMonitorParamDao;
import com.dfmy.dao.device.AtiMonitorParamDeviceDao;
import com.dfmy.entity.device.AtiMonitorParamDevice;
import com.dfmy.service.device.AtiMonitorParamDeviceService;
import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Transactional
@Service
public class AtiMonitorParamDeviceServiceImpl implements AtiMonitorParamDeviceService {

    @Autowired
    private AtiMonitorParamDeviceDao atiMonitorParamDeviceDao;

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public void saveAtiMonitorParamDevice(List<AtiMonitorParamDevice> atiMonitorParamDevices, String deviceId) {
        //首先查询改设备下所有的参数
        List<AtiMonitorParamDevice> atiMonitorParamDeviceList = atiMonitorParamDeviceDao.findAllByDeviceId(deviceId);

        if (CollectionUtils.isNotEmpty(atiMonitorParamDeviceList)) {

            Map<String, String> atiDeviceParam = new HashMap<>();
            for (AtiMonitorParamDevice atiMonitorParamDevice : atiMonitorParamDeviceList) {
                atiDeviceParam.put(atiMonitorParamDevice.getParamId(),atiMonitorParamDevice.getId());
            }
            List<AtiMonitorParamDevice> insertList = new ArrayList<>();

            List<String> paramIds = new ArrayList<>();
            //循环更新节点数据
            for (AtiMonitorParamDevice atiMonitorParamDevice : atiMonitorParamDevices) {
                if(StringUtils.isBlank(atiDeviceParam.get(atiMonitorParamDevice.getParamId()))){
                    //说明数据库中没有该数据 ==》 保存
                    insertList.add(atiMonitorParamDevice);
                }
                paramIds.add(atiMonitorParamDevice.getParamId());
            }
            //首先删除确定数据
            atiMonitorParamDeviceDao.deleteByNotInParamIdsAndDeviceId(paramIds,deviceId);
            //批量添加数据
            if(insertList.size() > 0){
                atiMonitorParamDeviceDao.save(insertList);
            }
        }else {
            atiMonitorParamDeviceDao.save(atiMonitorParamDevices);
        }

    }

    @Override
    public void saveAtiMonitorParamDevice(AtiMonitorParamDevice atiMonitorParamDevice) {
        atiMonitorParamDeviceDao.save(atiMonitorParamDevice);
    }

    @Override
    public void deleteAtiMonitorParamDeviceByDeviceId(String deviceId) {
        AtiMonitorParamDevice atiMonitorParamDevice = new AtiMonitorParamDevice();
        atiMonitorParamDevice.setDeviceId(deviceId);
        atiMonitorParamDeviceDao.delete(atiMonitorParamDevice);
    }

    @Override
    public List<AtiMonitorParamDevice> findAtiMonitorParamDeviceByDeviceId(String deviceId) {
        return atiMonitorParamDeviceDao.findAllByDeviceId(deviceId);
    }

    @Override
    public List<Map<String, Object>> getProjectParamDeviceByProjectId(String projectId) {
        StringBuilder sb = new StringBuilder(
                "select p.id as id,mparamd.param_id as paramId,p.project_name as projectName,mp.name name,mparamd.device_id as deviceId,mparamd.device_name as deviceName\n" +
                        "from ati_project p\n" +
                        "inner join ati_monitor_project_device mpd on p.id = mpd.project_id and p.state = '1' and mpd.state = '1' \n" +
                        "inner join ati_monitor_param_device mparamd on mparamd.state = '1' and mparamd.id = mpd.param_device_id\n" +
                        "inner join ati_monitor_param mp on mp.id = mparamd.param_id "
        );
        sb.append("where p.id = ?");
        List<String> param = new ArrayList<>();
        param.add(projectId);
        return jdbcTemplate.queryForList(sb.toString(),param.toArray());
    }

    @Override
    public Long getProjectParamDeviceByProjectIdCount(String projectId) {
        StringBuilder sb = new StringBuilder(
                "select count(1)\n" +
                        "from ati_project p\n" +
                        "inner join ati_monitor_project_device mpd on p.id = mpd.project_id and p.state = '1' and mpd.state = '1' \n" +
                        "inner join ati_monitor_param_device mparamd on mparamd.state = '1' and mparamd.id = mpd.param_device_id\n" +
                        "inner join ati_monitor_param mp on mp.id = mparamd.param_id "
        );
        sb.append("where p.id = ?");
        List<String> param = new ArrayList<>();
        param.add(projectId);
        return jdbcTemplate.queryForLong(sb.toString(),param.toArray());
    }


}
