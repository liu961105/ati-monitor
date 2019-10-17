package com.dfmy.service.sys;

import java.util.List;

import org.springframework.data.domain.Page;

import com.dfmy.entity.sys.SysDept;

public interface SysDeptService {

	Page<SysDept> pageList(int pageNumber, int pageSize, String sortColom,SysDept dept);

	SysDept saveDept(SysDept dept);

	void deleteDept(String iD);

	SysDept findDept(String iD);
	
	SysDept findDept(SysDept dept);
	
	List<SysDept> findTopList();

	/**
	 * 查找车间
	 * @param pid
	 * @return
	 */
	List<SysDept> findWkspList(String pid);

	/**
	 * 根据部门民称查部门
	 * @param name
	 * @return
	 */
	SysDept findDeptByName(String name);
	
	List<SysDept> findByParentDept(SysDept sysDept);
}
