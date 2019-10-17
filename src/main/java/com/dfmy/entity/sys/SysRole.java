package com.dfmy.entity.sys;

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
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;

/**
 * 角色管理
 * @author zhangjl
 *
 */
@Entity
@Table(name="sys_role")
public class SysRole implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String roleId;
	private String name;
	private String remark;
	private String createTime;
	private String updateTime;
	private String createUser;
	private String updateUser;
	private List<SysUser> users = new ArrayList<SysUser>();
	private List<SysMenu> memus = new ArrayList<SysMenu>();
	
	@Id
	@GeneratedValue(generator="system-uuid")
	@GenericGenerator(name="system-uuid", strategy="uuid.hex")
    @Column(name="ROLEID", nullable=false)
	public String getRoleId() {
		return roleId;
	}

	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}
	
	@Column(name="name")
	public String getName() {
		return name;
	}
	

	public void setName(String name) {
		this.name = name;
	}
	
	@Column(name="remark")
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	@Column(name="createtime",updatable=false)
	public String getCreateTime() {
		return createTime;
	}
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}
	
	@Column(name="updatetime")
	public String getUpdateTime() {
		return updateTime;
	}
	public void setUpdateTime(String updateTime) {
		this.updateTime = updateTime;
	}
	
	@Column(name="createuser",updatable=false)
	public String getCreateUser() {
		return createUser;
	}
	public void setCreateUser(String createUser) {
		this.createUser = createUser;
	}
	
	@Column(name="updateuser")
	public String getUpdateUser() {
		return updateUser;
	}
	public void setUpdateUser(String updateUser) {
		this.updateUser = updateUser;
	}
	
	@ManyToMany(mappedBy = "roles",cascade={CascadeType.REFRESH})
	@Basic(fetch = FetchType.LAZY)
	@JsonIgnore
	public List<SysUser> getUsers() {
		return users;
	}
	public void setUsers(List<SysUser> users) {
		this.users = users;
	}

	@ManyToMany(cascade = {CascadeType.REFRESH})
	@JoinTable(name = "menu_role",joinColumns = {  @JoinColumn(name = "roleid", referencedColumnName = "roleid") },inverseJoinColumns = {@JoinColumn(name = "menuid", referencedColumnName = "menuid") })
	@JsonIgnoreProperties(value = { "hibernateLazyInitializer", "handler" })
	@Basic(fetch = FetchType.LAZY)
	public List<SysMenu> getMemus() {
		return memus;
	}

	public void setMemus(List<SysMenu> memus) {
		this.memus = memus;
	}
	
	
	
}
