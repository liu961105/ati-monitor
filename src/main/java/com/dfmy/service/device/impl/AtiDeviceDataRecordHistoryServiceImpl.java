package com.dfmy.service.device.impl;

import java.math.BigInteger;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
import org.springframework.transaction.annotation.Transactional;

import com.dfmy.dao.device.AtiDeviceDataRecordHistoryDao;
import com.dfmy.entity.device.AtiDeviceDataRecordHistory;
import com.dfmy.service.device.AtiDeviceDataRecordHistoryService;

@Service
@Transactional
public class AtiDeviceDataRecordHistoryServiceImpl implements AtiDeviceDataRecordHistoryService {

	@Autowired
	private AtiDeviceDataRecordHistoryDao atiDeviceDataRecordHistoryDao;
	@Autowired
	private JdbcTemplate jdbcTemplate;
	

	@Override
	public List<Map<String, String>> findCompareDataByUploadDate(String monitorSitesId, String uploadTimeBegin,
			String uploadTimeEnd) {
		return atiDeviceDataRecordHistoryDao.getCompareDataByUploadDate(monitorSitesId, uploadTimeBegin, uploadTimeEnd);
	}

	@Override
	public Page<AtiDeviceDataRecordHistory> pageList(int pageNumber, int pageSize, String sortColom,
			final AtiDeviceDataRecordHistory atiDeviceDataRecordHistory) {
		Pageable pageable = new PageRequest(pageNumber - 1, pageSize, Sort.Direction.DESC, sortColom);
		if (sortColom.equals("monitorSitesName")) {
			pageable = new PageRequest(pageNumber - 1, pageSize, Sort.Direction.ASC, sortColom);
		}
		Page<AtiDeviceDataRecordHistory> pageInfo = atiDeviceDataRecordHistoryDao
				.findAll(new Specification<AtiDeviceDataRecordHistory>() {
					@Override
					public Predicate toPredicate(Root<AtiDeviceDataRecordHistory> root, CriteriaQuery<?> criteriaQuery,
							CriteriaBuilder criteriaBuilder) {
						List<Predicate> list = new ArrayList<Predicate>();
						if (StringUtils.isNotBlank(atiDeviceDataRecordHistory.getMonitorSitesName())) {
							list.add(criteriaBuilder.like(root.get("monitorSitesName").as(String.class),
									"%" + atiDeviceDataRecordHistory.getMonitorSitesName() + "%"));
						}
						if (atiDeviceDataRecordHistory.getWarnLevel() != null) {
							list.add(criteriaBuilder.equal(root.get("warnLevel").as(Integer.class),
									atiDeviceDataRecordHistory.getWarnLevel()));
						}
						if (StringUtils.isNotBlank(atiDeviceDataRecordHistory.getUploadTime())) {
							list.add(criteriaBuilder.like(root.get("uploadTime").as(String.class),
									"%" + atiDeviceDataRecordHistory.getUploadTime() + "%"));
						}
						if (StringUtils.isNotBlank(atiDeviceDataRecordHistory.getWarnMessage())) {
							list.add(criteriaBuilder.like(root.get("warnMessage").as(String.class),
									"%" + atiDeviceDataRecordHistory.getWarnMessage() + "%"));
						}
						if (StringUtils.isNotBlank(atiDeviceDataRecordHistory.getDealTime())) {
							list.add(criteriaBuilder.like(root.get("dealTime").as(String.class),
									"%" + atiDeviceDataRecordHistory.getDealTime() + "%"));
						}
						if (StringUtils.isNotBlank(atiDeviceDataRecordHistory.getState())) {
							list.add(criteriaBuilder.like(root.get("state").as(String.class),
									"%" + atiDeviceDataRecordHistory.getState() + "%"));
						}
						if (StringUtils.isNotBlank(atiDeviceDataRecordHistory.getDealMessage())) {
							list.add(criteriaBuilder.like(root.get("dealMessage").as(String.class),
									"%" + atiDeviceDataRecordHistory.getDealMessage() + "%"));
						}
						if (StringUtils.isNotBlank(atiDeviceDataRecordHistory.getDealStatus())) {
							list.add(criteriaBuilder.like(root.get("dealStatus").as(String.class),
									"%" + atiDeviceDataRecordHistory.getDealStatus() + "%"));
						}
						if (StringUtils.isNotBlank(atiDeviceDataRecordHistory.getRunningState())) {
							list.add(criteriaBuilder.like(root.get("runningState").as(String.class),
									"%" + atiDeviceDataRecordHistory.getRunningState() + "%"));
						}
						if (StringUtils.isNotBlank(atiDeviceDataRecordHistory.getProjectId())) {
							list.add(criteriaBuilder.like(root.get("projectId").as(String.class),
									"%" + atiDeviceDataRecordHistory.getProjectId() + "%"));
						}
						if (StringUtils.isNotBlank(atiDeviceDataRecordHistory.getMonitorTypeName())) {
							list.add(criteriaBuilder.like(root.get("monitorTypeName").as(String.class),
									"%" + atiDeviceDataRecordHistory.getMonitorTypeName() + "%"));
						}
						if (StringUtils.isNotBlank(atiDeviceDataRecordHistory.getDealUser())) {
							list.add(criteriaBuilder.like(root.get("dealUser").as(String.class),
									atiDeviceDataRecordHistory.getDealUser()));
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
						if (StringUtils.isNotBlank(atiDeviceDataRecordHistory.getUploadTime())) {
							list.add(criteriaBuilder.like(root.get("uploadTimeBegin").as(String.class),atiDeviceDataRecordHistory.getUploadTime()));
						}
						if (StringUtils.isNotBlank(atiDeviceDataRecordHistory.getMonitorSitesIds())) {
							String[] MonitorSitesIds = atiDeviceDataRecordHistory.getMonitorSitesIds().split(",");
							if (MonitorSitesIds.length > 0) {
								CriteriaBuilder.In<String> in = criteriaBuilder
										.in(root.get("monitorSitesId").as(String.class));
								for (String monitSiteId : MonitorSitesIds) {
									in.value(monitSiteId);
								}
								list.add(in);
							}
						}

						Predicate[] p = new Predicate[list.size()];
						return criteriaBuilder.and(list.toArray(p));
					}
				}, pageable);

		return pageInfo;
	}

	@Override
	public List<AtiDeviceDataRecordHistory> findByDealStatusAndWarnLevel(String dealStatus, Integer warnLevel) {
		return atiDeviceDataRecordHistoryDao.findByDealStatusAndWarnLevel(dealStatus, warnLevel);
	}

	@Override
	public AtiDeviceDataRecordHistory findById(String id) {
		return atiDeviceDataRecordHistoryDao.findOne(id);
	}

	@Override
	public void save(AtiDeviceDataRecordHistory atiDeviceDataRecordHistory) {
		atiDeviceDataRecordHistoryDao.save(atiDeviceDataRecordHistory);
	}

	@Override
	public List<AtiDeviceDataRecordHistory> findByPojectId(String projectId) {

		return atiDeviceDataRecordHistoryDao.findByProjectId(projectId);
	}

	@Override
	public List<AtiDeviceDataRecordHistory> findmonitorSitesData(String projectId, String monitorTypeId,
			String monitorParamId) {
		return atiDeviceDataRecordHistoryDao.findmonitorSitesData(projectId, monitorTypeId, monitorParamId);
	}

	@Override
	public List<AtiDeviceDataRecordHistory> findReportData(String projectId,
			String monitorParamId, String monitorSites,String uploadTimeBegin,String uploadTimeEnd) {

		return atiDeviceDataRecordHistoryDao.findReportData(projectId,
				monitorParamId, monitorSites,uploadTimeBegin,uploadTimeEnd);
	}

	@Override
	public List<Map<String, Object>> getAllNoDealErrorData(String projectId) {
		StringBuilder sql = new StringBuilder(
				"SELECT t.id,t.project_id,t.project_name,t.monitor_type_id,t.monitor_type_name,b.id AS monitor_item_id,b.name AS monitr_item_name,t.monitor_param_id,t.monitor_param_name,t.device_id,t.device_code,t.device_name,t.monitor_sites_id,t.monitor_sites_name,t.device_upload_data,t.warn_level,t.upload_time ");
		sql.append(" FROM ati_device_data_record_history t ");
		sql.append(" LEFT JOIN ati_monitor_param a ON t.monitor_param_id = a.id ");
		sql.append(" LEFT JOIN ati_monitor_item b ON a.item_id = b.id ");
		sql.append(" WHERE t.deal_status = '0' and t.warn_level > 0 and t.is_group <> '1'");
		sql.append(" AND DATE_FORMAT(t.upload_time,'%Y-%m-%d')  = DATE_FORMAT(NOW(),'%Y-%m-%d') ");
		sql.append(" AND project_id = ?");
		return jdbcTemplate.queryForList(sql.toString(), projectId);
	}

	@Override
	public List<Map<String, String>> getHistoryStatistics(String monitorSitesId, String uploadTimeBegin,
			String uploadTimeEnd, String searchTimeNode) {
		return atiDeviceDataRecordHistoryDao.getHistoryStatistics(monitorSitesId, uploadTimeBegin, uploadTimeEnd,
				searchTimeNode);
	}

	@Override
	public List<Map<String, String>> findCompareData(String monitorSitesId, String uploadTimeBegin,
			String uploadTimeEnd) {
		return atiDeviceDataRecordHistoryDao.findCompareData(monitorSitesId, uploadTimeBegin, uploadTimeEnd);
	}

	@Override
	public List<Map<String, Object>> findMaps(String monitorSitesId, String uploadTimeBegin, String uploadTimeEnd) {
		StringBuilder sql = new StringBuilder(
				"SELECT t.monitor_sites_name,t.device_upload_data,t.is_group,t.group_data,t.upload_time ");
		sql.append(" FROM ati_device_data_record_history t ");
		sql.append(" WHERE t.monitor_sites_id = :monitorSitesId ");
		sql.append(" AND t.upload_time >= :uploadTimeBegin ");
		sql.append(" AND t.upload_time <= :uploadTimeEnd ");

		return jdbcTemplate.queryForList(sql.toString(), monitorSitesId, uploadTimeBegin, uploadTimeEnd);
	}

	@Override
	public List<AtiDeviceDataRecordHistory> findByProjectIdAndDealStatus(String projectId, String dealState) {
		// TODO Auto-generated method stub
		return atiDeviceDataRecordHistoryDao.findByProjectIdAndDealStatus(projectId, dealState);
	}

	@Override
	public BigInteger findByProjectIdAndDealStatusCountAndRunningState(String projectId, String dealState,
			String runningState) {
		// TODO Auto-generated method stub
		return atiDeviceDataRecordHistoryDao.findByProjectIdAndDealStatusCountAndRunningStateCount(runningState, dealState, projectId);
	}

	

	

}
