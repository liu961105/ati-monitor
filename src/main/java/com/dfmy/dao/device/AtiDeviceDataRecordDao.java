package com.dfmy.dao.device;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.dfmy.entity.device.AtiDeviceDataRecord;

public interface AtiDeviceDataRecordDao
		extends PagingAndSortingRepository<AtiDeviceDataRecord, String>, JpaSpecificationExecutor<AtiDeviceDataRecord> {

	@Modifying
	@Query("update AtiDeviceDataRecord t set t.deviceUploadData = ?1,t.unit = ?2,t.groupData = ?3,t.fft = ?4,t.fftSize = ?5,t.dataSize = ?6,t.sampleRate = ?7,t.temperature = ?8,t.unitSpare = ?9,t.warnLevel = ?10,t.runningState = ?11,t.dealStatus = ?12,t.uploadTime = ?13 where t.deviceId = ?14 and t.monitorParamId = ?15 and t.monitorSitesId = ?16 and t.projectId = ?17")
	public void updateNewData(String deviceUploadData,String unit,String groupData, String fft, String fftSize, String dataSize,
			String sampleRate,String temperature,String unit2,Integer warnLevel,String runningState,String dealState,String uploadTime,String deviceId,String monitorParamId,String monitorSiteId,String projectId);
	
	@Query("select t from AtiDeviceDataRecord t where t.deviceId = ?1 and t.monitorParamId = ?2 and t.monitorSitesId = ?3 and t.projectId = ?4 ")
	public AtiDeviceDataRecord findIsExist(String deviceId,String monitorParamId,String monitorSiteId,String projectId);
}
