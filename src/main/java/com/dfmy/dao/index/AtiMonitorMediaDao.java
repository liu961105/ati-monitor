package com.dfmy.dao.index;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import com.dfmy.entity.index.AtiMonitorMedia;

public interface AtiMonitorMediaDao extends PagingAndSortingRepository<AtiMonitorMedia, String>, 
JpaSpecificationExecutor<AtiMonitorMedia>{
	List<AtiMonitorMedia> findByProjectId(String projectId);
	List<AtiMonitorMedia> findByProjectIdAndType(String projectId,String type);
	
}
