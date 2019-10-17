package com.dfmy.service.sys.impl;

import java.net.SocketException;
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

import com.dfmy.dao.sys.SysCompanyInfoDao;
import com.dfmy.entity.sys.SysCompanyInfo;
import com.dfmy.entity.sys.SysUser;
import com.dfmy.service.sys.SysCompanyInfoService;

@Service("SysCompanyInfoService")
public class SysCompanyInfoServiceImpl implements SysCompanyInfoService{
	
	@Autowired
	private SysCompanyInfoDao sysCompanyInfoDao;

	@Override
	public Page<SysCompanyInfo> getCompanyPage(int pageNumber, int pageSize, String sortColom,
			final SysCompanyInfo companyInfo)  throws SocketException{
		Pageable pageable = new PageRequest(pageNumber-1, pageSize, Sort.Direction.ASC,sortColom); 
		Page<SysCompanyInfo> sysCompanyInfo = sysCompanyInfoDao.findAll(new Specification<SysCompanyInfo>(){  
	            @Override  
	            public Predicate toPredicate(Root<SysCompanyInfo> root, CriteriaQuery<?> query, CriteriaBuilder criteriaBuilder) {  
	            	 List<Predicate> list = new ArrayList<Predicate>();  
	                 if(StringUtils.isNotBlank(companyInfo.getName())){  
	                     list.add(criteriaBuilder.like(root.get("name").as(String.class), "%" +companyInfo.getName()+"%"));  
	                 }  
	                 if(StringUtils.isNotBlank(companyInfo.getCreateTime())){  
	                     list.add(criteriaBuilder.like(root.get("createTime").as(String.class),"%"+ companyInfo.getCreateTime()+"%"));  
	                 } 
	                 Predicate[] p = new Predicate[list.size()];  
	                 return criteriaBuilder.and(list.toArray(p));
	            }  
	        },pageable); 
		 return sysCompanyInfo;
	}

	@Override
	public SysCompanyInfo saveCompany(SysCompanyInfo companyInfo) throws SocketException{
		return sysCompanyInfoDao.save(companyInfo);
		
	}

	@Override
	public void deleteCompany(String companyId)  throws SocketException{
		sysCompanyInfoDao.delete(companyId);
		
	}

	@Override
	public SysCompanyInfo findOne(String companyId) throws SocketException {
		// TODO Auto-generated method stub
		return sysCompanyInfoDao.findOne(companyId);
	}

}
