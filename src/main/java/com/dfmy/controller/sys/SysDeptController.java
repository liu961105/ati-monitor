package com.dfmy.controller.sys;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dfmy.controller.common.BaseController;
import com.dfmy.entity.ResultEntity;
import com.dfmy.entity.sys.SysDept;
import com.dfmy.entity.sys.SysProfession;
import com.dfmy.entity.sys.SysUser;
import com.dfmy.service.sys.SysDeptService;
import com.dfmy.service.sys.SysProfessionService;
import com.dfmy.service.sys.SysUserService;
import com.dfmy.util.DepartmentUtil;
import com.dfmy.util.StringHelper;
import com.dfmy.util.TimeHelper;

/**
 * 系统部门管理
 * 
 */
@Controller
@RequestMapping("sysDept")
public class SysDeptController extends BaseController {
	@Resource
	private SysDeptService sysDeptService;
	@Autowired
	private SysUserService	sysUserService;
	@Autowired
	private SysProfessionService sysProfessionService;

	/**
	 * 分页部门列表
	 * 
	 * @return
	 */
	@RequiresPermissions("sysDept:pageList")
	@RequestMapping("pageList")
	@ResponseBody
	private ResultEntity pageList(@RequestParam(value = "pageCurrent", defaultValue = "1") String pageCurrent,SysDept dept) {
		ResultEntity res = new ResultEntity();
		try {
			Page<SysDept> deptPage = sysDeptService.pageList(Integer.parseInt(pageCurrent), PAGESIZE, "createTime",dept);
			if (deptPage.getTotalPages() > 0) {
				res.setData(deptPage);
				res.setMessage(GET_SUCCESS);
				res.setSuccess(SUCCESS);
			} else {
				res.setMessage(IS_NULL);
				res.setSuccess(NULL);
			}
		} catch (Exception e) {
			e.printStackTrace();
			res.setMessage(GET_ERROR + ":" + e.getMessage());
			res.setSuccess(ERROR);
		}
		return res;
	}
	
	/**
	 * 保存部门
	 * @param dept
	 * @return
	 */
	@RequestMapping("saveDept")
	@ResponseBody
	public ResultEntity saveDept(SysDept dept,String parentDeptIds){
		
		ResultEntity res = new ResultEntity();
		Subject currentUser = SecurityUtils.getSubject();
		try {
			//设置部门
			if(StringUtils.isNotBlank(parentDeptIds)){
				SysDept pdept = new SysDept();
				pdept.setDeptId(parentDeptIds);
				dept.setParentDept(pdept);
			}
			if(StringUtils.isNotBlank(dept.getDeptId())){
				dept.setUpdateTime(TimeHelper.getCurrentTime());
				dept.setUpdateUser((String)currentUser.getPrincipal());
			}else{
				dept.setCreateTime(TimeHelper.getCurrentTime());
				dept.setCreateUser((String)currentUser.getPrincipal());
			}
			//保存部门
			sysDeptService.saveDept(dept);
			res.setMessage(OPERATE_SUCCESS);
			res.setSuccess(SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			res.setMessage(OPERATE_ERROR + ":" + e.getMessage());
			res.setSuccess(ERROR);
		}
		return res;
	}
	
	
	/**
	 * 删除部门
	 * @param dept
	 * @return
	 */
	@RequestMapping("delDept")
	@ResponseBody
	public ResultEntity delDept(String ID){
		ResultEntity res = new ResultEntity();
		try {
			String errorMsg="";
			String[] ids = ID.split(",");
			for (int i = 0; i < ids.length; i++) {
				SysDept dept = sysDeptService.findDept(ids[i]);
				if(dept !=null){
					//人员表查询
					List<SysUser> userList = sysUserService.findUserBydeptId(dept.getDeptId());
					//部门下级查询
					List<SysDept> deptList = sysDeptService.findByParentDept(dept);
					//岗位查询
					List<SysProfession> professionList = sysProfessionService.findByDeptId(dept.getDeptId());
					if(userList !=null && userList.size()>0){
						errorMsg+=dept.getName()+"下有人员能不能删除 ！";
					}
					
					if(deptList !=null && deptList.size()>0){
						errorMsg+=dept.getName()+"下有下级部门不能删除 ！";
					}
					
					if(professionList !=null && professionList.size()>0){
						errorMsg+=dept.getName()+"下有岗位不能删除 ！";
					}
					if(userList.size()==0 && deptList.size()==0 && professionList.size()==0){
						sysDeptService.deleteDept(ids[i]);
					}
				}
				
			}
			res.setMessage(StringHelper.isNotBlack(errorMsg)?errorMsg:DELETE_SUCCESS);
			res.setSuccess(SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			res.setMessage(DELETE_ERROR + ":" + e.getMessage());
			res.setSuccess(ERROR);
		}
		return res;
	}
	
	/**
	 * 查询单个部门
	 * @param dept
	 * @return
	 */
	@RequestMapping("findDept")
	@ResponseBody
	public ResultEntity findDept(String ID){
		ResultEntity res = new ResultEntity();
		try {
			res.setData(sysDeptService.findDept(ID));
			res.setMessage(GET_SUCCESS);
			res.setSuccess(SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			res.setMessage(GET_ERROR + ":" + e.getMessage());
			res.setSuccess(ERROR);
		}
		return res;
	}

	/**
	 * 查询部门
	 * @param dept
	 * @return
	 */
	@RequestMapping("findTopList")
	@ResponseBody
	public ResultEntity findTopList(){
		ResultEntity res = new ResultEntity();
		try {
			res.setData(DepartmentUtil.getAllDepartments(sysDeptService.findTopList()));
			res.setMessage(GET_SUCCESS);
			res.setSuccess(SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			res.setMessage(GET_ERROR + ":" + e.getMessage());
			res.setSuccess(ERROR);
		}
		return res;
	}
	
	
	/**
	 * 查询单个部门
	 * @param dept
	 * @return
	 */
	@RequestMapping("findDeptByName")
	@ResponseBody
	public ResultEntity findDeptByName(String name){
		ResultEntity res = new ResultEntity();
		try {
			res.setData(sysDeptService.findDeptByName(name));
			res.setMessage(GET_SUCCESS);
			res.setSuccess(SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			res.setMessage(GET_ERROR + ":" + e.getMessage());
			res.setSuccess(ERROR);
		}
		return res;
	}
	
	
	/**
	 * 查询车间
	 * @param pid
	 * @return
	 */
	@RequestMapping("findWkspList")
	@ResponseBody
	public ResultEntity findWkspList(String pid){
		ResultEntity res = new ResultEntity();
		try {
			res.setData(sysDeptService.findWkspList(pid));
			res.setMessage(GET_SUCCESS);
			res.setSuccess(SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			res.setMessage(GET_ERROR + ":" + e.getMessage());
			res.setSuccess(ERROR);
		}
		return res;
	}
	
	
}
