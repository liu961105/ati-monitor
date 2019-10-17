package com.dfmy.dao.device;

import com.dfmy.entity.device.AtiProjectMonitorSites;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;


public interface AtiProjectMonitorSitesDao extends PagingAndSortingRepository<AtiProjectMonitorSites, String>,
        JpaSpecificationExecutor<AtiProjectMonitorSites> {

        List<AtiProjectMonitorSites> findByMonitorParamIdAndProjectId(String paramId,String projectId);

        List<AtiProjectMonitorSites> findAllByProjectId(String projectId);
}
