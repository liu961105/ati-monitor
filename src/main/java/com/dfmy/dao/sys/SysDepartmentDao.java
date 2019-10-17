package com.dfmy.dao.sys;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.dfmy.entity.sys.SysDepartment;


/**
 * 
 * TODO(部门Dao类)
 * @author zhangxj
 * @date 2017年12月4日下午2:51:05
 *
 */
public interface SysDepartmentDao extends
		PagingAndSortingRepository<SysDepartment, String>,
		JpaSpecificationExecutor<SysDepartment> {

    /**
     * 
     * TODO(根据主键查部门)
     * @param deptId
     * @return SysDepartment  返回类型 
     * @throws
     */
	public SysDepartment findByDeptId(String deptId);
	/**
	 * 
	 * TODO(根据部门编码查部门信息)
	 * @param deptCode
	 * @return SysDepartment  返回类型 
	 * @throws
	 */
	@Query("select t from SysDepartment t where  t.deptCode =?1 and t.companyId =?2")
	public SysDepartment findByDeptCode(String deptCode,String companyId);
	/**
	 * 
	 * TODO(查询有效的部门列表数据并排序)
	 * @param deptState
	 * @return List<SysDepartment>  返回类型 
	 * @throws
	 */
	public List<SysDepartment> findByStateOrderByDeptSeqAsc(String state);
	/**
	 * 
	 * TODO(根据父部门编码查需有效的子部门列表)
	 * @param parentId
	 * @param deptState
	 * @return List<SysDepartment>  返回类型 
	 * @throws
	 */
	public List<SysDepartment> findByParentDeptCode(String parentId,String state);
	/**
	 * 验证部门名称的唯一性
	 * @param deptNameInput
	 * @param deptCode
	 * @return
	 */
	@Query("select t from SysDepartment t where  t.deptName =?1  and t.deptCode like %?2 and t.companyId =?3")
	public List<SysDepartment> findByDeptNameAndLikeDeptCode(String deptNameInput, String deptCode,String companyId);
	
	/**
	 * 根据父级部门编码查询部门列表
	 * @param parentDeptCode
	 * @return
	 */
	@Query("select t from SysDepartment t where  t.parentDeptCode =?1 and t.companyId = ?2")
	public List<SysDepartment> findByParentDeptCodeAndComId(String parentDeptCode,String companyId);
	/**
	 * 查询部门树的根节点
	 * @return
	 */
	public List<SysDepartment> findByParentDeptCodeIsNull();
	
	@Query("select t from SysDepartment t where  t.companyId =? and t.parentDeptCode='0'")
	public List<SysDepartment> findByCompanyId(String companyId);
	
	@Query("select t from SysDepartment t where  t.companyId =?")
	public List<SysDepartment> findAllByCompanyId(String companyId);
}
