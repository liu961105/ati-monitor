package com.dfmy.entity.sys;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;

/**
 * SysDepartment entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "SYS_COMP_DEPT")
public class SysDepartment implements java.io.Serializable{
	private static final long serialVersionUID = -5695376774730539314L;
	// Fields

	private String deptId;			//部门主键
	private String deptName;		//部门名称
	private String deptCode;		//部门编码
	private String companyId;		//公司主键

	private String parentDeptCode;	//父级部门编码
	private String parentDeptName;	//父级部门名称
	private Integer deptSeq;		//部门排序
	private String createTime;
	private String updateTime;     //创建时间
	private String state;

	// Constructors

	/** default constructor */
	public SysDepartment() {
	}

	/** minimal constructor */
	public SysDepartment(String deptName, String deptState, String createTime) {
		this.deptName = deptName;
		
		this.createTime = createTime;
		/*this.xzqh = xzqh;*/
	}

	/** full constructor */
	public SysDepartment(String deptName, String deptCode,
			String parentDeptCode, String deptState, Integer deptSeq,
			String createTime, String userAcctId) {
		this.deptName = deptName;
		this.deptCode = deptCode;
		this.parentDeptCode = parentDeptCode;

		this.deptSeq = deptSeq;
		this.createTime = createTime;
		/*this.xzqh = xzqh;*/
	}

	// Property accessors
	@Id
	@GeneratedValue(generator="system-uuid")
	@GenericGenerator(name="system-uuid", strategy="uuid.hex")
	@Column(name = "DEPT_ID", unique = true, nullable = false)
	public String getDeptId() {
		return this.deptId;
	}

	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}

	@Column(name = "DEPT_NAME")
	public String getDeptName() {
		return this.deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	@Column(name = "DEPT_CODE")
	public String getDeptCode() {
		return this.deptCode;
	}

	public void setDeptCode(String deptCode) {
		this.deptCode = deptCode;
	}

	@Column(name = "PARENT_DEPT_CODE")
	public String getParentDeptCode() {
		return this.parentDeptCode;
	}

	public void setParentDeptCode(String parentDeptCode) {
		this.parentDeptCode = parentDeptCode;
	}


	@Column(name = "DEPT_SEQ")
	public Integer getDeptSeq() {
		return this.deptSeq;
	}

	public void setDeptSeq(Integer deptSeq) {
		this.deptSeq = deptSeq;
	}

	@Column(name = "CREATE_TIME")
	public String getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}


	private SysDepartment parentDepartment;
	@Transient
	public SysDepartment getParentDepartment() {
		return parentDepartment;
	}
	public void setParentDepartment(SysDepartment parentDepartment) {
		this.parentDepartment = parentDepartment;
	}
	

	@Transient
	public String getParentDeptName() {
		return parentDeptName;
	}

	public void setParentDeptName(String parentDeptName) {
		this.parentDeptName = parentDeptName;
	}


	@Column(name = "UPDATE_TIME")
	public String getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}

	@Column(name = "COMPANY_ID")
	public String getCompanyId() {
		return companyId;
	}

	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}
	@Column(name = "STATE", length = 1)
	public String getState() {
		return this.state;
	}

	public void setState(String state) {
		this.state = state;
	}
	
	
	
	
}
