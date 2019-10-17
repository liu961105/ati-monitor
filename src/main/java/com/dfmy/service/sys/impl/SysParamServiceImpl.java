package com.dfmy.service.sys.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Path;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.dfmy.dao.sys.SysParamDao;
import com.dfmy.entity.sys.SysParam;
import com.dfmy.service.sys.SysParamService;

@Service
public class SysParamServiceImpl implements SysParamService {

	@Autowired
	private SysParamDao sysParamDao;
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Override
	public Page<SysParam> pageList(int pageNumber,int pageSize,String sortColom, final SysParam param) {
		Pageable pageable = new PageRequest(pageNumber-1, pageSize, Sort.Direction.ASC,sortColom); 
		Page<SysParam> sysParam = sysParamDao.findAll(new Specification<SysParam>(){  
	            @Override  
	            public Predicate toPredicate(Root<SysParam> root, CriteriaQuery<?> query, CriteriaBuilder criteriaBuilder) {  
	            	 List<Predicate> list = new ArrayList<Predicate>(); 
                	 
	                 if(StringUtils.isNotBlank(param.getParamName())){  
	                     list.add(criteriaBuilder.like(root.get("paramName").as(String.class), "%" +param.getParamName()+"%"));  
	                 }
	                 if(StringUtils.isNotBlank(param.getParamCode())){  
	                     list.add(criteriaBuilder.like(root.get("paramCode").as(String.class), "%" +param.getParamCode()+"%"));  
	                 } 
	                 if(StringUtils.isNotBlank(param.getCreateTime())){  
	                     list.add(criteriaBuilder.like(root.get("createTime").as(String.class),"%"+ param.getCreateTime()+"%"));  
	                 }  
	                 if(StringUtils.isNotBlank(param.getpName())){  
	                	 Path<String> org=root.get("parentParam").get("paramName");  
                         list.add(criteriaBuilder.like(org,"%"+param.getpName()+"%"));
	                 } 
	                 Path<String> org=root.get("parentParam").get("paramCode");  
                     list.add(criteriaBuilder.like(org,"0"));
	                 Predicate[] p = new Predicate[list.size()];  
	                 return criteriaBuilder.and(list.toArray(p));
	            }  
	        },pageable); 
		 return sysParam;
	}
	
	@Override
	public Page<SysParam> pageSonList(int pageNumber,int pageSize,String sortColom,final SysParam param){
		Pageable pageable = new PageRequest(pageNumber-1, pageSize, Sort.Direction.ASC,sortColom); 
		Page<SysParam> sysParam = sysParamDao.findAll(new Specification<SysParam>(){  
	            @Override  
	            public Predicate toPredicate(Root<SysParam> root, CriteriaQuery<?> query, CriteriaBuilder criteriaBuilder) {  
	            	 List<Predicate> list = new ArrayList<Predicate>(); 
            		 Path<String> org=root.get("parentParam").get("paramId");  
                     list.add(criteriaBuilder.like(org,param.getParamId()));
                	 
	                 if(StringUtils.isNotBlank(param.getParamName())){  
	                     list.add(criteriaBuilder.like(root.get("paramName").as(String.class), "%" +param.getParamName()+"%"));  
	                 }  
	                 if(StringUtils.isNotBlank(param.getCreateTime())){  
	                     list.add(criteriaBuilder.like(root.get("createTime").as(String.class),"%"+ param.getCreateTime()+"%"));  
	                 }  
	                 if(StringUtils.isNotBlank(param.getpName())){  
	                	 Path<String> org1=root.get("parentParam").get("paramName");  
                         list.add(criteriaBuilder.like(org1,"%"+param.getpName()+"%"));
	                 } 
	                 Predicate[] p = new Predicate[list.size()];  
	                 return criteriaBuilder.and(list.toArray(p));
	            }  
	        },pageable); 
		 return sysParam;
	}

	@Override
	public SysParam saveParam(SysParam param) {
		return sysParamDao.save(param);
	}

	@Override
	public void deleteParam(String iD) {
		sysParamDao.delete(iD);
	}

	@Override
	public SysParam findParam(String iD) {
		return sysParamDao.findOne(iD);
	}

	@Override
	public List<SysParam> findTopList() {
		return sysParamDao.findTopList();
	}

	@Override
	public List<Map<String, Object>> findAll() {
		return jdbcTemplate.queryForList("select t.param_id,t.param_name,t.param_code,t.parent_code from sys_param t order by t.order_num desc");
	}

	@Override
	public List<SysParam> findByParentCode(SysParam parentParam) {
		// TODO Auto-generated method stub
		return sysParamDao.findByParentCode(parentParam);
	}

	@Override
	public SysParam findByPcodeAndCode(SysParam parentCode, String code) {
		// TODO Auto-generated method stub
		return sysParamDao.findByPCodeAndCode(parentCode, code);
	}
	
	@Override
	public SysParam findByParamCode(String paramCode) {
		return sysParamDao.findByParamCode(paramCode);
	}

	@Override
	public List<SysParam> findParamByPid(String iD) {
		// TODO Auto-generated method stub
		return sysParamDao.findByparentCode(iD);
	}

	@Override
	public List<Map<String,Object>> findPrentParamList() {
		// TODO Auto-generated method stub
		return jdbcTemplate.queryForList("select t.param_id,t.param_name,t.param_code,t.parent_code from sys_param t where t.parent_code='0' OR t.param_code = '0' order by t.order_num desc");
	}
	
	@Override
	public List<Map<String, Object>> getListByParentParamCodeIn(String paramCodeIn) {
		return jdbcTemplate.queryForList("SELECT a.* FROM sys_param a WHERE a.parent_code IN (SELECT b.param_id FROM sys_param b WHERE b.param_code IN ('trouble_location','trouble_ration'))  AND a.param_code IN ("+paramCodeIn+");");
	}
	
	@Override
	public List<SysParam> findByStatus (String status) {
		return sysParamDao.findByStatus(status);
	}

}
