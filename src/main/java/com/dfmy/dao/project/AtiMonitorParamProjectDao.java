package com.dfmy.dao.project;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.dfmy.entity.project.AtiMonitorParamProject;

public interface AtiMonitorParamProjectDao extends PagingAndSortingRepository<AtiMonitorParamProject, String>,
		JpaSpecificationExecutor<AtiMonitorParamProject> {

	public List<AtiMonitorParamProject> findByProjectId(String projectId);
	
	@Modifying
	@Query("delete from AtiMonitorParamProject where projectId = ?1 and monitorParamId not in ?2")
	public void delByProjectIdAndParamIds(String projectId,List<String> paramIds);
	
	public AtiMonitorParamProject findByProjectIdAndMonitorParamId(String projectId,String paramId);
	
	@Modifying
	@Query("delete from AtiMonitorParamProject where projectId = ?")
	public void delByProjectId(String projectId);
}
