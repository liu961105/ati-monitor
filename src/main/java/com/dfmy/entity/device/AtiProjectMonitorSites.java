package com.dfmy.entity.device;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;

@Entity
@Table(name="ati_project_monitor_sites")
public class AtiProjectMonitorSites {

    /**
     * 数据主键
     */
    @Id
    @GeneratedValue(generator = "system-uuid")
    @GenericGenerator(name = "system-uuid", strategy = "uuid.hex")
    @Column(name = "id", nullable = false)
    private String id;

    /**
     * 项目id
     */
    private String projectId;

    /**
     * 监测参数id
     */
    private String monitorParamId	;

    /**
     * 关联设备id
     */
    private String deviceId;

    /**
     * 点位编码
     */
    private String code	;

    /**
     * 点位名称
     */
    private String name;

    /**
     * 创建用户
     */
    private String createUser;

    /**
     * 编辑用户
     */
    private String updateUser;

    /**
     * 创建时间
     */
    private String createTime;

    /**
     * 更新时间
     */
    private String updateTime;

    /**
     * 有效性：1：有效；0：无效
     */
    private String state;

    /**
     * 一级预警值
     */
    private Double oneWarnLevel;

    /**
     * 二级预警值
     */
    private Double twoWarnLevel;

    /**
     * 二级预警值
     */
    private Double treeWarnLevel;

    public Double getOneWarnLevel() {
        return oneWarnLevel;
    }

    public void setOneWarnLevel(Double oneWarnLevel) {
        this.oneWarnLevel = oneWarnLevel;
    }

    public Double getTwoWarnLevel() {
        return twoWarnLevel;
    }

    public void setTwoWarnLevel(Double twoWarnLevel) {
        this.twoWarnLevel = twoWarnLevel;
    }

    public Double getTreeWarnLevel() {
        return treeWarnLevel;
    }

    public void setTreeWarnLevel(Double treeWarnLevel) {
        this.treeWarnLevel = treeWarnLevel;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getProjectId() {
        return projectId;
    }

    public void setProjectId(String projectId) {
        this.projectId = projectId;
    }

    public String getMonitorParamId() {
        return monitorParamId;
    }

    public void setMonitorParamId(String monitorParamId) {
        this.monitorParamId = monitorParamId;
    }

    public String getDeviceId() {
        return deviceId;
    }

    public void setDeviceId(String deviceId) {
        this.deviceId = deviceId;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCreateUser() {
        return createUser;
    }

    public void setCreateUser(String createUser) {
        this.createUser = createUser;
    }

    public String getUpdateUser() {
        return updateUser;
    }

    public void setUpdateUser(String updateUser) {
        this.updateUser = updateUser;
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

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }
}
