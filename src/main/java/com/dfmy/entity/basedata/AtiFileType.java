package com.dfmy.entity.basedata;

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

/**
 * 
 * 文档分类实体
 */
@Entity
@Table(name = "ati_file_type")

public class AtiFileType implements java.io.Serializable {

	// Fields
	private static final long serialVersionUID = 1L;
	private String id;
	private AtiProjectStructure atiProjectStructure;
	private String code;
	private String typeName;
	private String createUser;
	private String updateUser;
	private String createTime;
	private String updateTime;
	private String state;
	private String orderNum;
	private String projectId;

	
	// Property accessors
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

	@ManyToOne(cascade = { CascadeType.REFRESH, CascadeType.PERSIST })
	@JoinColumn(name = "struc_id")
	@NotFound(action = NotFoundAction.IGNORE)
	public AtiProjectStructure getAtiProjectStructure() {
		return atiProjectStructure;
	}

	public void setAtiProjectStructure(AtiProjectStructure atiProjectStructure) {
		this.atiProjectStructure = atiProjectStructure;
	}

	@Column(name = "code", length = 20)
	public String getCode() {
		return this.code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	@Column(name = "create_user", length = 50)
	public String getCreateUser() {
		return this.createUser;
	}

	@Column(name = "type_name", length = 50)

	public String getTypeName() {
		return typeName;
	}

	public void setTypeName(String typeName) {
		this.typeName = typeName;
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
	@Column(name = "order_num")
	public String getOrderNum() {
		return orderNum;
	}

	public void setOrderNum(String orderNum) {
		this.orderNum = orderNum;
	}
	@Column(name="project_id")
	public String getProjectId() {
		return projectId;
	}

	public void setProjectId(String projectId) {
		this.projectId = projectId;
	}



}