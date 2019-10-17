package com.dfmy.service.modelexport.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.dfmy.dao.device.AtiDeviceDataRecordHistoryDao;
import com.dfmy.entity.device.AtiDeviceDataRecordHistory;
import com.dfmy.service.modelexport.ModelExportService;
import com.google.common.base.FinalizablePhantomReference;

@Service
public class ModelExportServiceImpl implements ModelExportService {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private AtiDeviceDataRecordHistoryDao atiDeviceDataRecordHistoryDao;
	
	@Override
	public List<Map<String, Object>> getTitle(String projectId,String monitorParamId,String monitorSitesId) {
		String sqlString = "SELECT b.*,c.name AS monitor_param_name,d.name AS site_name FROM ati_monitor_project_device a LEFT JOIN ati_monitor_param_device b ON a.param_device_id = b.id LEFT JOIN ati_monitor_param c ON b.param_id = c.id LEFT JOIN ati_project_monitor_sites d ON a.project_id = d.project_id AND b.param_id = d.monitor_param_id  WHERE b.param_id =? AND  a.project_id = ? 	AND d.id = ?";
		return jdbcTemplate.queryForList(sqlString,monitorParamId,projectId,monitorSitesId);
	}

	@Override
	public Page<AtiDeviceDataRecordHistory> pageList(int pageNumber, int pageSize, String sortColom,
			final AtiDeviceDataRecordHistory atiDeviceDataRecordHistory,final String uploadTimeBegin,final String uploadTimeEnd) {
		Pageable pageable = new PageRequest(pageNumber - 1, pageSize, Sort.Direction.DESC, sortColom);
		if (sortColom.equals("monitorSitesName")) {
			pageable = new PageRequest(pageNumber - 1, pageSize, Sort.Direction.ASC, sortColom);
		}
		Page<AtiDeviceDataRecordHistory> pageInfo = atiDeviceDataRecordHistoryDao
				.findAll(new Specification<AtiDeviceDataRecordHistory>() {
					@Override
					public Predicate toPredicate(Root<AtiDeviceDataRecordHistory> root, CriteriaQuery<?> criteriaQuery,
							CriteriaBuilder criteriaBuilder) {
						List<Predicate> list = new ArrayList<>();
						if (StringUtils.isNotBlank(atiDeviceDataRecordHistory.getMonitorSitesName())) {
							list.add(criteriaBuilder.like(root.get("monitorSitesName").as(String.class),
									"%" + atiDeviceDataRecordHistory.getMonitorSitesName() + "%"));
						}
						if (StringUtils.isNotBlank(atiDeviceDataRecordHistory.getProjectId())) {
							list.add(criteriaBuilder.like(root.get("projectId").as(String.class),
									"%" + atiDeviceDataRecordHistory.getProjectId() + "%"));
						}
						if (StringUtils.isNotBlank(atiDeviceDataRecordHistory.getMonitorParamId())) {
							list.add(criteriaBuilder.like(root.get("monitorParamId").as(String.class),
									atiDeviceDataRecordHistory.getMonitorParamId()));
						}
						if (StringUtils.isNotBlank(atiDeviceDataRecordHistory.getMonitorTypeId())) {
							list.add(criteriaBuilder.like(root.get("monitorTypeId").as(String.class),
									atiDeviceDataRecordHistory.getMonitorTypeId()));
						}

						if (StringUtils.isNotBlank(atiDeviceDataRecordHistory.getMonitorSitesId())) {
							list.add(criteriaBuilder.like(root.get("monitorSitesId").as(String.class),
									atiDeviceDataRecordHistory.getMonitorSitesId()));
						}
						if (StringUtils.isNotBlank(uploadTimeBegin)) {
							list.add(criteriaBuilder.between(root.get("uploadTime").as(String.class), uploadTimeBegin,uploadTimeEnd));
						}
						Predicate[] p = new Predicate[list.size()];
						return criteriaBuilder.and(list.toArray(p));
					}
				}, pageable);

		return pageInfo;
	}
	@Override
	public List<AtiDeviceDataRecordHistory> findReportData(String projectId,
			String monitorParamId, String monitorSites,String uploadTimeBegin,String uploadTimeEnd) {

		return atiDeviceDataRecordHistoryDao.findReportData(projectId,
				monitorParamId, monitorSites,uploadTimeBegin,uploadTimeEnd);
	}
}
