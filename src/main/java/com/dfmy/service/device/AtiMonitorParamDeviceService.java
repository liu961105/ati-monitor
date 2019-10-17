package com.dfmy.service.device;

import com.dfmy.entity.device.AtiMonitorParamDevice;

import java.util.List;
import java.util.Map;

public interface AtiMonitorParamDeviceService {

    /**
     * 批量增加
     * @param atiMonitorParamDevices
     */
    void saveAtiMonitorParamDevice(List<AtiMonitorParamDevice> atiMonitorParamDevices,String deviceId);

    /**
     * 单条添加
     * @param atiMonitorParamDevice
     */
    void saveAtiMonitorParamDevice(AtiMonitorParamDevice atiMonitorParamDevice);

    /**
     * 根据设备批量删除
     * @param deviceId
     */
    void deleteAtiMonitorParamDeviceByDeviceId(String deviceId);

    /**
     * 按deviceId 查询
     * @param deviceId
     * @return
     */
    List<AtiMonitorParamDevice> findAtiMonitorParamDeviceByDeviceId(String deviceId);

    /**
     * 根据项目查询 项目下所有关联的设备
     * @param projectId
     * @return
     */
    List<Map<String,Object>> getProjectParamDeviceByProjectId(String projectId);

    /**
     *
     * @param projectId
     * @return
     */
    Long  getProjectParamDeviceByProjectIdCount(String projectId);
}
