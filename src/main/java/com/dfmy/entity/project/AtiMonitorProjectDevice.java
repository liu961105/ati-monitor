package com.dfmy.entity.project;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import org.hibernate.annotations.GenericGenerator;

/**
 * AtiMonitorProjectDevice entity. 项目关联设备表实体
 */
@Entity
@Table(name = "ati_monitor_project_device")

public class AtiMonitorProjectDevice implements java.io.Serializable {

	private static final long serialVersionUID = 1L;
	private String id;
	private String projectId;
	private String paramProjectId;
	private String paramDeviceId;
	private String createUser;
	private String updateUser;
	private String createTime;
	private String updateTime;
	private String state;

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

	@Column(name = "project_id")
	public String getProjectId() {
		return projectId;
	}

	public void setProjectId(String projectId) {
		this.projectId = projectId;
	}
	
	@Column(name = "param_project_id")
	public String getParamProjectId() {
		return paramProjectId;
	}

	public void setParamProjectId(String paramProjectId) {
		this.paramProjectId = paramProjectId;
	}

	@Column(name = "param_device_id")
	public String getParamDeviceId() {
		return paramDeviceId;
	}

	public void setParamDeviceId(String paramDeviceId) {
		this.paramDeviceId = paramDeviceId;
	}
	

	@Column(name = "create_user", length = 50)

	public String getCreateUser() {
		return this.createUser;
	}

	public void setCreateUser(String createUser) {
		this.createUser = createUser;
	}

	@Column(name = "update_user", length = 50)

	public String getUpdateUser() {
		return this.updateUser;
	}

	public void setUpdateUser(String updateUser) {
		this.updateUser = updateUser;
	}

	@Column(name = "create_time", length = 19)

	public String getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	@Column(name = "update_time", length = 19)

	public String getUpdateTime() {
		return this.updateTime;
	}

	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}

	@Column(name = "state", length = 1)

	public String getState() {
		return this.state;
	}

	public void setState(String state) {
		this.state = state;
	}

}