package com.dfmy.service.sys.impl;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Path;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.apache.commons.lang3.StringUtils;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import com.dfmy.dao.sys.SysLogDao;
import com.dfmy.entity.sys.SysLog;
import com.dfmy.entity.sys.SysParam;
import com.dfmy.service.sys.SysLogService;

@Service
public class SysLogServiceImpl implements SysLogService {
	@Resource
	private SysLogDao sysLogDao;
	@Override
	public SysLog save(SysLog sysLog) {
		return sysLogDao.save(sysLog);
	}
	
	@Override
	public Page<SysLog> pageList(int pageNumber,int pageSize,String sortColom,final SysLog log) {
		Pageable pageable = new PageRequest(pageNumber-1, pageSize, Sort.Direction.DESC,sortColom); 
		Page<SysLog> sysLog = sysLogDao.findAll(new Specification<SysLog>(){  
            @Override  
            public Predicate toPredicate(Root<SysLog> root, CriteriaQuery<?> query, CriteriaBuilder criteriaBuilder) {  
            	 List<Predicate> list = new ArrayList<Predicate>();  
                 if(StringUtils.isNotBlank(log.getCreateuser())){  
                     list.add(criteriaBuilder.like(root.get("createuser").as(String.class), "%" +log.getCreateuser()+"%"));  
                 }
                 if(StringUtils.isNotBlank(log.getBusinssName())){  
                     list.add(criteriaBuilder.like(root.get("businssName").as(String.class), "%" +log.getBusinssName()+"%"));  
                 } 
                 Predicate[] p = new Predicate[list.size()];  
                 return criteriaBuilder.and(list.toArray(p));
            }  
        },pageable); 
	 return sysLog;
	}

}
