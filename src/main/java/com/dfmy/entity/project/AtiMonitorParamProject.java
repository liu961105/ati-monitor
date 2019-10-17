package com.dfmy.entity.project;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import org.hibernate.annotations.GenericGenerator;

/**
 * AtiMonitorParamProject entity. 项目关联监测参数及设备实体
 */
@Entity
@Table(name = "ati_monitor_param_project")

public class AtiMonitorParamProject implements java.io.Serializable {
	private static final long serialVersionUID = 1L;
	private String id;
	private String structId;
	private String projectId;
	private String monitorTypeId;
	private String monitorItemId;
	private String monitorParamId;
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

	@Column(name = "struct_id", length = 32)

	public String getStructId() {
		return this.structId;
	}

	public void setStructId(String structId) {
		this.structId = structId;
	}

	@Column(name = "project_id", length = 32)

	public String getProjectId() {
		return this.projectId;
	}

	public void setProjectId(String projectId) {
		this.projectId = projectId;
	}

	@Column(name = "monitor_type_id", length = 32)

	public String getMonitorTypeId() {
		return this.monitorTypeId;
	}

	public void setMonitorTypeId(String monitorTypeId) {
		this.monitorTypeId = monitorTypeId;
	}

	@Column(name = "monitor_item_id", length = 32)

	public String getMonitorItemId() {
		return this.monitorItemId;
	}

	public void setMonitorItemId(String monitorItemId) {
		this.monitorItemId = monitorItemId;
	}

	@Column(name = "monitor_param_id", length = 32)

	public String getMonitorParamId() {
		return this.monitorParamId;
	}

	public void setMonitorParamId(String monitorParamId) {
		this.monitorParamId = monitorParamId;
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