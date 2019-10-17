package com.dfmy.entity.project;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.annotations.GenericGenerator;

import com.dfmy.entity.index.AtiProjectInfo;

/**
 * caoxxudong
 * 工程管理
 * 【table:ati_project】
 */
@Entity
@Table(name="ati_project")
public class AtiProject {

    /**
     * 主键
     */
    @Id
    @GeneratedValue(generator = "system-uuid")
    @GenericGenerator(name = "system-uuid", strategy = "uuid.hex")
    @Column(name = "id", nullable = false)
    private String id;

    /**
     * 地址
     */
    private String address;

    /**
     * 项目名称
     */
    private String projectName;

    /**
     * 项目状态
     */
    private Integer projectStatus;

    /**
     * 纬度
     */
    private String latitude;

    /**
     * 经度
     */
    private String longitude;


    /**
     * 操作员编号
     */
    private String operatorCode;

    /**
     * 操作员名称
     */
    private String operatorName;

    /**
     * 创建时间
     */
    private String createTime;

    /**
     * 更新时间
     */
    private String updateTime;

    /**
     * 删除状态  0 未删除  1 已删除
     */
    private Boolean state;

    /**
     * 所属结构类型
     */
    private String projectStructureId;

    /**
     * 项目结构
     */
    private String structureName;

    /**
     * 负责人
     */
    private String managerId;

    /**
     * 预警数量
     */
    private Integer warnCount;

    /**
     * 处理数量
     */
    private Integer dealCount;

    @Transient
    private String stateStr;

    @Transient
    private Integer roleType;

    @Transient
    private String searchUserId;

    
    @OneToMany(mappedBy="atiProject",targetEntity=AtiProjectInfo.class)
    private List<AtiProjectInfo> atiProjectInfo;

    public String getSearchUserId() {
        return searchUserId;
    }

    public void setSearchUserId(String searchUserId) {
        this.searchUserId = searchUserId;
    }

    public String getManagerId() {
        return managerId;
    }

    public void setManagerId(String managerId) {
        this.managerId = managerId;
    }

    public String getStateStr() {
        return stateStr;
    }

    public void setStateStr(String stateStr) {
        this.stateStr = stateStr;
    }

    public String getProjectName() {
        return projectName;
    }

    public Integer getRoleType() {
        return roleType;
    }

    public void setRoleType(Integer roleType) {
        this.roleType = roleType;
    }

    public void setProjectName(String projectName) {
        this.projectName = projectName;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Integer getProjectStatus() {
        return projectStatus;
    }

    public void setProjectStatus(Integer projectStatus) {
        this.projectStatus = projectStatus;
    }

    public String getLatitude() {
        return latitude;
    }

    public void setLatitude(String latitude) {
        this.latitude = latitude;
    }

    public String getLongitude() {
        return longitude;
    }

    public void setLongitude(String longitude) {
        this.longitude = longitude;
    }

    public String getOperatorCode() {
        return operatorCode;
    }

    public void setOperatorCode(String operatorCode) {
        this.operatorCode = operatorCode;
    }

    public String getOperatorName() {
        return operatorName;
    }

    public void setOperatorName(String operatorName) {
        this.operatorName = operatorName;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public String getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(String updateTime) {
        this.updateTime = updateTime;
    }

    public Boolean getState() {
        return state;
    }

    public void setState(Boolean state) {
        this.state = state;
    }

	public List<AtiProjectInfo> getAtiProjectInfo() {
		return atiProjectInfo;
	}

	public void setAtiProjectInfo(List<AtiProjectInfo> atiProjectInfo) {
		this.atiProjectInfo = atiProjectInfo;
	}

    public String getProjectStructureId() {
        return projectStructureId;
    }

    public void setProjectStructureId(String projectStructureId) {
        this.projectStructureId = projectStructureId;
    }

    public String getStructureName() {
        return structureName;
    }

    public void setStructureName(String structureName) {
        this.structureName = structureName;
    }

    public Integer getWarnCount() {
        return warnCount;
    }

    public void setWarnCount(Integer warnCount) {
        this.warnCount = warnCount;
    }

    public Integer getDealCount() {
        return dealCount;
    }

    public void setDealCount(Integer dealCount) {
        this.dealCount = dealCount;
    }
}
