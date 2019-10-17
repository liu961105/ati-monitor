package com.dfmy.controller.sys;

import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dfmy.controller.common.BaseController;
import com.dfmy.entity.ResultEntity;
import com.dfmy.entity.sys.SysMenu;
import com.dfmy.entity.sys.SysRole;
import com.dfmy.service.sys.SysMenuService;
import com.dfmy.service.sys.SysRoleService;
import com.dfmy.service.sys.SysUserService;
import com.dfmy.util.TimeHelper;

/**
 * 系统角色管理
 * 
 */
@Controller
@RequestMapping("sysRole")
public class SysRoleController extends BaseController {
	@Resource
	private SysRoleService sysRoleService;
	@Resource
	private SysMenuService sysMenuService;
	@Autowired
	private SysUserService sysUserService;

	/**
	 * 分页用户列表
	 * 
	 * @return
	 */
	@RequiresPermissions("sysRole:pageList")
	@RequestMapping("pageList")
	@ResponseBody
	private ResultEntity pageList(@RequestParam(value = "pageCurrent", defaultValue = "1") String pageCurrent,SysRole role) {
		ResultEntity res = new ResultEntity();
		try {
			Page<SysRole> rolePage = sysRoleService.pageList(Integer.parseInt(pageCurrent), PAGESIZE, "createTime",role);
			if (rolePage.getTotalPages() > 0) {
				res.setData(rolePage);
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
	 * 保存用户
	 * @param role
	 * @return
	 */
	@RequestMapping("saveRole")
	@ResponseBody
	public ResultEntity saveRole(SysRole role){
		ResultEntity res = new ResultEntity();
		try {
			if(StringUtils.isNotBlank(role.getRoleId())){
				SysRole oldRole = sysRoleService.findRole(role.getRoleId());
				oldRole.setName(role.getName());
				oldRole.setRemark(role.getRemark());
				oldRole.setUpdateTime(TimeHelper.getCurrentTime());
				sysRoleService.saveRole(oldRole);
			}else{
				role.setCreateTime(TimeHelper.getCurrentTime());
				sysRoleService.saveRole(role);
			}
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
	 * 删除用户
	 * @param Role
	 * @return
	 */
	@RequestMapping("delRole")
	@ResponseBody
	public ResultEntity delRole(String ID){
		ResultEntity res = new ResultEntity();
		try {
			String[] ids =ID.split(",");
			for (int i = 0; i < ids.length; i++) {
				sysRoleService.deleteRole(ids[i]);
			}
			res.setMessage(DELETE_SUCCESS);
			res.setSuccess(SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			res.setMessage(DELETE_ERROR + ":" + e.getMessage());
			res.setSuccess(ERROR);
		}
		return res;
	}
	
	/**
	 * 查询单个用户
	 * @param Role
	 * @return
	 */
	@RequestMapping("findRole")
	@ResponseBody
	public ResultEntity findRole(String ID){
		ResultEntity res = new ResultEntity();
		try {
			res.setData(sysRoleService.findRole(ID));
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
	 * 查询所有角色
	 * @param Role
	 * @return
	 */
	@RequestMapping("queryAll")
	@ResponseBody
	public ResultEntity queryAll(){
		ResultEntity res = new ResultEntity();
		try {
			res.setData(sysRoleService.findAllRole());
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
	 * 设置权限
	 * @param role
	 * @param menuIds
	 * @return
	 */
	@RequestMapping("saveMenu")
	@ResponseBody
	public ResultEntity saveMenu(SysRole role,String menuIds){
		role = sysRoleService.findRole(role.getRoleId());
		Subject currentUser = SecurityUtils.getSubject();
		ResultEntity res = new ResultEntity();
		try {
			if(StringUtils.isNotBlank(role.getRoleId())){
				role.setUpdateTime(TimeHelper.getCurrentTime());
				role.setCreateUser((String)currentUser.getPrincipal());
			}else{
				role.setCreateTime(TimeHelper.getCurrentTime());
				role.setUpdateUser((String)currentUser.getPrincipal());
			}
			if(StringUtils.isNotBlank(menuIds)){
				String[] menuArray = menuIds.split(",");
				List<SysMenu> menus = new ArrayList<SysMenu>();
				for(String menuid : menuArray){
					menus.add(sysMenuService.findMenu(menuid));
				}
				role = sysRoleService.findRole(role.getRoleId());
				role.setMemus(menus);
			}else{
				role.setMemus(null);
			}
			sysRoleService.saveRole(role);
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
	 * 权限回显
	 * @param roleId
	 * @return
	 */
	@RequestMapping("findAuthority")
	@ResponseBody
	public ResultEntity findAuthority(String roleId){
		ResultEntity res = new ResultEntity();
		try {
			
			if(StringUtils.isNotBlank(roleId)){
				SysRole role = sysRoleService.findRole(roleId);
				res.setData(role);
			}
			res.setMessage(OPERATE_SUCCESS);
			res.setSuccess(SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			res.setMessage(OPERATE_ERROR + ":" + e.getMessage());
			res.setSuccess(ERROR);
		}
		return res;
	}
}
