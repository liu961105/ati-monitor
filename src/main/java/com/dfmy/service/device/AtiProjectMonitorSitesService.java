package com.dfmy.service.device;

import com.dfmy.entity.device.AtiProjectMonitorSites;

import java.util.List;

import org.springframework.data.domain.Page;


public interface AtiProjectMonitorSitesService {

    List<AtiProjectMonitorSites> findMonitorSites( final AtiProjectMonitorSites atiDevice);

    void save(AtiProjectMonitorSites atiProjectMonitorSites);

    void delete(String id);
    
    List<AtiProjectMonitorSites> findByMonitorParamIdAndProjectId(String paramId,String projectId);

    AtiProjectMonitorSites findMonitorById(String id);

    List<AtiProjectMonitorSites> findAllByProjectId(String projectId);

}
