package com.dfmy.service.sys.impl;

import java.net.SocketException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.apache.commons.lang3.StringUtils;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import com.dfmy.dao.sys.SysProfessionDao;
import com.dfmy.entity.sys.SysProfession;
import com.dfmy.service.sys.SysProfessionService;


@Service
public class SysProfessionServiceImpl implements SysProfessionService{

	@Resource
	private SysProfessionDao sysProfessionDao;
	
	@Override
	public SysProfession saveProfession(SysProfession Profession) {
		return sysProfessionDao.save(Profession);
	}

	@Override
	public SysProfession findProfession(String ProfessionId) {
		return sysProfessionDao.findOne(ProfessionId);
	}

	@Override
	public void deleteProfession(String ProfessionId) {
		sysProfessionDao.delete(ProfessionId);
	}

	@Override
	public Page<SysProfession> pageList(int pageNumber,int pageSize,String sortColom,final SysProfession Profession) throws SocketException{
		Pageable pageable = new PageRequest(pageNumber-1, pageSize, Sort.Direction.ASC,sortColom); 
		Page<SysProfession> sysProfession = sysProfessionDao.findAll(new Specification<SysProfession>(){  
	            @Override  
	            public Predicate toPredicate(Root<SysProfession> root, CriteriaQuery<?> query, CriteriaBuilder criteriaBuilder) {  
	            	 List<Predicate> list = new ArrayList<Predicate>();  
	                 if(StringUtils.isNotBlank(Profession.getName())){  
	                     list.add(criteriaBuilder.like(root.get("name").as(String.class), "%" +Profession.getName()+"%"));  
	                 }  
	                 if(null!=Profession.getCreateTime() && !"".equals(Profession.getCreateTime())){  
	                     list.add(criteriaBuilder.like(root.get("createTime").as(String.class),"%"+ Profession.getCreateTime()+"%"));  
	                 }  
//	                 if(StringUtils.isNotBlank(Profession.DE)){  
//	                	 Path<String> org=root.get("parentMenu").get("name");  
//                         list.add(criteriaBuilder.like(org,"%"+menu.getpName()+"%"));
//	                 }  
	                 //list.add(criteriaBuilder.equal(root.get("isVisual").as(String.class),"1"));  
	                 Predicate[] p = new Predicate[list.size()];  
	                 return criteriaBuilder.and(list.toArray(p));
	            }  
	        },pageable); 
		 return sysProfession;
	}

	

	@Override
	public SysProfession findByName(String Name) {
		// TODO Auto-generated method stub
		return sysProfessionDao.findByName(Name);
	}

	@Override
	public List<SysProfession> findTopList() {
		// TODO Auto-generated method stub
		return sysProfessionDao.findTopList();
	}

	@Override
	public SysProfession findProfeByName(String bm) {
		// TODO Auto-generated method stub
		return sysProfessionDao.findProfeByName(bm);
	}

	@Override
	public List<SysProfession> findByDeptId(String deptId) {
		// TODO Auto-generated method stub
		return sysProfessionDao.findByDeptId(deptId);
	}
}
