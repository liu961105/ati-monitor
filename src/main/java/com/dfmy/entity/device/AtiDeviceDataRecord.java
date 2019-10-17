package com.dfmy.entity.device;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

/**
 * AtiDeviceDataRecord entity. 设备采集实时数据实体（最新数据
 */
@Entity
@Table(name = "ati_device_data_record")

public class AtiDeviceDataRecord implements java.io.Serializable {

	private static final long serialVersionUID = 1L;
	private String id;
	private String projectId;
	private String projectName;
	private String structId;
	private String structName;
	private String monitorTypeId;
	private String monitorTypeName;
	private String monitorParamId;
	private String monitorParamName;
	private String deviceId;
	private String deviceName;
	private String deviceCode;
	private String deviceUploadData;
	private String unit;
	private String channelid;
	private String monitorSitesId;
	private String monitorSitesName;
	private String temperature;
	private String uploadTime;
	private String runningState;
	private String warnMessage;
	private Integer warnLevel;
	private String dealStatus;
	private String dealTime;
	private String dealUser;
	private String dealMessage;
	private String state;
	private String fft;
	private String fftSize;
	private String dataSize;
	private String sampleRate;
	private String deviceUploadDataSpare;
	private String unitSpare;
	
	
	/**
	 * 是否组传输数据
	 */
	private String isGroup;

	/**
	 * 组传输数据
	 */
	private String groupData;

