package com.dfmy.service.project;

import java.util.List;
import java.util.Map;

import com.dfmy.entity.project.AtiMonitorProjectDevice;

public interface AtiMonitorProjectDeviceService {

	/**
	 * 获取项目配置设备机构树
	 * @param pid
	 * @return
	 */
	public List<Map<String, Object>> getTree(String pid);
	
	/**
	 * 根据项目查找已关联设备列表
	 * @param projectId
	 * @return
	 */
	public List<AtiMonitorProjectDevice> findByProjectId(String projectId);
	
	/**
	 * 关联设备保存
	 * @param atiMonitorProjectDevice
	 * @return
	 */
	public AtiMonitorProjectDevice save (AtiMonitorProjectDevice atiMonitorProjectDevice);
	
	/**
	 * 删除库中已存在但为在树中选中的数据
	 * @param projectId
	 * @param paramDeviceIds
	 */
	public void deleteByProjectIdAndParamDeviceIds(String projectId, String paramDeviceIds);

	/**
	 * 根据项目和已关联设备获取数据实体
	 * 
	 * @param projectId
	 * @param paramDeviceId
	 * @return
	 */
	public AtiMonitorProjectDevice findByProjectIdAndParamDeviceId(String projectId, String paramDeviceId);
}
