package com.dfmy.dao.basedata;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.dfmy.entity.basedata.AtiMonitorItem;

public interface AtiMonitorItemDao
		extends PagingAndSortingRepository<AtiMonitorItem, String>, JpaSpecificationExecutor<AtiMonitorItem> {

	public List<AtiMonitorItem> findByState(String state);
	
	@Query("select t from AtiMonitorItem t where t.atiMonitorType.id=? order by t.createTime")
	public List<AtiMonitorItem> findByTypeId(String typeId);
}
