package com.dfmy.service.project.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dfmy.dao.basedata.AtiMonitorTypeDao;
import com.dfmy.dao.device.AtiMonitorParamDeviceDao;
import com.dfmy.dao.project.AtiMonitorProjectDeviceDao;
import com.dfmy.entity.basedata.AtiMonitorItem;
import com.dfmy.entity.basedata.AtiMonitorParam;
import com.dfmy.entity.basedata.AtiMonitorType;
import com.dfmy.entity.device.AtiMonitorParamDevice;
import com.dfmy.entity.project.AtiMonitorProjectDevice;
import com.dfmy.service.project.AtiMonitorProjectDeviceService;

@Service
@Transactional
public class AtiMonitorProjectDeviceServiceImpl implements AtiMonitorProjectDeviceService {

	@Autowired
	private AtiMonitorTypeDao atiMonitorTypeDao;
	@Autowired
	private AtiMonitorParamDeviceDao atiMonitorParamDeviceDao;
	@Autowired
	private AtiMonitorProjectDeviceDao atiMonitorProjectDeviceDao;

	@Override
	public List<Map<String, Object>> getTree(String pid) {
		List<Map<String, Object>> resList = new ArrayList<Map<String, Object>>();
		if (StringUtils.isNotBlank(pid)) {
			List<AtiMonitorType> typeList = atiMonitorTypeDao.findByStructId(pid);
			if (typeList != null && typeList.size() > 0) {
				for (AtiMonitorType type : typeList) {
					Map<String, Object> typeMap = new HashMap<String, Object>();
					typeMap.put("id", type.getId());
					typeMap.put("pId", "0");
					typeMap.put("name", type.getName());
					typeMap.put("tld", type.getId());
					resList.add(typeMap);
					if (type.getAtiMonitorItem() != null && type.getAtiMonitorItem().size() > 0) {
						for (AtiMonitorItem item : type.getAtiMonitorItem()) {
							Map<String, Object> itemMap = new HashMap<String, Object>();
							itemMap.put("id", item.getId());
							itemMap.put("pId", type.getId());
							itemMap.put("name", item.getName());
							resList.add(itemMap);
							if (item.getAtiMonitorParam() != null && item.getAtiMonitorParam().size() > 0) {
								for (AtiMonitorParam param : item.getAtiMonitorParam()) {
									Map<String, Object> paramMap = new HashMap<String, Object>();
									paramMap.put("id", param.getId());
									paramMap.put("pId", item.getId());
									paramMap.put("name", param.getName());
									resList.add(paramMap);
									
									List<AtiMonitorParamDevice> devices = atiMonitorParamDeviceDao.findByParamId(param.getId());
									if (devices != null && devices.size() > 0) {
										for (AtiMonitorParamDevice device : devices) {
											Map<String, Object> deviceMap = new HashMap<String, Object>();
											deviceMap.put("id", device.getId());
											deviceMap.put("pId", param.getId());
											deviceMap.put("name", device.getDeviceName());
											deviceMap.put("isLast", "true");
											resList.add(deviceMap);
										}
									}
								}
							}
						}
					}
				}
			}
		}
		return resList;
	}
	
	@Override
	public List<AtiMonitorProjectDevice> findByProjectId(String projectId) {
		return atiMonitorProjectDeviceDao.findByProjectId(projectId);
	}
	
	@Override
	public AtiMonitorProjectDevice save (AtiMonitorProjectDevice atiMonitorProjectDevice) {
		return atiMonitorProjectDeviceDao.save(atiMonitorProjectDevice);
	}

	@Override
	public void deleteByProjectIdAndParamDeviceIds(String projectId, String paramDeviceIds) {
		if (StringUtils.isNotBlank(paramDeviceIds)) {
			String[] paramDeviceIdArr = paramDeviceIds.split(",");
			List<String> paramDeviceIdList = new ArrayList<String>();
			for (String paramDeviceId : paramDeviceIdArr) {
				paramDeviceIdList.add(paramDeviceId);
			}
			atiMonitorProjectDeviceDao.delByProjectIdAndParamDeviceIds(projectId, paramDeviceIdList);
		} else {
			atiMonitorProjectDeviceDao.delByProjectId(projectId);
		}
	}

	@Override
	public AtiMonitorProjectDevice findByProjectIdAndParamDeviceId(String projectId, String paramDeviceId) {
		AtiMonitorProjectDevice entity = atiMonitorProjectDeviceDao.findByProjectIdAndParamDeviceId(projectId, paramDeviceId);
		if (entity != null) {
			return entity;
		} else {
			return new AtiMonitorProjectDevice();
		}
	}
}
