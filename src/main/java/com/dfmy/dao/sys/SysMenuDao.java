package com.dfmy.dao.sys;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.dfmy.entity.sys.SysMenu;


public interface SysMenuDao extends PagingAndSortingRepository<SysMenu, String>,
JpaSpecificationExecutor<SysMenu>{

	SysMenu findByName(SysMenu menu);
	
	
	@Query("select t from SysMenu t where t.parentMenu IS NULL")
	List<SysMenu> findTopList();
	
	@Query("select t from SysMenu t order by t.menuId desc")
	List<SysMenu> findAll();
	
	List<SysMenu> findByParentMenu(SysMenu sysMenu);
}