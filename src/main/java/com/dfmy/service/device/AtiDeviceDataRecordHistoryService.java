package com.dfmy.service.device;

import java.math.BigInteger;
import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;

import com.dfmy.entity.device.AtiDeviceDataRecordHistory;

public interface AtiDeviceDataRecordHistoryService {

    /**
     *
     * @param monitorSitesId 监测点id
     * @param uploadTimeBegin 上传时间开始
     * @param uploadTimeEnd 上传时间结束
     * @return
     */
    List<Map<String,String>> findCompareDataByUploadDate(String monitorSitesId, String uploadTimeBegin, String uploadTimeEnd);
    /*
     * 
     */
    List<Map<String, Object>> findMaps(String monitorSitesId,String uploadTimeBegin,String uploadTimeEnd);
    List<Map<String, String>> findCompareData(String monitorSitesId,String uploadTimeBegin,String uploadTimeEnd);
    List<AtiDeviceDataRecordHistory> findByDealStatusAndWarnLevel(String dealStatus,Integer warnLevel);
    Page<AtiDeviceDataRecordHistory> pageList(int pageNumber, int pageSize, String sortColom, final AtiDeviceDataRecordHistory atiDeviceDataRecordHistory);
    AtiDeviceDataRecordHistory findById (String id);
    void save(AtiDeviceDataRecordHistory atiDeviceDataRecordHistory);
    
    List<AtiDeviceDataRecordHistory> findByPojectId(String projectId);
    
    List<AtiDeviceDataRecordHistory> findmonitorSitesData(String projectId,String monitorTypeId,String monitorParamId);
    
	List<AtiDeviceDataRecordHistory> findReportData(String projectId, String monitorParamId,String monitorSites,String uploadTimeBegin,String uploadTimeEnd);

	/**
	 * 根据项目id获取所有未处理的异常数据
	 * @param projectId
	 * @return
	 */
	public List<Map<String, Object>> getAllNoDealErrorData(String projectId);

    List<Map<String,String>> getHistoryStatistics(String monitorSitesId, String uploadTimeBegin, String uploadTimeEndString,String  searchTimeNode);
    
    List<AtiDeviceDataRecordHistory> findByProjectIdAndDealStatus(String projectId,String dealState);
    
    BigInteger findByProjectIdAndDealStatusCountAndRunningState(String projectId,String dealState,String runningState);
    
}
