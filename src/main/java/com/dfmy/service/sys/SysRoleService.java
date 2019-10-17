package com.dfmy.service.sys;

import java.util.List;

import org.springframework.data.domain.Page;

import com.dfmy.entity.sys.SysRole;
/**
 * 系统角色接口
 * @author zhangjl
 *
 */
public interface SysRoleService {
	/**
	 * 保存、更新角色
	 * @param Role
	 * @return
	 */
	SysRole saveRole(SysRole Role);
	/**
	 * 查询单个角色
	 * @param RoleId
	 * @return
	 */
	SysRole findRole(String RoleId);
	
	/**
	 * 删除角色
	 * @param RoleId
	 */
	void deleteRole(String RoleId);
	
	/**
	 * 分页查询
	 * @param pageNumber
	 * @param pageSize
	 * @return
	 */
	Page<SysRole> pageList(int pageNumber,int pageSize,String sortColom,final SysRole Role);
	
	/**
	 * 查询所有角色
	 * @return
	 */
	List<SysRole> findAllRole();
}
