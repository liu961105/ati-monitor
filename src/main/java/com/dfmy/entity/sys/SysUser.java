package com.dfmy.entity.sys;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

/**
 * 用户表
 * @author anix
 *
 */

@Entity
@Table(name="SYS_USER")
public class SysUser implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String userId;
	
	private String userName;
	private String rolename;
	private String deptName;
	private String prcdure;
	private String postId;
	private String postName;
	private String sex;
	private String brithday;
	private String age;
	private String education;
	private String major;
	private String graduateSchool;
	private String graduateTime;
	private String isStudent;
	private String eduMode;
	private String marStatus;
	private String fetStatus;
	private String minority;
	private String idcardno;
	private String domicile;
	private String dmcType;
	private String jobstatus;
	private String isRegular;
	private String regularDate;
	private String phoneNum;
	private String shoeSize;
	private String joindate;
	private String signcontractNum;
	private String contractSigningDate;
	private String contractExpirationDate;
	private String isSocialsecurity;
	private String isAccumulationfund;
	private String sosRemark;
	private String sosJobdate;
	private String linkman;
	private String linkmanRtp;
	private String linkmanPhone;
	private String introducer;
	private String isCommunist;
	private String isMember;
	private String leavingReasons;
	private String leavingTime;
	private String remark;
	private String password;
	private String userImg;
	private String isVisual;
	private String createuser;
	private String createtime;
	private String updateuser;
	private String updatetime;
	private String jobtitle;
	private String usercode;
	private String skill;
	private String email;
	private Boolean locked;
	private String qqNo;
	private String companyName;
	
	
	private List<SysRole> roles = new ArrayList<SysRole>();  
	private SysDept sysDept;

	
	
	@Id
	@GeneratedValue(generator="system-uuid")
	@GenericGenerator(name="system-uuid", strategy="uuid.hex")
    @Column(name="USERID", nullable=false, length=50, scale=0)
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	@ManyToMany(cascade = {CascadeType.REFRESH})
	@JoinTable(name = "user_role",joinColumns = { @JoinColumn(name = "userid", referencedColumnName = "userid") },inverseJoinColumns = { @JoinColumn(name = "roleid", referencedColumnName = "roleid") })
	public List<SysRole> getRoles() {
		return roles;
	}
	public void setRoles(List<SysRole> roles) {
		this.roles = roles;
	}
	
	@ManyToOne(cascade= {CascadeType.REFRESH,CascadeType.PERSIST})
 	@JoinColumn(name="dept_id")
	public SysDept getSysDept() {
		return sysDept;
	}
	public void setSysDept(SysDept sysDept) {
		this.sysDept = sysDept;
	}
	
	
	/*@Column(name = "username")

	public String getUsername() {
		return this.username;
	}

	public void setUsername(String username) {
		this.username = username;
	}*/

	@Column(name = "rolename")

	public String getRolename() {
		return this.rolename;
	}

	public void setRolename(String rolename) {
		this.rolename = rolename;
	}

	@Column(name = "dept_name")

	public String getDeptName() {
		return this.deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}


	@Column(name = "post_id")

	public String getPostId() {
		return this.postId;
	}

	public void setPostId(String postId) {
		this.postId = postId;
	}

	@Column(name = "post_name")

	public String getPostName() {
		return this.postName;
	}

	public void setPostName(String postName) {
		this.postName = postName;
	}

	@Column(name = "sex")

	public String getSex() {
		return this.sex;
	}

	public void setSex(String sex) {
		this.sex = sex;
	}

	@Column(name = "brithday")

	public String getBrithday() {
		return this.brithday;
	}

	public void setBrithday(String brithday) {
		this.brithday = brithday;
	}

	@Column(name = "age")

	public String getAge() {
		return this.age;
	}

	public void setAge(String age) {
		this.age = age;
	}

	@Column(name = "education")

	public String getEducation() {
		return this.education;
	}

	public void setEducation(String education) {
		this.education = education;
	}

	@Column(name = "major")

	public String getMajor() {
		return this.major;
	}

	public void setMajor(String major) {
		this.major = major;
	}

	@Column(name = "graduate_school")

	public String getGraduateSchool() {
		return this.graduateSchool;
	}

	public void setGraduateSchool(String graduateSchool) {
		this.graduateSchool = graduateSchool;
	}

	@Column(name = "graduate_time")

	public String getGraduateTime() {
		return this.graduateTime;
	}

	public void setGraduateTime(String graduateTime) {
		this.graduateTime = graduateTime;
	}

	@Column(name = "is_student")

	public String getIsStudent() {
		return this.isStudent;
	}

	public void setIsStudent(String isStudent) {
		this.isStudent = isStudent;
	}

	@Column(name = "edu_mode")

	public String getEduMode() {
		return this.eduMode;
	}

	public void setEduMode(String eduMode) {
		this.eduMode = eduMode;
	}

	@Column(name = "mar_status")

	public String getMarStatus() {
		return this.marStatus;
	}

	public void setMarStatus(String marStatus) {
		this.marStatus = marStatus;
	}

	@Column(name = "fet_status")

	public String getFetStatus() {
		return this.fetStatus;
	}

	public void setFetStatus(String fetStatus) {
		this.fetStatus = fetStatus;
	}

	@Column(name = "minority")

	public String getMinority() {
		return this.minority;
	}

	public void setMinority(String minority) {
		this.minority = minority;
	}

	@Column(name = "idcardno")

	public String getIdcardno() {
		return this.idcardno;
	}

	public void setIdcardno(String idcardno) {
		this.idcardno = idcardno;
	}

	@Column(name = "domicile")

	public String getDomicile() {
		return this.domicile;
	}

	public void setDomicile(String domicile) {
		this.domicile = domicile;
	}

	@Column(name = "dmc_type")

	public String getDmcType() {
		return this.dmcType;
	}

	public void setDmcType(String dmcType) {
		this.dmcType = dmcType;
	}

	@Column(name = "jobstatus")

	public String getJobstatus() {
		return this.jobstatus;
	}

	public void setJobstatus(String jobstatus) {
		this.jobstatus = jobstatus;
	}

	@Column(name = "is_regular")

	public String getIsRegular() {
		return this.isRegular;
	}

	public void setIsRegular(String isRegular) {
		this.isRegular = isRegular;
	}

	@Column(name = "regular_date")

	public String getRegularDate() {
		return this.regularDate;
	}

	public void setRegularDate(String regularDate) {
		this.regularDate = regularDate;
	}

	@Column(name = "phone_num")

	public String getPhoneNum() {
		return this.phoneNum;
	}

	public void setPhoneNum(String phoneNum) {
		this.phoneNum = phoneNum;
	}

	@Column(name = "shoe_size")

	public String getShoeSize() {
		return this.shoeSize;
	}

	public void setShoeSize(String shoeSize) {
		this.shoeSize = shoeSize;
	}

	@Column(name = "joindate")

	public String getJoindate() {
		return this.joindate;
	}

	public void setJoindate(String joindate) {
		this.joindate = joindate;
	}

	@Column(name = "signcontract_num")

	public String getSigncontractNum() {
		return this.signcontractNum;
	}

	public void setSigncontractNum(String signcontractNum) {
		this.signcontractNum = signcontractNum;
	}

	@Column(name = "contract_signing_date")

	public String getContractSigningDate() {
		return this.contractSigningDate;
	}

	public void setContractSigningDate(String contractSigningDate) {
		this.contractSigningDate = contractSigningDate;
	}

	@Column(name = "contract_expiration_date")

	public String getContractExpirationDate() {
		return this.contractExpirationDate;
	}

	public void setContractExpirationDate(String contractExpirationDate) {
		this.contractExpirationDate = contractExpirationDate;
	}

	@Column(name = "is_socialsecurity")

	public String getIsSocialsecurity() {
		return this.isSocialsecurity;
	}

	public void setIsSocialsecurity(String isSocialsecurity) {
		this.isSocialsecurity = isSocialsecurity;
	}

	@Column(name = "is_accumulationfund")

	public String getIsAccumulationfund() {
		return this.isAccumulationfund;
	}

	public void setIsAccumulationfund(String isAccumulationfund) {
		this.isAccumulationfund = isAccumulationfund;
	}

	@Column(name = "sos_remark")

	public String getSosRemark() {
		return this.sosRemark;
	}

	public void setSosRemark(String sosRemark) {
		this.sosRemark = sosRemark;
	}

	@Column(name = "sos_jobdate")

	public String getSosJobdate() {
		return this.sosJobdate;
	}

	public void setSosJobdate(String sosJobdate) {
		this.sosJobdate = sosJobdate;
	}

	@Column(name = "linkman")

	public String getLinkman() {
		return this.linkman;
	}

	public void setLinkman(String linkman) {
		this.linkman = linkman;
	}

	@Column(name = "linkman_rtp")

	public String getLinkmanRtp() {
		return this.linkmanRtp;
	}

	public void setLinkmanRtp(String linkmanRtp) {
		this.linkmanRtp = linkmanRtp;
	}

	@Column(name = "linkman_phone")

	public String getLinkmanPhone() {
		return this.linkmanPhone;
	}

	public void setLinkmanPhone(String linkmanPhone) {
		this.linkmanPhone = linkmanPhone;
	}

	@Column(name = "introducer")

	public String getIntroducer() {
		return this.introducer;
	}

	public void setIntroducer(String introducer) {
		this.introducer = introducer;
	}

	@Column(name = "is_communist")

	public String getIsCommunist() {
		return this.isCommunist;
	}

	public void setIsCommunist(String isCommunist) {
		this.isCommunist = isCommunist;
	}

	@Column(name = "is_member")

	public String getIsMember() {
		return this.isMember;
	}

	public void setIsMember(String isMember) {
		this.isMember = isMember;
	}

	@Column(name = "leaving_reasons")

	public String getLeavingReasons() {
		return this.leavingReasons;
	}

	public void setLeavingReasons(String leavingReasons) {
		this.leavingReasons = leavingReasons;
	}

	@Column(name = "leaving_time")

	public String getLeavingTime() {
		return this.leavingTime;
	}

	public void setLeavingTime(String leavingTime) {
		this.leavingTime = leavingTime;
	}

	@Column(name = "remark")

	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	@Column(name = "password")

	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	@Column(name = "user_img")

	public String getUserImg() {
		return this.userImg;
	}

	public void setUserImg(String userImg) {
		this.userImg = userImg;
	}

	@Column(name = "is_visual")

	public String getIsVisual() {
		return this.isVisual;
	}

	public void setIsVisual(String isVisual) {
		this.isVisual = isVisual;
	}

	@Column(name = "createuser")

	public String getCreateuser() {
		return this.createuser;
	}

	public void setCreateuser(String createuser) {
		this.createuser = createuser;
	}

	@Column(name = "createtime")

	public String getCreatetime() {
		return this.createtime;
	}

	public void setCreatetime(String createtime) {
		this.createtime = createtime;
	}

	@Column(name = "updateuser")

	public String getUpdateuser() {
		return this.updateuser;
	}

	public void setUpdateuser(String updateuser) {
		this.updateuser = updateuser;
	}

	@Column(name = "updatetime")

	public String getUpdatetime() {
		return this.updatetime;
	}

	public void setUpdatetime(String updatetime) {
		this.updatetime = updatetime;
	}

	@Column(name = "jobtitle")

	public String getJobtitle() {
		return this.jobtitle;
	}

	public void setJobtitle(String jobtitle) {
		this.jobtitle = jobtitle;
	}

	@Column(name = "usercode")

	public String getUsercode() {
		return this.usercode;
	}

	public void setUsercode(String usercode) {
		this.usercode = usercode;
	}

	@Column(name = "locked")

	public Boolean getLocked() {
		return this.locked;
	}

	public void setLocked(Boolean locked) {
		this.locked = locked;
	}
	
	
	@Column(name = "username")
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	
	
	@Column(name = "prcdure")
	public String getPrcdure() {
		return prcdure;
	}
	public void setPrcdure(String prcdure) {
		this.prcdure = prcdure;
	}
	
	@Column(name = "skill")
	public String getSkill() {
		return skill;
	}
	public void setSkill(String skill) {
		this.skill = skill;
	}
	
	@Column(name = "email")
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}

	public String getQqNo() {
		return qqNo;
	}

	public void setQqNo(String qqNo) {
		this.qqNo = qqNo;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
}
