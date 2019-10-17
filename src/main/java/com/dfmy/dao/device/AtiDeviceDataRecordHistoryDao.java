package com.dfmy.dao.device;

import com.dfmy.entity.device.AtiDeviceDataRecordHistory;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import java.math.BigInteger;
import java.util.List;
import java.util.Map;

public interface AtiDeviceDataRecordHistoryDao extends PagingAndSortingRepository<AtiDeviceDataRecordHistory, String>,
        JpaSpecificationExecutor<AtiDeviceDataRecordHistory> {

    /**
     * @param monitorSitesId 监测点id
     * @param uploadTimeBegin 上传时间开始
     * @param uploadTimeEnd 上传时间结束
     * @return
     */
    @Query("select new map(monitorSitesName as monitorSitesName,deviceUploadDataSpare as deviceUploadDataSpare, deviceUploadData as deviceUploadData,uploadTime as uploadTime,monitorSitesId as monitorSitesId) from AtiDeviceDataRecordHistory where monitorSitesId = :monitorSitesId and uploadTime >= :uploadTimeBegin and uploadTime <= :uploadTimeEnd order by uploadTime")
    List<Map<String,String>> getCompareDataByUploadDate(@Param("monitorSitesId") String monitorSitesId, @Param("uploadTimeBegin")String uploadTimeBegin, @Param("uploadTimeEnd")String uploadTimeEnd);
    List<AtiDeviceDataRecordHistory> findByDealStatusAndWarnLevel(String dealStatus,Integer warnLevel);
    
	List<AtiDeviceDataRecordHistory> findByProjectId(String projectId);
	
	@Query("select t from AtiDeviceDataRecordHistory t where t.projectId=?1 and t.monitorTypeId = ?2 and t.monitorParamId = ?3")	
	List<AtiDeviceDataRecordHistory> findmonitorSitesData(String projectId, String monitorTypeId,
			String monitorParamId);

	List<AtiDeviceDataRecordHistory> findByProjectIdAndMonitorParamId(String projectId,String monitorParamId);
	
	@Query("select t from AtiDeviceDataRecordHistory t where t.projectId = ?1  AND t.monitorParamId = ?2 AND t.monitorSitesId = ?3 AND t.uploadTime >= ?4 and uploadTime <= ?5 ")
	List<AtiDeviceDataRecordHistory> findReportData(String projectId,
			String monitorParamId, String monitorSites,String uploadTimeBegin,String uploadTimeEnd);

	@Query("select new map(monitorSitesId as monitorSitesId,max(groupData) as groupData,max(deviceUploadData) as uploadData,substring(uploadTime,1,13) as uploadTime) from AtiDeviceDataRecordHistory where monitorSitesId = :monitorSitesId and uploadTime >= :uploadTimeBegin and uploadTime <= :uploadTimeEnd and substring(uploadTime,12,2) = :searchTimeNode  group by monitorSitesId, substring(uploadTime,1,13) order by uploadTime")
	List<Map<String,String>> getHistoryStatistics(@Param("monitorSitesId") String monitorSitesId, @Param("uploadTimeBegin")String uploadTimeBegin, @Param("uploadTimeEnd")String uploadTimeEnd,@Param("searchTimeNode")String searchTimeNode);
	
	@Query("select new map(monitorSitesName as monitorSitesName,deviceUploadDataSpare as deviceUploadDataSpare, deviceUploadData as deviceUploadData,isGroup as isGroup, groupData as groupData,uploadTime as uploadTime,monitorSitesId as monitorSitesId,fft as fft,fftSize as fftSize,sampleRate as sampleRate) from AtiDeviceDataRecordHistory where monitorSitesId = :monitorSitesId and uploadTime >= :uploadTimeBegin and uploadTime <= :uploadTimeEnd order by uploadTime ")
	List<Map<String, String>> findCompareData(@Param("monitorSitesId") String monitorSitesId, @Param("uploadTimeBegin")String uploadTimeBegin, @Param("uploadTimeEnd")String uploadTimeEnd);
	
	List<AtiDeviceDataRecordHistory> findByProjectIdAndDealStatus(String projectId,String dealState);
	
	@Query(nativeQuery=true,value="select count(1) from ati_device_data_record_history where running_state = :runningState and deal_status = :dealState and project_id = :projectId")
	BigInteger findByProjectIdAndDealStatusCountAndRunningStateCount(@Param("runningState") String runningState,@Param("dealState") String dealState,@Param("projectId")String projectId);
}
