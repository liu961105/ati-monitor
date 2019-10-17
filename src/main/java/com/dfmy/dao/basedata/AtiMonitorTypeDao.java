package com.dfmy.dao.basedata;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.dfmy.entity.basedata.AtiMonitorType;

public interface AtiMonitorTypeDao
		extends PagingAndSortingRepository<AtiMonitorType, String>, JpaSpecificationExecutor<AtiMonitorType> {

	public List<AtiMonitorType> findByState(String state);
	
	@Query("select t from AtiMonitorType t where t.atiProjectStructure.id=? order by t.createTime")
	public List<AtiMonitorType> findByStructId(String structId);
}
