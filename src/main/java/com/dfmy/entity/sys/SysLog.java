package com.dfmy.entity.sys;
// default package

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import org.hibernate.annotations.GenericGenerator;

/**
 * SysLog entity
 */
@Entity
@Table(name = "sys_log")

public class SysLog implements java.io.Serializable {

	private static final long serialVersionUID = 1L;
	private String logid;
	private String businssName;
	private String createtime;
	private String createuser;
	private String ip;
	private String isSuccess;
	private String oper;
	private String remark;
	private String url;
	private String username;
	private String createBy;
	private String createDate;
	private String description;
	private String exceptionCode;
	private String exceptionDetail;
	private String method;
	private String params;
	private String requestIp;
	private String type;

	/** default constructor */
	public SysLog() {
	}

	/** full constructor */
	public SysLog(String businssName, String createtime, String createuser, String ip, String isSuccess, String oper,
			String remark, String url, String username, String createBy, String createDate, String description,
			String exceptionCode, String exceptionDetail, String method, String params, String requestIp, String type) {
		this.businssName = businssName;
		this.createtime = createtime;
		this.createuser = createuser;
		this.ip = ip;
		this.isSuccess = isSuccess;
		this.oper = oper;
		this.remark = remark;
		this.url = url;
		this.username = username;
		this.createBy = createBy;
		this.createDate = createDate;
		this.description = description;
		this.exceptionCode = exceptionCode;
		this.exceptionDetail = exceptionDetail;
		this.method = method;
		this.params = params;
		this.requestIp = requestIp;
		this.type = type;
	}

	// Property accessors
	@GenericGenerator(name = "generator", strategy = "uuid.hex")
	@Id
	@GeneratedValue(generator = "generator")
	@Column(name = "logid", unique = true, nullable = false)

	public String getLogid() {
		return this.logid;
	}

	public void setLogid(String logid) {
		this.logid = logid;
	}

	@Column(name = "businss_name")

	public String getBusinssName() {
		return this.businssName;
	}

	public void setBusinssName(String businssName) {
		this.businssName = businssName;
	}

	@Column(name = "createtime")

	public String getCreatetime() {
		return this.createtime;
	}

	public void setCreatetime(String createtime) {
		this.createtime = createtime;
	}

	@Column(name = "createuser")

	public String getCreateuser() {
		return this.createuser;
	}

	public void setCreateuser(String createuser) {
		this.createuser = createuser;
	}

	@Column(name = "ip")

	public String getIp() {
		return this.ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	@Column(name = "is_success")

	public String getIsSuccess() {
		return this.isSuccess;
	}

	public void setIsSuccess(String isSuccess) {
		this.isSuccess = isSuccess;
	}

	@Column(name = "oper")

	public String getOper() {
		return this.oper;
	}

	public void setOper(String oper) {
		this.oper = oper;
	}

	@Column(name = "remark")

	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	@Column(name = "url")

	public String getUrl() {
		return this.url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	@Column(name = "username")

	public String getUsername() {
		return this.username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	@Column(name = "create_by")

	public String getCreateBy() {
		return this.createBy;
	}

	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}

	@Column(name = "create_date")

	public String getCreateDate() {
		return this.createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	@Column(name = "description")

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	@Column(name = "exception_code")

	public String getExceptionCode() {
		return this.exceptionCode;
	}

	public void setExceptionCode(String exceptionCode) {
		this.exceptionCode = exceptionCode;
	}

	@Column(name = "exception_detail")

	public String getExceptionDetail() {
		return this.exceptionDetail;
	}

	public void setExceptionDetail(String exceptionDetail) {
		this.exceptionDetail = exceptionDetail;
	}

	@Column(name = "method")

	public String getMethod() {
		return this.method;
	}

	public void setMethod(String method) {
		this.method = method;
	}

	@Column(name = "params")

	public String getParams() {
		return this.params;
	}

	public void setParams(String params) {
		this.params = params;
	}

	@Column(name = "request_ip")

	public String getRequestIp() {
		return this.requestIp;
	}

	public void setRequestIp(String requestIp) {
		this.requestIp = requestIp;
	}

	@Column(name = "type")

	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
	}

}