package com.dfmy.dao.sys;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.dfmy.entity.sys.SysProfession;


public interface SysProfessionDao extends PagingAndSortingRepository<SysProfession, String>,
JpaSpecificationExecutor<SysProfession>{

	SysProfession findByName(String Name);

	@Query("select t from SysProfession t where t.parentProfession IS NULL")
	List<SysProfession> findTopList();

	@Query("select t from SysProfession t where name = ?")
	SysProfession findProfeByName(String bm);

	//SysUser findByUserNameAndPassword(String userName,String password);
	
	List<SysProfession> findByDeptId(String deptId);
	
}
