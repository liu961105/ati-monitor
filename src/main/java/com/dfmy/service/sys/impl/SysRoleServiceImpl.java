package com.dfmy.service.sys.impl;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.apache.commons.collections4.IterableUtils;
import org.apache.commons.collections4.IteratorUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import com.dfmy.dao.sys.SysRoleDao;
import com.dfmy.entity.sys.SysRole;
import com.dfmy.service.sys.SysRoleService;

@Service
public class SysRoleServiceImpl implements SysRoleService{

	@Resource
	private SysRoleDao sysRoleDao;
	@Override
	public SysRole saveRole(SysRole Role) {
		return sysRoleDao.save(Role);
	}

	@Override
	public SysRole findRole(String RoleId) {
		return sysRoleDao.findOne(RoleId);
	}

	@Override
	public void deleteRole(String RoleId) {
		sysRoleDao.delete(RoleId);
	}

	@Override
	public Page<SysRole> pageList(int pageNumber,int pageSize,String sortColom,final SysRole role) {
		Pageable pageable = new PageRequest(pageNumber-1, pageSize, Sort.Direction.ASC,sortColom); 
		Page<SysRole> sysRole = sysRoleDao.findAll(new Specification<SysRole>(){  
	            @Override  
	            public Predicate toPredicate(Root<SysRole> root, CriteriaQuery<?> query, CriteriaBuilder criteriaBuilder) {  
	            	 List<Predicate> list = new ArrayList<Predicate>();  
	                 if(StringUtils.isNotBlank(role.getName())){  
	                     list.add(criteriaBuilder.like(root.get("name").as(String.class), "%" +role.getName()+"%"));  
	                 } 
	                 if(StringUtils.isNotBlank(role.getCreateTime())){  
	                     list.add(criteriaBuilder.like(root.get("createTime").as(String.class), "%" +role.getCreateTime()+"%"));  
	                 } 
	                 Predicate[] p = new Predicate[list.size()];  
	                 return criteriaBuilder.and(list.toArray(p));
	            }  
	        },pageable); 
		 return sysRole;
	}

	@Override
	public List<SysRole> findAllRole() {
		Iterable<SysRole> itrole = sysRoleDao.findAll();
		return IterableUtils.toList(itrole);
	}
}
