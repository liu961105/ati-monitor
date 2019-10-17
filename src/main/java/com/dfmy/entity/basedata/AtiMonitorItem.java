package com.dfmy.entity.basedata;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * AtiMonitorItem entity. 监测项实体
 */
@Entity
@Table(name = "ati_monitor_item")

public class AtiMonitorItem implements java.io.Serializable {

	private static final long serialVersionUID = 1L;
	private String id;
	/* private String typeId; */
	private AtiMonitorType atiMonitorType;
	private String code;
	private String name;
	private String createUser;
	private String updateUser;
	private String createTime;
	private String updateTime;
	private String state;

	private List<AtiMonitorParam> atiMonitorParam;

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

	/*
	 * @Column(name = "type_id", length = 32)
	 * 
	 * public String getTypeId() { return this.typeId; }
	 * 
	 * public void setTypeId(String typeId) { this.typeId = typeId; }
	 */

	@ManyToOne(cascade = { CascadeType.REFRESH, CascadeType.PERSIST })
	@JoinColumn(name = "type_id")
	@NotFound(action = NotFoundAction.IGNORE)
	public AtiMonitorType getAtiMonitorType() {
		return atiMonitorType;
	}

	public void setAtiMonitorType(AtiMonitorType atiMonitorType) {
		this.atiMonitorType = atiMonitorType;
	}

	@Column(name = "code", length = 20)

	public String getCode() {
		return this.code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	@Column(name = "name", length = 50)

	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "create_user", length = 50)

	public String getCreateUser() {
		return this.createUser;
	}

	public void setCreateUser(String createUser) {
		this.createUser = createUser;
	}

	@Column(name = "update_user", length = 20)

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

	@OneToMany(mappedBy = "atiMonitorItem", targetEntity = AtiMonitorParam.class)
	@JsonIgnore
	public List<AtiMonitorParam> getAtiMonitorParam() {
		return atiMonitorParam;
	}

	public void setAtiMonitorParam(List<AtiMonitorParam> atiMonitorParam) {
		this.atiMonitorParam = atiMonitorParam;
	}

}