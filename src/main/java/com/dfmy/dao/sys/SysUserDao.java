package com.dfmy.dao.sys;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.dfmy.entity.sys.SysUser;


public interface SysUserDao extends PagingAndSortingRepository<SysUser, String>,
JpaSpecificationExecutor<SysUser>{

	SysUser findByUserName(String userName);

	SysUser findByUserNameAndPassword(String username,String password);

	@Query("select s from SysUser s where sysDept.deptId=?")
	List<SysUser> findUserBydeptId(String iD);
	
}
