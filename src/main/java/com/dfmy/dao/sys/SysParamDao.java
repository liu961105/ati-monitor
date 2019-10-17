package com.dfmy.dao.sys;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.dfmy.entity.sys.SysParam;

public interface SysParamDao extends PagingAndSortingRepository<SysParam, String>,
JpaSpecificationExecutor<SysParam>{
	
	SysParam findByParamName(SysParam param);
	
	@Query("select t from SysParam t where t.parentParam IS NULL")
	List<SysParam> findTopList();
	
	@Query("select t from SysParam t order by t.orderNum desc")
	List<SysParam> findAll();
	
	@Query("select t from SysParam t where t.parentParam =? and t.status='1'")
	List<SysParam> findByParentCode(SysParam parentParam);
	
	@Query("select t from SysParam t where t.parentParam =?1 and t.paramCode=?2 and t.status='1'")
	SysParam findByPCodeAndCode(SysParam parentCode,String code);
	
	SysParam findByParamCode(String paramCode);

	@Query("select t from SysParam t where t.parentParam.paramId =? and t.status='1'")
	List<SysParam> findByparentCode(String iD);

	@Query("select t from SysParam t where t.status=? order by t.orderNum")
	List<SysParam> findByStatus (String status);
} 
