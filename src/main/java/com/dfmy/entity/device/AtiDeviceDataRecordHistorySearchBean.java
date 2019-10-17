package com.dfmy.entity.device;

/**
 * 上传信息查询实体
 */
public class AtiDeviceDataRecordHistorySearchBean {


    private String monitorSitesOne;

    private String monitorSitesTwo;

    private String searchBeginTimeOne;

    private String searchEndTimeOne;

    private String searchBeginTimeTwo;

    private String searchEndTimeTwo;

    private Integer SearchType;

    private String monitorSites;

    private String searchBeginTimeNode;

    private String searchEndTimeNode;

    public String getSearchBeginTimeNode() {
        return searchBeginTimeNode;
    }

    public void setSearchBeginTimeNode(String searchBeginTimeNode) {
        this.searchBeginTimeNode = searchBeginTimeNode;
    }

    public String getSearchEndTimeNode() {
        return searchEndTimeNode;
    }

    public void setSearchEndTimeNode(String searchEndTimeNode) {
        this.searchEndTimeNode = searchEndTimeNode;
    }

    public String getMonitorSites() {
        return monitorSites;
    }

    public void setMonitorSites(String monitorSites) {
        this.monitorSites = monitorSites;
    }

    public String getMonitorSitesOne() {
        return monitorSitesOne;
    }

    public void setMonitorSitesOne(String monitorSitesOne) {
        this.monitorSitesOne = monitorSitesOne;
    }

    public String getMonitorSitesTwo() {
        return monitorSitesTwo;
    }

    public void setMonitorSitesTwo(String monitorSitesTwo) {
        this.monitorSitesTwo = monitorSitesTwo;
    }

    public String getSearchBeginTimeOne() {
        return searchBeginTimeOne;
    }

    public void setSearchBeginTimeOne(String searchBeginTimeOne) {
        this.searchBeginTimeOne = searchBeginTimeOne;
    }

    public String getSearchEndTimeOne() {
        return searchEndTimeOne;
    }

    public void setSearchEndTimeOne(String searchEndTimeOne) {
        this.searchEndTimeOne = searchEndTimeOne;
    }

    public String getSearchBeginTimeTwo() {
        return searchBeginTimeTwo;
    }

    public void setSearchBeginTimeTwo(String searchBeginTimeTwo) {
        this.searchBeginTimeTwo = searchBeginTimeTwo;
    }

    public String getSearchEndTimeTwo() {
        return searchEndTimeTwo;
    }

    public void setSearchEndTimeTwo(String searchEndTimeTwo) {
        this.searchEndTimeTwo = searchEndTimeTwo;
    }

    public Integer getSearchType() {
        return SearchType;
    }

    public void setSearchType(Integer searchType) {
        SearchType = searchType;
    }
}
