package com.dfmy.service.sys.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

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
import org.springframework.data.domain.Sort.Direction;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dfmy.dao.sys.SysDepartmentDao;
import com.dfmy.entity.sys.SysCompanyInfo;
import com.dfmy.entity.sys.SysDepartment;
import com.dfmy.service.sys.DepartmentService;



/**
 * <p>
 * Title:部门管理接口实现类
 * </p>
 * 
 * <p>
 * Description:部门管理接口实现类
 * </p>
 * 
 * @author wangjl
 * @date 2014-7-10
 */
@Transactional(rollbackFor=Exception.class)
@Service("departmentService")
public class DepartmentServiceImpl implements DepartmentService {
	@Autowired
	private SysDepartmentDao sysDepartmentDao;

	@Override
	public SysDepartment save(SysDepartment sysDepartment) throws Exception {
		return sysDepartmentDao.save(sysDepartment);

	}

	@Override
	public void delete(String id) throws Exception {
		try{
		SysDepartment sysDepartment = this.findByKey(id);
		if (sysDepartment != null){
			sysDepartmentDao.delete(sysDepartment);
		}
		}
		catch(Exception e){
			e.printStackTrace();
		}
	}

	@Override
	public SysDepartment findByKey(String id) throws Exception {
		return sysDepartmentDao.findOne(id);
	}



	/**
	 * 创建分页请求.
	 */
	private PageRequest buildPageRequest(int pageNumber, int pagzSize,
			String sortType) {
		Sort sort = new Sort(Direction.DESC, "createTime");
		return new PageRequest(pageNumber - 1, pagzSize, sort);
	}



	@Override
	public Page<SysDepartment> getPage(int pageNumber,int pageSize,String sortColom,final String companyId) {
		Pageable pageable = new PageRequest(pageNumber-1, pageSize, Sort.Direction.ASC,sortColom); 
		Page<SysDepartment> sysDepartment = sysDepartmentDao.findAll(new Specification<SysDepartment>(){  
	            @Override  
	            public Predicate toPredicate(Root<SysDepartment> root, CriteriaQuery<?> query, CriteriaBuilder criteriaBuilder) {  
	            	 List<Predicate> list = new ArrayList<Predicate>();  
	                 if(StringUtils.isNotBlank(companyId)){  
	                     list.add(criteriaBuilder.equal(root.get("companyId").as(String.class), companyId));  
	                 }  
	                 Predicate[] p = new Predicate[list.size()];  
	                 return criteriaBuilder.and(list.toArray(p));
	            }  
	        },pageable); 
		return sysDepartment;
	}

	@Override
	public List<SysDepartment> getAll() {
		// TODO Auto-generated method stub
		return this.sysDepartmentDao.findByStateOrderByDeptSeqAsc("1");
	}

	@Override
	public SysDepartment findByCode(String code,String companyId) throws Exception {
		// TODO Auto-generated method stub
		return this.sysDepartmentDao.findByDeptCode(code,companyId);
	}

	@Override
	public List<SysDepartment> checkUniqueDeptName(String deptNameInput,
			String deptCode,String companyId) {
		return this.sysDepartmentDao.findByDeptNameAndLikeDeptCode(deptNameInput, deptCode,companyId);
	}

	@Override
	public List<SysDepartment> findBySetIdAndParentDeptIsNull(String setId) throws Exception {
		return sysDepartmentDao.findByParentDeptCodeIsNull();
	}

	@Override
	public List<SysDepartment> findByParentDeptCodeAndComId(String parentDeptCode,String companyId) throws Exception {
		return sysDepartmentDao.findByParentDeptCodeAndComId(parentDeptCode,companyId);
	}

	@Override
	public List<SysDepartment> findByCompanyId(String companyId) throws Exception {
		// TODO Auto-generated method stub
		return sysDepartmentDao.findByCompanyId(companyId);
	}

	@Override
	public List<SysDepartment> findAllByCompanyId(String companyId) throws Exception {
		// TODO Auto-generated method stub
		return sysDepartmentDao.findAllByCompanyId(companyId);
	}

}
