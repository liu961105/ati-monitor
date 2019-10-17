package com.dfmy.dao.sys;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.dfmy.entity.sys.SysRole;


public interface SysRoleDao extends PagingAndSortingRepository<SysRole, String>,
JpaSpecificationExecutor<SysRole>{
	
}