	@Id
	@GeneratedValue(generator = "generator")
	@GenericGenerator(name = "generator", strategy = "uuid.hex")
	@Column(name = "id", unique = true, nullable = false, length = 32)

	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
	}

	@Column(name = "project_id", length = 32)

	public String getProjectId() {
		return this.projectId;
	}

	public void setProjectId(String projectId) {
		this.projectId = projectId;
	}

	@Column(name = "struct_id", length = 32)
	public String getStructId() {
		return structId;
	}

	public void setStructId(String structId) {
		this.structId = structId;
	}

	@Column(name = "struct_name", length = 50)
	public String getStructName() {
		return structName;
	}

	public void setStructName(String structName) {
		this.structName = structName;
	}

	@Column(name = "monitor_type_id", length = 32)
	public String getMonitorTypeId() {
		return monitorTypeId;
	}

	public void setMonitorTypeId(String monitorTypeId) {
		this.monitorTypeId = monitorTypeId;
	}

	@Column(name = "monitor_type_name", length = 50)
	public String getMonitorTypeName() {
		return monitorTypeName;
	}

	public void setMonitorTypeName(String monitorTypeName) {
		this.monitorTypeName = monitorTypeName;
	}

	@Column(name = "monitor_param_id", length = 32)

	public String getMonitorParamId() {
		return this.monitorParamId;
	}

	public void setMonitorParamId(String monitorParamId) {
		this.monitorParamId = monitorParamId;
	}

	@Column(name = "device_upload_data")

	public String getDeviceUploadData() {
		return deviceUploadData;
	}

	public void setDeviceUploadData(String deviceUploadData) {
		this.deviceUploadData = deviceUploadData;
	}

	@Column(name = "unit", length = 10)

	public String getUnit() {
		return this.unit;
	}

	public void setUnit(String unit) {
		this.unit = unit;
	}

	@Column(name = "channelid", length = 10)
	public String getChannelid() {
		return channelid;
	}

	public void setChannelid(String channelid) {
		this.channelid = channelid;
	}

	@Column(name = "monitor_sites_id", length = 32)

	public String getMonitorSitesId() {
		return this.monitorSitesId;
	}

	public void setMonitorSitesId(String monitorSitesId) {
		this.monitorSitesId = monitorSitesId;
	}

	@Column(name = "monitor_sites_name", length = 20)

	public String getMonitorSitesName() {
		return this.monitorSitesName;
	}

	public void setMonitorSitesName(String monitorSitesName) {
		this.monitorSitesName = monitorSitesName;
	}

	@Column(name = "temperature", length = 50)
	public String getTemperature() {
		return temperature;
	}

	public void setTemperature(String temperature) {
		this.temperature = temperature;
	}

	@Column(name = "upload_time", length = 19)

	public String getUploadTime() {
		return this.uploadTime;
	}

	public void setUploadTime(String uploadTime) {
		this.uploadTime = uploadTime;
	}

	@Column(name = "running_state", length = 1)

	public String getRunningState() {
		return this.runningState;
	}

	public void setRunningState(String runningState) {
		this.runningState = runningState;
	}

	@Column(name = "warn_message", length = 20)

	public String getWarnMessage() {
		return this.warnMessage;
	}

	public void setWarnMessage(String warnMessage) {
		this.warnMessage = warnMessage;
	}

	@Column(name = "warn_level")

	public Integer getWarnLevel() {
		return this.warnLevel;
	}

	public void setWarnLevel(Integer warnLevel) {
		this.warnLevel = warnLevel;
	}

	@Column(name = "deal_status", length = 1)

	public String getDealStatus() {
		return this.dealStatus;
	}

	public void setDealStatus(String dealStatus) {
		this.dealStatus = dealStatus;
	}

	@Column(name = "deal_time", length = 19)

	public String getDealTime() {
		return this.dealTime;
	}

	public void setDealTime(String dealTime) {
		this.dealTime = dealTime;
	}

	@Column(name = "deal_user", length = 20)

	public String getDealUser() {
		return this.dealUser;
	}

	public void setDealUser(String dealUser) {
		this.dealUser = dealUser;
	}

	@Column(name = "deal_message")

	public String getDealMessage() {
		return this.dealMessage;
	}

	public void setDealMessage(String dealMessage) {
		this.dealMessage = dealMessage;
	}

	@Column(name = "state", length = 1)

	public String getState() {
		return this.state;
	}

	public void setState(String state) {
		this.state = state;
	}

	@Column(name = "project_name", length = 20)

	public String getProjectName() {
		return this.projectName;
	}

	public void setProjectName(String projectName) {
		this.projectName = projectName;
	}

	@Column(name = "monitor_param_name", length = 20)

	public String getMonitorParamName() {
		return this.monitorParamName;
	}

	public void setMonitorParamName(String monitorParamName) {
		this.monitorParamName = monitorParamName;
	}

	@Column(name = "device_id", length = 32)

	public String getDeviceId() {
		return this.deviceId;
	}

	public void setDeviceId(String deviceId) {
		this.deviceId = deviceId;
	}

	@Column(name = "device_name", length = 20)

	public String getDeviceName() {
		return this.deviceName;
	}

	public void setDeviceName(String deviceName) {
		this.deviceName = deviceName;
	}

	@Column(name = "device_code", length = 32)

	public String getDeviceCode() {
		return this.deviceCode;
	}

	public void setDeviceCode(String deviceCode) {
		this.deviceCode = deviceCode;
	}

	@Column(name = "is_group", length = 1)
	public String getIsGroup() {
		return isGroup;
	}

	public void setIsGroup(String isGroup) {
		this.isGroup = isGroup;
	}

	@Column(name = "group_data")
	public String getGroupData() {
		return groupData;
	}

	public void setGroupData(String groupData) {
		this.groupData = groupData;
	}

	@Column(name = "fft")
	public String getFft() {
		return fft;
	}

	public void setFft(String fft) {
		this.fft = fft;
	}

	@Column(name = "fft_size", length = 10)
	public String getFftSize() {
		return fftSize;
	}

	public void setFftSize(String fftSize) {
		this.fftSize = fftSize;
	}
	
	@Column(name = "data_size", length = 10)
	public String getDataSize() {
		return dataSize;
	}

	public void setDataSize(String dataSize) {
		this.dataSize = dataSize;
	}

	@Column(name = "sample_rate", length = 10)
	public String getSampleRate() {
		return sampleRate;
	}

	public void setSampleRate(String sampleRate) {
		this.sampleRate = sampleRate;
	}

	@Column(name = "device_upload_data_spare")
	public String getDeviceUploadDataSpare() {
		return deviceUploadDataSpare;
	}

	public void setDeviceUploadDataSpare(String deviceUploadDataSpare) {
		this.deviceUploadDataSpare = deviceUploadDataSpare;
	}

	@Column(name = "unit_spare", length = 10)
	public String getUnitSpare() {
		return unitSpare;
	}

	public void setUnitSpare(String unitSpare) {
		this.unitSpare = unitSpare;
	}
	
}