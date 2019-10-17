package com.dfmy.service.index.impl;

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

import com.dfmy.dao.index.IndexRemindDao;
import com.dfmy.entity.index.IndexRemind;
import com.dfmy.service.index.IndexRemindService;



@Service
public class IndexRemindServiceImpl implements IndexRemindService{

	@Resource
	private IndexRemindDao remindDao;
	@Override
	public IndexRemind saveIndexRemind(IndexRemind IndexRemind) {
		return remindDao.save(IndexRemind);
	}

	@Override
	public IndexRemind findIndexRemind(String IndexRemindId) {
		return remindDao.findOne(IndexRemindId);
	}

	@Override
	public void deleteIndexRemind(String IndexRemindId) {
		remindDao.delete(IndexRemindId);
	}

	@Override
	public Page<IndexRemind> pageList(int pageNumber,int pageSize,String sortColom,final IndexRemind IndexRemind) throws SocketException{
		Pageable pageable = new PageRequest(pageNumber-1, pageSize, Sort.Direction.ASC,sortColom); 
		Page<IndexRemind> remind = remindDao.findAll(new Specification<IndexRemind>(){  
	            @Override  
	            public Predicate toPredicate(Root<IndexRemind> root, CriteriaQuery<?> query, CriteriaBuilder criteriaBuilder) {  
	            	 List<Predicate> list = new ArrayList<Predicate>();  
	                 if(StringUtils.isNotBlank(IndexRemind.getName())){  
	                     list.add(criteriaBuilder.like(root.get("IndexRemindName").as(String.class), "%" +IndexRemind.getName()+"%"));  
	                 }  
	                 if(null!=IndexRemind.getCreateTime() && !"".equals(IndexRemind.getCreateTime())){  
	                     list.add(criteriaBuilder.like(root.get("createTime").as(String.class),"%"+ IndexRemind.getCreateTime()+"%"));  
	                 }  
//	                 if(StringUtils.isNotBlank(IndexRemind.DE)){  
//	                	 Path<String> org=root.get("parentMenu").get("name");  
//                         list.add(criteriaBuilder.like(org,"%"+menu.getpName()+"%"));
//	                 }  
	                 //list.add(criteriaBuilder.equal(root.get("isVisual").as(String.class),"1"));  
	                 Predicate[] p = new Predicate[list.size()];  
	                 return criteriaBuilder.and(list.toArray(p));
	            }  
	        },pageable); 
		 return remind;
	}

	/*@Override
	public IndexRemind findByIndexRemindName(String IndexRemindName) {
		return remindDao.findByIndexRemindName(IndexRemindName);
	}

	@Override
	public IndexRemind login(String IndexRemindName, String password) {
		return remindDao.findByIndexRemindNameAndPassword(IndexRemindName,password);
	}*/
}
