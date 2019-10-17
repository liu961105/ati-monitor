package com.dfmy.entity.device;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;

/**
 * 数据推送记录表【此表为全量数据】
 */
@Entity
@Table(name="ati_device_data_record_history")
public class AtiDeviceDataRecordHistory {

	/**
	 * 主键
	 */
	@Id
	@GeneratedValue(generator = "system-uuid")
	@GenericGenerator(name = "system-uuid", strategy = "uuid.hex")
	@Column(name = "id", nullable = false)
	private String id;

	/**
	 * 项目id
	 */
	private String projectId;
	
	/**
	 * 结构类型id
	 */
	private String structId;
	
	/**
	 * 结构类型名称
	 */
	private String structName;
	
	/**
	 * 监测类型id
	 */
	private String monitorTypeId;
	
	/**
	 * 监测类型名称
	 */
	private String monitorTypeName;

	/**
	 * 监测参数id
	 */
	private String monitorParamId;

	/**
	 * 设备上传值
	 */
	private String deviceUploadData;

	/**
	 * 单位
	 */
	private String unit;
	
	/**
	 * 设备插槽编号
	 */
	private String channelid;

	/**
	 * 监测点位id
	 */
	private String monitorSitesId;

	/**
	 * 监测点位名称
	 */
	private String monitorSitesName;
	
	/**
	 * 附带温度
	 */
	private String temperature;

	/**
	 * 上传时间
	 */
	private String uploadTime;

	/**
	 * 1正常 2预警
	 */
	private String runningState;

	/**
	 * 预警信息
	 */
	private String warnMessage;

	/**
	 * 预警等级
	 */
	private Integer warnLevel;

	/**
	 * 处理状态 1已处理 0未处理
	 */
	private String dealStatus;

	/**
	 * 处理时间
	 */
	private String dealTime;

	/**
	 * 处理人员
	 */
	private String dealUser;

	/**
	 * 处理信息
	 */
	private String dealMessage;

	/**
	 * 数据状态 1生效 0未生效
	 */
	private String state;

	/**
	 * 项目名称
	 */
	private String projectName;

	/**
	 * 参数名称
	 */
	private String monitorParamName;

	/**
	 * 设备id
	 */
	private String deviceId;

	/**
	 * 是否组传输数据
	 */
	private String isGroup;

	/**
	 * 组传输数据
	 */
	private String groupData;
    
	/**
	 * FFT计算结果数据
	 */
	private String fft;
	
	/**
	 * FFT计算结果数据长度
	 */
	private String fftSize;
	
	/**
	 * 测量数据长度
	 */
	private String dataSize;
	
	/**
	 * 采样频率
	 */
	private String sampleRate;

	/**
	 * 设备名称
	 */
	private String deviceName;


	/**
	 * 设备上传值2（备用字段）
	 */
	private String deviceUploadDataSpare;
	
	/**
	 * 设备上传值2单位
	 */
	private String unitSpare;
	
	/**
	 * 设备编码
	 */
	private String deviceCode;

	@Transient
	private String monitorSitesIds;

	public String getMonitorSitesIds() {
		return monitorSitesIds;
	}

