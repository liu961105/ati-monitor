package com.dfmy.service.modelexport;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;

import com.dfmy.entity.device.AtiDeviceDataRecordHistory;

public interface ModelExportService {

	public List<Map<String, Object>> getTitle(String projectId,String monitorParamId,String monitorSitesId);

	public Page<AtiDeviceDataRecordHistory> pageList(int parseInt, int pAGESIZE, String sortOrder,
			AtiDeviceDataRecordHistory atiDeviceDataRecordHistory, String uploadTimeBegin, String uploadTimeEnd);
	
	List<AtiDeviceDataRecordHistory> findReportData(String projectId, String monitorParamId,String monitorSites,String uploadTimeBegin,String uploadTimeEnd);
}
