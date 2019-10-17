package com.dfmy.dao.index;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.dfmy.entity.index.IndexRemind;


public interface IndexRemindDao extends PagingAndSortingRepository<IndexRemind, String>,
JpaSpecificationExecutor<IndexRemind>{

	//SysUser findByUserName(String userName);

	//SysUser findByUserNameAndPassword(String userName,String password);
	
}
