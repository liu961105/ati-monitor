package com.dfmy.service.sys.impl;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import com.dfmy.dao.sys.SysDeptDao;
import com.dfmy.entity.sys.SysDept;
import com.dfmy.service.sys.SysDeptService;

@Service
public class SysDeptServiceImpl implements SysDeptService{

	@Autowired
	private SysDeptDao sysDeptDao;
	
	@Override
	public SysDept saveDept(SysDept dept) {
		return sysDeptDao.save(dept);
	}

	@Override
	public SysDept findDept(String deptId) {
		return sysDeptDao.findOne(deptId);
	}

	@Override
	public void deleteDept(String deptId) {
		sysDeptDao.delete(deptId);
	}

	@Override
	public Page<SysDept> pageList(int pageNumber,int pageSize,String sortColom,final SysDept dept) {
		Pageable pageable = new PageRequest(pageNumber-1, pageSize, Sort.Direction.ASC,sortColom); 
		Page<SysDept> sysDept = sysDeptDao.findAll(new Specification<SysDept>(){  
	            @Override  
	            public Predicate toPredicate(Root<SysDept> root, CriteriaQuery<?> query, CriteriaBuilder criteriaBuilder) {  
	            	 List<Predicate> list = new ArrayList<Predicate>();  
	                 if(StringUtils.isNotBlank(dept.getName())){  
	                     list.add(criteriaBuilder.like(root.get("name").as(String.class), "%" +dept.getName()+"%"));  
	                 }  
	                 if(null!=dept.getCreateTime() && !"".equals(dept.getCreateTime())){  
	                     list.add(criteriaBuilder.like(root.get("createTime").as(String.class),"%"+ dept.getCreateTime()+"%"));  
	                 }  
	                 Predicate[] p = new Predicate[list.size()];  
	                 return criteriaBuilder.and(list.toArray(p));
	            }  
	        },pageable); 
		 return sysDept;
	}

	@Override
	public SysDept findDept(SysDept dept) {
		return sysDeptDao.findByName(dept);
	}

	@Override
	public List<SysDept> findTopList() {
		return sysDeptDao.findTopList();
	}

	@Override
	public List<SysDept> findWkspList(String pid) {
		return sysDeptDao.findWkspList(pid);
	}

	@Override
	public SysDept findDeptByName(String name) {
		// TODO Auto-generated method stub
		return sysDeptDao.findDeptByName(name);
	}

	@Override
	public List<SysDept> findByParentDept(SysDept sysDept) {
		// TODO Auto-generated method stub
		return sysDeptDao.findByParentDept(sysDept);
	}
}
