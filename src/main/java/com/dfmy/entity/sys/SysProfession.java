package com.dfmy.entity.sys;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

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
 * 岗位表
 * @author anix
 *
 */

@Entity
@Table(name="sys_profession")
public class SysProfession implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String professionId;
	private String name;//名
	private String code;//码
	private String remark;//备注
	private String createTime;
	private String status;//状态
	
	private SysProfession parentProfession;
	private List<SysProfession> childProfession = new ArrayList<SysProfession>();
	
	
	private String pId;
	private String comp_id;
	private String deptId;
	private String dept_name;
	private String comp_name;
	
	
	
	//private SysDept sysDept;

	
	@Id
	@GeneratedValue(generator="system-uuid")
	@GenericGenerator(name="system-uuid", strategy="uuid.hex")
    @Column(name="id", nullable=false, length=50, scale=0)
	public String getProfessionId() {
		return professionId;
	}
	public void setProfessionId(String professionId) {
		this.professionId = professionId;
	}
	@Column(name="name")
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	@Column(name="REMARK")
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	@Column(name="create_time",updatable=false)
	public String getCreateTime() {
		return createTime;
	}
	
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	
	@Column(name="dept_id")
	public String getDeptId() {
		return deptId;
	}
	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}
	
	@Column(name="code")
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	
	@Column(name="status")
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	
	/*@JsonIgnoreProperties(value = { "hibernateLazyInitializer", "handler" })
	@ManyToOne(cascade= {CascadeType.REFRESH,CascadeType.PERSIST},fetch = FetchType.LAZY)
 	@JoinColumn(name="dept_id")
	public SysDept getSysDept() {
		return sysDept;
	}
	public void setSysDept(SysDept sysDept) {
		this.sysDept = sysDept;
	}*/
	
	
	@Column(name="pid")
	@Transient
	public String getpId() {
		return pId;
	}

	public void setpId(String pId) {
		this.pId = pId;
	}

	@ManyToOne(cascade = {CascadeType.REFRESH},fetch = FetchType.LAZY)
	@JoinColumn(name = "pid")
	@JsonIgnoreProperties(value = { "hibernateLazyInitializer", "handler" })
	public SysProfession getParentProfession() {
		return parentProfession;
	}
	public void setParentProfession(SysProfession parentProfession) {
		this.parentProfession = parentProfession;
	}
	

	@OneToMany(targetEntity= SysProfession.class,cascade = { CascadeType.ALL},fetch = FetchType.LAZY, mappedBy = "parentProfession")
	@JsonIgnore
	public List<SysProfession> getChildProfession() {
		return childProfession;
	}
	public void setChildProfession(List<SysProfession> childProfession) {
		this.childProfession = childProfession;
	}
	
	
	@Column(name="comp_id")
	public String getComp_id() {
		return comp_id;
	}
	public void setComp_id(String comp_id) {
		this.comp_id = comp_id;
	}
	
	
	@Column(name="dept_name")
	public String getDept_name() {
		return dept_name;
	}
	public void setDept_name(String dept_name) {
		this.dept_name = dept_name;
	}
	
	
	@Column(name="comp_name")
	public String getComp_name() {
		return comp_name;
	}
	public void setComp_name(String comp_name) {
		this.comp_name = comp_name;
	}
}
