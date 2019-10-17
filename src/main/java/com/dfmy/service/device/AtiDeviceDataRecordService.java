package com.dfmy.service.device;

import java.util.List;
import java.util.Map;

import com.dfmy.entity.device.AtiDeviceDataRecord;

public interface AtiDeviceDataRecordService {

	/**
	 * 获取项目下某监测参数的设备实时采集的数据
	 * 
	 * @param projectId
	 * @param monitorParamId
	 * @return
	 */
	public List<Map<String, Object>> getRealTimeDatas(String projectId, String monitorParamId);

	/**
	 * 根据条件更新最新数据
	 * 
	 * @param deviceUploadData
	 *            上传值
	 * @param deviceId
	 *            设备id
	 * @param monitorParamId
	 *            监测参数id
	 * @param monitorSiteId
	 *            监测点位id
	 * @param projectId
	 *            项目id
	 */
	public void updateNewData(String deviceUploadData,String unit, String groupData, String fft, String fftSize, String dataSize,
			String sampleRate, String temperature,String unit2, Integer level,String runningState,String dealState,String uploadTime, String deviceId, String monitorParamId, String monitorSiteId,
			String projectId);

	/**
	 * 验证测点数据是否已经存在
	 * 
	 * @param deviceId
	 * @param monitorParamId
	 * @param monitorSiteId
	 * @param projectId
	 * @return
	 */
	public AtiDeviceDataRecord findIsExist(String deviceId, String monitorParamId, String monitorSiteId,
			String projectId);

	/**
	 * 保存
	 * 
	 * @param atiDeviceDataRecord
	 * @return
	 */
	public AtiDeviceDataRecord save(AtiDeviceDataRecord atiDeviceDataRecord);
}
