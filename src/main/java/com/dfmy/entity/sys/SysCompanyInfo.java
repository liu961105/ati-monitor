package com.dfmy.entity.sys;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;


@Entity
@Table(name ="SYS_COMPANY_INFO")
public class SysCompanyInfo implements Serializable{
	private static final long serialVersionUID = 1L;
	// Fields
	private String companyId;
	private String name;
	private String shorterForm;
	private String taxNum;
	private String legalPersonName;
	private String legalPersonTel;
	private String legalPersonAddr;
	private String legalPersonEmail;
	private String briefIntroduction;
	private String createTime;
	private String updateTime;
	private String state;



	@Id
	@GeneratedValue(generator = "system-uuid")
	@GenericGenerator(name = "system-uuid", strategy = "uuid.hex")
	@Column(name = "COMPANY_ID", nullable = false, length = 64)
	public String getCompanyId() {
		return this.companyId;
	}

	public void setCompanyId(String companyId) {
		this.companyId = companyId;
	}

	@Column(name = "NAME")
	public String getName() {
		return this.name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Column(name = "SHORTER_FORM")
	public String getShorterForm() {
		return this.shorterForm;
	}

	public void setShorterForm(String shorterForm) {
		this.shorterForm = shorterForm;
	}

	@Column(name = "TAX_NUM", length = 64)
	public String getTaxNum() {
		return this.taxNum;
	}

	public void setTaxNum(String taxNum) {
		this.taxNum = taxNum;
	}

	@Column(name = "LEGAL_PERSON_NAME")
	public String getLegalPersonName() {
		return this.legalPersonName;
	}

	public void setLegalPersonName(String legalPersonName) {
		this.legalPersonName = legalPersonName;
	}

	@Column(name = "LEGAL_PERSON_TEL", length = 11)
	public String getLegalPersonTel() {
		return this.legalPersonTel;
	}

	public void setLegalPersonTel(String legalPersonTel) {
		this.legalPersonTel = legalPersonTel;
	}

	@Column(name = "legal_person_addr")
	public String getLegalPersonAddr() {
		return this.legalPersonAddr;
	}

	public void setLegalPersonAddr(String legalPersonAddr) {
		this.legalPersonAddr = legalPersonAddr;
	}

	@Column(name = "LEGAL_PERSON_EMAIL")
	public String getLegalPersonEmail() {
		return this.legalPersonEmail;
	}

	public void setLegalPersonEmail(String legalPersonEmail) {
		this.legalPersonEmail = legalPersonEmail;
	}

	@Column(name = "BRIEF_INTRODUCTION")
	public String getBriefIntroduction() {
		return this.briefIntroduction;
	}

	public void setBriefIntroduction(String briefIntroduction) {
		this.briefIntroduction = briefIntroduction;
	}

	@Column(name = "CREATE_TIME", length = 64)
	public String getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	@Column(name = "UPDATE_TIME", length = 64)
	public String getUpdateTime() {
		return this.updateTime;
	}

	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}

	@Column(name = "STATE", length = 1)
	public String getState() {
		return this.state;
	}

	public void setState(String state) {
		this.state = state;
	}

}
