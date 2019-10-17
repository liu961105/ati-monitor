package com.dfmy.entity.sys;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * SysParam entity
 */
@Entity
@Table(name = "sys_param")

public class SysParam implements java.io.Serializable {

	private static final long serialVersionUID = 1L;
	private String paramId;
	private String paramCode;
	private String paramName;
	private Integer orderNum;
	private SysParam parentParam;
	private List<SysParam> childParam = new ArrayList<SysParam>();
	private String createUser;
	private String createTime;
	private String updateUser;
	private String updateTime;
	private String status;	
	private String pName;

	
	@Id
	@GeneratedValue(generator = "system-uuid")
	@GenericGenerator(name = "system-uuid", strategy = "uuid.hex")
	@Column(name = "param_id", unique = true, nullable = false, length = 32)
	public String getParamId() {
		return this.paramId;
	}

	public void setParamId(String paramId) {
		this.paramId = paramId;
	}

	@Column(name = "param_code", length = 32)

	public String getParamCode() {
		return this.paramCode;
	}

	public void setParamCode(String paramCode) {
		this.paramCode = paramCode;
	}

	@Column(name = "param_name", length = 128)

	public String getParamName() {
		return this.paramName;
	}

	public void setParamName(String paramName) {
		this.paramName = paramName;
	}

	@Column(name = "order_num")

	public Integer getOrderNum() {
		return this.orderNum;
	}

	public void setOrderNum(Integer orderNum) {
		this.orderNum = orderNum;
	}

	@ManyToOne(cascade = {CascadeType.REFRESH},fetch = FetchType.LAZY)
	@JoinColumn(name = "parent_code")
	@JsonIgnoreProperties(value = { "hibernateLazyInitializer", "handler" })
	public SysParam getParentParam() {
		return parentParam;
	}

	public void setParentParam(SysParam parentParam) {
		this.parentParam = parentParam;
	}

	@OneToMany(targetEntity = SysParam.class, cascade = { CascadeType.PERSIST,CascadeType.REFRESH}, fetch = FetchType.LAZY, mappedBy = "parentParam")
	@JsonIgnore
	public List<SysParam> getChildParam() {
		return childParam;
	}

	public void setChildParam(List<SysParam> childParam) {
		this.childParam = childParam;
	}

	@Column(name = "create_user", length = 32)

	public String getCreateUser() {
		return this.createUser;
	}

	public void setCreateUser(String createUser) {
		this.createUser = createUser;
	}

	@Column(name = "create_time", length = 19)

	public String getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	@Column(name = "update_user", length = 32)

	public String getUpdateUser() {
		return this.updateUser;
	}

	public void setUpdateUser(String updateUser) {
		this.updateUser = updateUser;
	}

	@Column(name = "update_time", length = 19)

	public String getUpdateTime() {
		return this.updateTime;
	}

	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}

	@Column(name = "status", length = 1)

	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Transient
	@Basic
	public String getpName() {
		return pName;
	}

	public void setpName(String pName) {
		this.pName = pName;
	}

}