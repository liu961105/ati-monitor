package com.dfmy.dao.sys;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.dfmy.entity.sys.SysDept;


public interface SysDeptDao extends PagingAndSortingRepository<SysDept, String>,
JpaSpecificationExecutor<SysDept>{

	SysDept findByName(SysDept dept);

	@Query("select t from SysDept t where t.parentDept IS NULL")
	List<SysDept> findTopList();

	@Query("select t from SysDept t where pId = ?")
	List<SysDept> findWkspList(String pid);

	@Query("select t from SysDept t where name = ?")
	SysDept findDeptByName(String name);
	
	List<SysDept> findByParentDept(SysDept dept);
	
}