	public void setMonitorSitesIds(String monitorSitesIds) {
		this.monitorSitesIds = monitorSitesIds;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getProjectId() {
		return projectId;
	}

	public void setProjectId(String projectId) {
		this.projectId = projectId;
	}
	
	public String getStructId() {
		return structId;
	}

	public void setStructId(String structId) {
		this.structId = structId;
	}
	
	public String getStructName() {
		return structName;
	}

	public void setStructName(String structName) {
		this.structName = structName;
	}
	
	public String getMonitorTypeId() {
		return monitorTypeId;
	}

	public void setMonitorTypeId(String monitorTypeId) {
		this.monitorTypeId = monitorTypeId;
	}

	public String getMonitorTypeName() {
		return monitorTypeName;
	}

	public void setMonitorTypeName(String monitorTypeName) {
		this.monitorTypeName = monitorTypeName;
	}

	public String getMonitorParamId() {
		return monitorParamId;
	}

	public void setMonitorParamId(String monitorParamId) {
		this.monitorParamId = monitorParamId;
	}

	public String getDeviceUploadData() {
		return deviceUploadData;
	}

	public void setDeviceUploadData(String deviceUploadData) {
		this.deviceUploadData = deviceUploadData;
	}

	public String getUnit() {
		return unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}
	

	public String getChannelid() {
		return channelid;
	}

	public void setChannelid(String channelid) {
		this.channelid = channelid;
	}

	public String getMonitorSitesId() {
		return monitorSitesId;
	}

	public void setMonitorSitesId(String monitorSitesId) {
		this.monitorSitesId = monitorSitesId;
	}

	public String getMonitorSitesName() {
		return monitorSitesName;
	}

	public void setMonitorSitesName(String monitorSitesName) {
		this.monitorSitesName = monitorSitesName;
	}

	public String getTemperature() {
		return temperature;
	}

	public void setTemperature(String temperature) {
		this.temperature = temperature;
	}

	public String getUploadTime() {
		return uploadTime;
	}

	public void setUploadTime(String uploadTime) {
		this.uploadTime = uploadTime;
	}

	public String getRunningState() {
		return runningState;
	}

	public void setRunningState(String runningState) {
		this.runningState = runningState;
	}

	public String getWarnMessage() {
		return warnMessage;
	}

	public void setWarnMessage(String warnMessage) {
		this.warnMessage = warnMessage;
	}

	public Integer getWarnLevel() {
		return warnLevel;
	}

	public void setWarnLevel(Integer warnLevel) {
		this.warnLevel = warnLevel;
	}

	public String getDealStatus() {
		return dealStatus;
	}

	public void setDealStatus(String dealStatus) {
		this.dealStatus = dealStatus;
	}

	public String getDealTime() {
		return dealTime;
	}

	public void setDealTime(String dealTime) {
		this.dealTime = dealTime;
	}

	public String getDealUser() {
		return dealUser;
	}

	public void setDealUser(String dealUser) {
		this.dealUser = dealUser;
	}

	public String getDealMessage() {
		return dealMessage;
	}

	public void setDealMessage(String dealMessage) {
		this.dealMessage = dealMessage;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getProjectName() {
		return projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	public String getMonitorParamName() {
		return monitorParamName;
	}

	public void setMonitorParamName(String monitorParamName) {
		this.monitorParamName = monitorParamName;
	}

	public String getDeviceId() {
		return deviceId;
	}

	public void setDeviceId(String deviceId) {
		this.deviceId = deviceId;
	}

	public String getDeviceName() {
		return deviceName;
	}

	public void setDeviceName(String deviceName) {
		this.deviceName = deviceName;
	}

	public String getDeviceCode() {
		return this.deviceCode;

	}

	public void setDeviceCode(String deviceCode) {
		this.deviceCode = deviceCode;
	}

	public String getIsGroup() {
		return isGroup;
	}

	public void setIsGroup(String isGroup) {
		this.isGroup = isGroup;
	}

	public String getGroupData() {
		return groupData;
	}

	public void setGroupData(String groupData) {
		this.groupData = groupData;
	}

	public String getFft() {
		return fft;
	}

	public void setFft(String fft) {
		this.fft = fft;
	}

	public String getFftSize() {
		return fftSize;
	}

	public void setFftSize(String fftSize) {
		this.fftSize = fftSize;
	}

	public String getDataSize() {
		return dataSize;
	}

	public void setDataSize(String dataSize) {
		this.dataSize = dataSize;
	}

	public String getSampleRate() {
		return sampleRate;
	}

	public void setSampleRate(String sampleRate) {
		this.sampleRate = sampleRate;
	}

	public String getDeviceUploadDataSpare() {
		return deviceUploadDataSpare;
	}

	public void setDeviceUploadDataSpare(String deviceUploadDataSpare) {
		this.deviceUploadDataSpare = deviceUploadDataSpare;
	}

	public String getUnitSpare() {
		return unitSpare;
	}

	public void setUnitSpare(String unitSpare) {
		this.unitSpare = unitSpare;
	}
}
