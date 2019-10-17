package com.dfmy.service.device.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dfmy.dao.device.AtiDeviceDataRecordDao;
import com.dfmy.entity.device.AtiDeviceDataRecord;
import com.dfmy.service.device.AtiDeviceDataRecordService;

@Service
@Transactional
public class AtiDeviceDataRecordServiceImpl implements AtiDeviceDataRecordService {

	@Autowired
	private AtiDeviceDataRecordDao atiDeviceDataRecordDao;

	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Override
	public List<Map<String, Object>> getRealTimeDatas(String projectId, String monitorParamId) {
		StringBuilder sql = new StringBuilder(
				"SELECT d.id,a.project_id,e.project_name, d.struct_id,d.struct_name,d.monitor_type_id,d.monitor_type_name,d.monitor_param_id,d.monitor_param_name,d.device_id,f.device_code,f.device_name,d.device_upload_data,d.unit,d.device_upload_data_spare,d.unit_spare,d.monitor_sites_id,g.name AS monitor_sites_name,d.upload_time,d.running_state,d.warn_message,d.warn_level,d.deal_status,d.deal_time,d.deal_user,d.deal_message,d.state,d.temperature ");
		sql.append(" FROM ati_monitor_project_device a ");
		List<String> params = new ArrayList<String>();
		sql.append(
				" LEFT JOIN (SELECT n.* FROM ati_monitor_param_device n WHERE n.param_id = ?)b ON a.param_device_id = b.id ");
		params.add(monitorParamId);

		sql.append(
				" LEFT JOIN (SELECT k.* FROM ati_project_monitor_sites k WHERE k.project_id = ?) c ON c.project_id = a.project_id AND c.monitor_param_id = b.param_id AND c.device_id = b.device_id ");
		params.add(projectId);

		sql.append(
				" LEFT JOIN (SELECT m.* FROM ati_device_data_record m WHERE m.monitor_param_id = ? AND m.project_id = ?)d ON d.project_id = a.project_id AND d.monitor_param_id = b.param_id AND d.monitor_sites_id = c.id ");
		params.add(monitorParamId);
		params.add(projectId);

		sql.append(" LEFT JOIN ati_project e ON d.project_id = e.id ");
		sql.append(" LEFT JOIN ati_device f ON d.device_id = f.id ");
		sql.append(" LEFT JOIN ati_project_monitor_sites g ON d.monitor_sites_id = g.id");

		sql.append(" WHERE d.id IS NOT NULL AND a.project_id = ? ");
		params.add(projectId);

		return jdbcTemplate.queryForList(sql.toString(), params.toArray());
	}

	@Override
	public void updateNewData(String deviceUploadData,String unit, String groupData, String fft, String fftSize, String dataSize,
			String sampleRate, String temperature,String unit2, Integer level,String runningState,String dealState,String uploadTime, String deviceId, String monitorParamId, String monitorSiteId,
			String projectId) {
		atiDeviceDataRecordDao.updateNewData(deviceUploadData,unit, groupData, fft, fftSize, dataSize, sampleRate,
				temperature,unit2, level,runningState,dealState,uploadTime,deviceId, monitorParamId, monitorSiteId, projectId);
	}

	@Override
	public AtiDeviceDataRecord findIsExist(String deviceId, String monitorParamId, String monitorSiteId,
			String projectId) {
		return atiDeviceDataRecordDao.findIsExist(deviceId, monitorParamId, monitorSiteId, projectId);
	}

	@Override
	public AtiDeviceDataRecord save(AtiDeviceDataRecord atiDeviceDataRecord) {
		return atiDeviceDataRecordDao.save(atiDeviceDataRecord);
	}
}
