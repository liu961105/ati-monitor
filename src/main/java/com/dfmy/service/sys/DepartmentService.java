package com.dfmy.service.sys;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.jpa.domain.Specification;

import com.dfmy.entity.sys.SysDepartment;


/**
 * <p>
 * Title:部门管理接口
 * </p>
 * 
 * <p>
 * Description:部门管理接口
 * </p>
 * 
 * @author wangjl
 * @date 2014-7-10 
 */
public interface DepartmentService {
    /**
     * 
     * TODO(保存或修改对象)
     * @param sysDepartment
     * @return
     * @throws Exception SysDepartment  返回类型 
     * @throws
     */
	public SysDepartment save(SysDepartment sysDepartment) throws Exception;
	
	
	/**
	 * 
	 * TODO(根据主键删除对象)
	 * @param id
	 * @throws Exception void  返回类型 
	 * @throws
	 */
	public void delete(String id) throws Exception;
	
	/**
	 * 
	 * TODO(根据主键查找对象)
	 * @param id
	 * @return
	 * @throws Exception SysDepartment  返回类型 
	 * @throws
	 */
	public SysDepartment findByKey(String id) throws Exception;
	/**
	 * 
	 * TODO(根据编码查找部门对象)
	 * @param code
	 * @return
	 * @throws Exception SysDepartment  返回类型 
	 * @throws
	 */
	public SysDepartment findByCode(String code,String companyId) throws Exception;
	

	
	/**
	 * 
	 * TODO(部门分页方法)
	 * @param spec
	 * @param pageRequest
	 * @return Page<SysDepartment>  返回类型 
	 * @throws
	 */
	public Page<SysDepartment> getPage(int pageNumber,int pageSize,String sortColom,String companyId) ;
	
	/**
	 * 
	 * TODO(查询所有部门列表)
	 * @return List<SysDepartment>  返回类型 
	 * @throws
	 */
	List<SysDepartment> getAll();
	/**
	 * 验证部门名称的唯一性
	 * @param deptNameInput
	 * @param deptCode
	 * @return
	 */
	public List<SysDepartment> checkUniqueDeptName(String deptNameInput,String deptCode,String companyId);
	/**
	 * 
	 * TODO(查询部门树根节点)
	 * @param setId
	 * @return
	 * @throws Exception List<SysDepartment>  返回类型 
	 * @throws
	 */
	public List<SysDepartment> findBySetIdAndParentDeptIsNull(String setId) throws Exception;
	/**
	 * 
	 * TODO(根据父级部门编码查询部门列表)
	 * @param parentDeptCode
	 * @return
	 * @throws Exception List<SysDepartment>  返回类型 
	 * @throws
	 */
	public List<SysDepartment> findByParentDeptCodeAndComId(String parentDeptCode,String companyId) throws Exception;
	
	/**
	 * 根据公司主键查询机构信息
	 * @param companyId
	 * @return
	 */
	public List<SysDepartment> findByCompanyId(String companyId) throws Exception;
	
	
	/**
	 * 根据公司主键查询所有机构信息
	 * @param companyId
	 * @return
	 */
	public List<SysDepartment> findAllByCompanyId(String companyId) throws Exception;

}
