package com.dfmy.entity.index;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.NotFound;
import org.hibernate.annotations.NotFoundAction;

import com.dfmy.entity.project.AtiProject;
import com.fasterxml.jackson.annotation.JsonIgnore;

/**
 * AtiProjectInfo entity. 工程信息实体
 */
@Entity
@Table(name = "ati_project_info")

public class AtiProjectInfo implements java.io.Serializable {

	private static final long serialVersionUID = 1L;
	private String id;
	private AtiProject atiProject;
	/*private String projectId;*/
	private String objKey;
	private String objValue;
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

	
	/*@Column(name = "project_id", length = 32)
	public String getProjectId() {
		return this.projectId;
	}

	public void setProjectId(String projectId) {
		this.projectId = projectId;
	}*/

	@Column(name = "obj_key", length = 50)

	public String getObjKey() {
		return this.objKey;
	}

	public void setObjKey(String objKey) {
		this.objKey = objKey;
	}

	@Column(name = "obj_value", length = 100)

	public String getObjValue() {
		return this.objValue;
	}

	public void setObjValue(String objValue) {
		this.objValue = objValue;
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