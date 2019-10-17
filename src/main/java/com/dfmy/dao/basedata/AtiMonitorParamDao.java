package com.dfmy.dao.basedata;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.dfmy.entity.basedata.AtiMonitorParam;

import java.util.List;

public interface AtiMonitorParamDao
		extends PagingAndSortingRepository<AtiMonitorParam, String>, JpaSpecificationExecutor<AtiMonitorParam> {

	List<AtiMonitorParam> findByState(String state);
	
	/**
	 * 根据监测项查询所有监测参数
	 * @param itemId
	 * @return
	 */
	@Query("select t from AtiMonitorParam t where t.atiMonitorItem.id = ? order by t.createTime")
	List<AtiMonitorParam> findByItemId(String itemId);
}
