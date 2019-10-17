package com.dfmy.dao.project;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.dfmy.entity.project.AtiMonitorProjectDevice;

public interface AtiMonitorProjectDeviceDao extends PagingAndSortingRepository<AtiMonitorProjectDevice, String>,
		JpaSpecificationExecutor<AtiMonitorProjectDevice> {

	List<AtiMonitorProjectDevice> findByProjectId (String projectId);
	
	@Modifying
	@Query("delete from AtiMonitorProjectDevice where projectId = ?1 and paramDeviceId not in ?2")
	public void delByProjectIdAndParamDeviceIds(String projectId,List<String> paramDeviceIds);
	
	public AtiMonitorProjectDevice findByProjectIdAndParamDeviceId(String projectId,String paramDeviceId);
	
	@Modifying
	@Query("delete from AtiMonitorProjectDevice where projectId = ?")
	public void delByProjectId(String projectId);
}
