package com.dfmy.entity.basedata;

import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import com.dfmy.entity.project.AtiProject;
import com.dfmy.entity.sys.SysParam;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * 文档管理实体
 * 
 * @author
 *
 */
@Entity
@Table(name = "file_manage")
public class FileManage implements java.io.Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String id;
	private AtiProjectStructure atiProjectStructure;
	private String fileId;
	private String fileType;
	private String fileName;
	private String fileSize;
	private String uploadTime;
	private String filePath;
	private String shStatus;
	private String status;
	private String createUser;
	private String createTime;
	private String updateUser;
	private String updateTime;
	private String orderNum;
	private String pName;
	
	private AtiProject atiProject;

	public FileManage() {
	}

	public FileManage(String projectId, String fileId, String fileType, String fileName, String fileSize,
			String uploadTime, String filePath, String shStatus, String status, String createUser, String createTime,
			String updateUser, String updateTime) {
		this.fileId = fileId;
		this.fileType = fileType;
		this.fileName = fileName;
		this.fileSize = fileSize;
		this.uploadTime = uploadTime;
		this.filePath = filePath;
		this.shStatus = shStatus;
		this.status = status;
		this.createUser = createUser;
		this.createTime = createTime;
		this.updateUser = updateUser;
		this.updateTime = updateTime;
	}

	@GenericGenerator(name = "generator", strategy = "uuid.hex")
	@Id
	@GeneratedValue(generator = "generator")

	@Column(name = "id", unique = true, nullable = false, length = 32)

	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
	}


	@Column(name = "file_id", length = 32)

	public String getFileId() {
		return this.fileId;
	}

	public void setFileId(String fileId) {
		this.fileId = fileId;
	}

	@Column(name = "file_type", length = 1)

	public String getFileType() {
		return this.fileType;
	}

	public void setFileType(String fileType) {
		this.fileType = fileType;
	}

	@Column(name = "file_name")

	public String getFileName() {
		return this.fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	@Column(name = "file_size", length = 64)

	public String getFileSize() {
		return this.fileSize;
	}

	public void setFileSize(String fileSize) {
		this.fileSize = fileSize;
	}

	@Column(name = "upload_time", length = 19)

	public String getUploadTime() {
		return this.uploadTime;
	}

	public void setUploadTime(String uploadTime) {
		this.uploadTime = uploadTime;
	}

	@Column(name = "file_path")

	public String getFilePath() {
		return this.filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	@Column(name = "sh_status", length = 1)

	public String getShStatus() {
		return this.shStatus;
	}

	public void setShStatus(String shStatus) {
		this.shStatus = shStatus;
	}

	@Column(name = "status", length = 1)

	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Column(name = "create_user")

	public String getCreateUser() {
		return this.createUser;
	}

	public void setCreateUser(String createUser) {
		this.createUser = createUser;
	}

	@Column(name = "create_time")

	public String getCreateTime() {
		return this.createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	@Column(name = "update_user")

	public String getUpdateUser() {
		return this.updateUser;
	}

	public void setUpdateUser(String updateUser) {
		this.updateUser = updateUser;
	}

	@Column(name = "update_time")
	public String getUpdateTime() {
		return this.updateTime;
	}

	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}
	
	@ManyToOne(cascade = { CascadeType.REFRESH, CascadeType.PERSIST })
	@JoinColumn(name = "struc_id")
	@NotFound(action = NotFoundAction.IGNORE)
	public AtiProjectStructure getAtiProjectStructure() {
		return atiProjectStructure;
	}

	public void setAtiProjectStructure(AtiProjectStructure atiProjectStructure) {
		this.atiProjectStructure = atiProjectStructure;
	}
	
	@ManyToOne(cascade = { CascadeType.REFRESH, CascadeType.PERSIST })
	@JoinColumn(name = "project_id")
	@NotFound(action = NotFoundAction.IGNORE)
	@JsonIgnore
	public AtiProject getAtiProject() {
		return atiProject;
	}
	public void setAtiProject(AtiProject atiProject) {
		this.atiProject = atiProject;
	}
	@Column(name = "order_num")
	public String getOrderNum() {
		return orderNum;
	}

	public void setOrderNum(String orderNum) {
		this.orderNum = orderNum;
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
