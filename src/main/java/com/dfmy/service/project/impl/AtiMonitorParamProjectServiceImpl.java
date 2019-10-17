package com.dfmy.service.project.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dfmy.dao.basedata.AtiMonitorTypeDao;
import com.dfmy.dao.project.AtiMonitorParamProjectDao;
import com.dfmy.entity.basedata.AtiMonitorItem;
import com.dfmy.entity.basedata.AtiMonitorParam;
import com.dfmy.entity.basedata.AtiMonitorType;
import com.dfmy.entity.project.AtiMonitorParamProject;
import com.dfmy.service.project.AtiMonitorParamProjectService;

@Service
@Transactional
public class AtiMonitorParamProjectServiceImpl implements AtiMonitorParamProjectService {

	@Autowired
	private AtiMonitorParamProjectDao atiMonitorParamProjectDao;
	@Autowired
	private AtiMonitorTypeDao atiMonitorTypeDao;
	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Override
	public AtiMonitorParamProject save(AtiMonitorParamProject atiMonitorParamProject) {
		return atiMonitorParamProjectDao.save(atiMonitorParamProject);
	}

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
					typeMap.put("title", type.getName());
					typeMap.put("tld", type.getId());
					if (type.getAtiMonitorItem() != null && type.getAtiMonitorItem().size() > 0) {
						for (AtiMonitorItem item : type.getAtiMonitorItem()) {
							Map<String, Object> itemMap = new HashMap<String, Object>();
							itemMap.put("id", item.getId());
							itemMap.put("pId", type.getId());
							itemMap.put("name", item.getName());
							itemMap.put("title", item.getName());
							itemMap.put("tld", item.getId());
							if (item.getAtiMonitorParam() != null && item.getAtiMonitorParam().size() > 0) {
								for (AtiMonitorParam param : item.getAtiMonitorParam()) {
									Map<String, Object> paramMap = new HashMap<String, Object>();
									paramMap.put("id", param.getId());
									paramMap.put("pId", item.getId());
									paramMap.put("name", param.getName());
									paramMap.put("title", param.getName());
									paramMap.put("tld", param.getId());
									paramMap.put("isLast", "true");
									resList.add(paramMap);
								}
							}
							resList.add(itemMap);
						}
					}
					resList.add(typeMap);
				}
			}
		} 

		return resList;
	}

	@Override
	public List<AtiMonitorParamProject> findByProjectId(String projectId) {
		return atiMonitorParamProjectDao.findByProjectId(projectId);
	}

	@Override
	public void deleteByProjectIdAndParamIds(String projectId, String paramIds) {
		if (StringUtils.isNotBlank(paramIds)) {
			String[] paramIdArr = paramIds.split(",");
			List<String> paramIdList = new ArrayList<String>();
			for (String paramId : paramIdArr) {
				paramIdList.add(paramId);
			}
			atiMonitorParamProjectDao.delByProjectIdAndParamIds(projectId, paramIdList);
		} else {
			atiMonitorParamProjectDao.delByProjectId(projectId);
		}
	}

	@Override
	public AtiMonitorParamProject findByProjectIdAndParamId(String projectId, String paramId) {
		AtiMonitorParamProject entity = atiMonitorParamProjectDao.findByProjectIdAndMonitorParamId(projectId, paramId);
		if (entity != null) {
			return entity;
		} else {
			return new AtiMonitorParamProject();
		}
	}
	
	@Override
	public List<Map<String, Object>> getMonitorParamsConfig(String projectId,String monitorTypeId) {
		StringBuilder sql = new StringBuilder("SELECT a.project_id,b.id AS monitor_param_id,b.name AS monitor_param_name,c.id AS monitor_item_id,c.name AS monitor_item_name,c.type_id AS monitor_type_id ");
		sql.append(" FROM ati_monitor_param_project a ");
		sql.append(" LEFT JOIN ati_monitor_param b ON a.monitor_param_id = b.id ");
		sql.append(" LEFT JOIN ati_monitor_item c ON b.item_id = c.id ");
		sql.append(" WHERE c.type_id = ? AND a.project_id = ? ");
		return jdbcTemplate.queryForList(sql.toString(),monitorTypeId,projectId);
	}

}
