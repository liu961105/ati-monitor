package com.dfmy.entity.sys;

import java.awt.Menu;
import java.io.Serializable;
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
import javax.persistence.OrderBy;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.Fetch;
import org.hibernate.annotations.FetchMode;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * 部门管理
 * 
 * @author zhangjl
 *
 */
@Entity
@Table(name = "sys_dept")
@JsonIgnoreProperties(value={"hibernateLazyInitializer","handler","fieldHandler"}) 
public class SysDept implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String deptId;
	private String name;
	private String deptCode;
	private SysDept parentDept;
	private List<SysDept> childDept = new ArrayList<SysDept>();
	private String createTime;
	private String updateTime;
	private String createUser;
	private String updateUser;
	private String pId;
	private String remark;

	@Id
	@GeneratedValue(generator = "system-uuid")
	@GenericGenerator(name = "system-uuid", strategy = "uuid.hex")
	@Column(name = "deptid", nullable = false)
	public String getDeptId() {
		return deptId;
	}

	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}

	@Column(name = "name")
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@ManyToOne(cascade = {CascadeType.REFRESH},fetch = FetchType.LAZY)
	@JoinColumn(name = "pid")
	@JsonIgnoreProperties(value = { "hibernateLazyInitializer", "handler" })
	public SysDept getParentDept() {
		return parentDept;
	}

	public void setParentDept(SysDept parentDept) {
		this.parentDept = parentDept;
	}

	@OneToMany(targetEntity= SysDept.class,cascade = { CascadeType.ALL},fetch = FetchType.LAZY, mappedBy = "parentDept")
	@JsonIgnore
	public List<SysDept> getChildDept() {
		return childDept;
	}

	public void setChildDept(List<SysDept> childDept) {
		this.childDept = childDept;
	}

	@Column(name = "remark")
	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	@Column(name = "createtime",updatable=false)
	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	@Column(name = "updatetime")
	public String getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}

	@Column(name = "createuser",updatable=false)
	public String getCreateUser() {
		return createUser;
	}

	public void setCreateUser(String createUser) {
		this.createUser = createUser;
	}

	@Column(name = "updateuser")
	public String getUpdateUser() {
		return updateUser;
	}

	public void setUpdateUser(String updateUser) {
		this.updateUser = updateUser;
	}

	@Column(name="pid")
	@Transient
	public String getpId() {
		return pId;
	}

	public void setpId(String pId) {
		this.pId = pId;
	}

	@Column(name="deptCode",length=50)
	public String getDeptCode() {
		return deptCode;
	}

	
	public void setDeptCode(String deptCode) {
		this.deptCode = deptCode;
	}
	
	
	
}
