package com.dfmy.service.sys;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;

import com.dfmy.entity.sys.SysMenu;

/**
 * 
 * @author zhangjl
 *
 */
public interface SysMenuService {

	Page<SysMenu> pageList(int parseInt, int pageSize, String string,
			SysMenu menu);

	SysMenu saveMenu(SysMenu menu);

	void deleteMenu(String iD);

	SysMenu findMenu(String iD);
	
	SysMenu findMenu(SysMenu menu);

	List<SysMenu> findTopList();
	
	List<Map<String,Object>> findAll();
	
	List<SysMenu> findByParentMenu(SysMenu menu);
}
