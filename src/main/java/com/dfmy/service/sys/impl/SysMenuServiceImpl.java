package com.dfmy.service.sys.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Path;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.apache.commons.collections4.IterableUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.dfmy.dao.sys.SysMenuDao;
import com.dfmy.entity.sys.SysMenu;
import com.dfmy.service.sys.SysMenuService;

@Service
public class SysMenuServiceImpl implements SysMenuService{

	@Autowired
	private SysMenuDao sysMenuDao;
	
	@Autowired
	private JdbcTemplate jdtemp;
	
	@Override
	public SysMenu saveMenu(SysMenu menu) {
		return sysMenuDao.save(menu);
	}

	@Override
	public SysMenu findMenu(String menuId) {
		return sysMenuDao.findOne(menuId);
	}

	@Override
	public void deleteMenu(String menuId) {
		sysMenuDao.delete(menuId);
	}

	@Override
	public Page<SysMenu> pageList(int pageNumber,int pageSize,String sortColom,final SysMenu menu) {
		Pageable pageable = new PageRequest(pageNumber-1, pageSize, Sort.Direction.ASC,sortColom); 
		Page<SysMenu> sysMenu = sysMenuDao.findAll(new Specification<SysMenu>(){  
	            @Override  
	            public Predicate toPredicate(Root<SysMenu> root, CriteriaQuery<?> query, CriteriaBuilder criteriaBuilder) {  
	            	 List<Predicate> list = new ArrayList<Predicate>();  
	                 if(StringUtils.isNotBlank(menu.getName())){  
	                     list.add(criteriaBuilder.like(root.get("name").as(String.class), "%" +menu.getName()+"%"));  
	                 }  
	                 if(StringUtils.isNotBlank(menu.getCreateTime())){  
	                     list.add(criteriaBuilder.like(root.get("createTime").as(String.class),"%"+ menu.getCreateTime()+"%"));  
	                 }  
	                 if(StringUtils.isNotBlank(menu.getpName())){  
	                	 Path<String> org=root.get("parentMenu").get("name");  
                         list.add(criteriaBuilder.like(org,"%"+menu.getpName()+"%"));
	                 }  
	                 Predicate[] p = new Predicate[list.size()];  
	                 return criteriaBuilder.and(list.toArray(p));
	            }  
	        },pageable); 
		 return sysMenu;
	}

	@Override
	public SysMenu findMenu(SysMenu menu) {
		return sysMenuDao.findByName(menu);
	}

	@Override
	public List<SysMenu> findTopList() {
		return sysMenuDao.findTopList();
	}

	@Override
	public List<Map<String,Object>> findAll() {
		return jdtemp.queryForList("select t.menuId ,t.name,t.pid from sys_menu t  order by t.menuid desc");
	}

	@Override
	public List<SysMenu> findByParentMenu(SysMenu menu) {
		// TODO Auto-generated method stub
		return sysMenuDao.findByParentMenu(menu);
	}
}
