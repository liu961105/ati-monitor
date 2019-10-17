package com.dfmy.controller.sys;

import java.util.List;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.subject.Subject;
import org.hibernate.exception.ConstraintViolationException;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dfmy.controller.common.BaseController;
import com.dfmy.entity.ResultEntity;
import com.dfmy.entity.sys.SysMenu;
import com.dfmy.service.sys.SysMenuService;
import com.dfmy.util.MenuUtil;
import com.dfmy.util.StringHelper;
import com.dfmy.util.TimeHelper;

/**
 * 系统用户管理
 * 
 */
@Controller
@RequestMapping("sysMenu")
public class SysMenuController extends BaseController {
	@Resource
	private SysMenuService sysMenuService;

	/**
	 * 分页菜单列表
	 * @return
	 */
	@RequestMapping("pageList")
	@RequiresPermissions("sysMenu:pageList")
	@ResponseBody
	private ResultEntity pageList(@RequestParam(value = "pageCurrent", defaultValue = "1") String pageCurrent,SysMenu menu) {
		ResultEntity res = new ResultEntity();
		try {
			Page<SysMenu> menuPage = sysMenuService.pageList(Integer.parseInt(pageCurrent), PAGESIZE, "createTime",menu);
			if (menuPage.getTotalPages() > 0) {
				res.setData(menuPage);
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
	 * @param menu
	 * @return
	 */
	@RequestMapping("saveMenu")
	@ResponseBody
	public ResultEntity saveMenu(SysMenu menu,String parentMenuPid){
		ResultEntity res = new ResultEntity();
		Subject currentUser = SecurityUtils.getSubject();
		try {
			if(StringUtils.isNotBlank(parentMenuPid)){
				SysMenu pmenu = new  SysMenu();
				pmenu.setMenuId(parentMenuPid);
				menu.setParentMenu(pmenu);
			}
			if(StringUtils.isNotBlank(menu.getMenuId())){
				menu.setUpdateTime(TimeHelper.getCurrentTime());
				menu.setUpdateUser((String)currentUser.getPrincipal());
			}else{
				menu.setCreateTime(TimeHelper.getCurrentTime());
				menu.setCreateUser((String)currentUser.getPrincipal());
			}
			sysMenuService.saveMenu(menu);
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
	 * @param menu
	 * @return
	 */
	@RequestMapping("delMenu")
	@ResponseBody
	public ResultEntity delMenu(String ID){
		ResultEntity res = new ResultEntity();
		String meg="";
		try {
			String[] ids = ID.split(",");
			for (int i = 0; i < ids.length; i++) {
				//SysMenu menu = sysMenuService.findMenu(ids[i]);
				sysMenuService.deleteMenu(ids[i]);
				/*if(menu !=null){
					List<SysMenu> list = sysMenuService.findByParentMenu(menu);
					if(list !=null && list.size()>0){
						meg+=menu.getName()+"有下级菜单，不能删除！";
					}else{
						sysMenuService.deleteMenu(ids[i]);
					}
				}*/
			}
			
			res.setMessage(StringHelper.isNotBlack(meg)?meg:DELETE_SUCCESS);
			res.setSuccess(SUCCESS);
		} catch (ConstraintViolationException e) {
			e.printStackTrace();
			res.setMessage("删除失败：没有删除与这条数据管理的相关数据");
			res.setSuccess(ERROR);
		} catch(Exception e){
			e.printStackTrace();
			res.setMessage(DELETE_ERROR+":"+e.getMessage());
			res.setSuccess(ERROR);
		}
		return res;
	}
	
	/**
	 * 查询单个用户
	 * @param menu
	 * @return
	 */
	@RequestMapping("findMenu")
	@ResponseBody
	public ResultEntity findMenu(String ID){
		ResultEntity res = new ResultEntity();
		try {
			res.setData(sysMenuService.findMenu(ID));
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
	 * 查询上级菜单
	 * @param dept
	 * @return
	 */
	@RequestMapping("findTopList")
	@ResponseBody
	public ResultEntity findTopList(){
		ResultEntity res = new ResultEntity();
		try {
			res.setData(MenuUtil.getAllDepartments(sysMenuService.findTopList()));
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
	 * 查询上级菜单
	 * @param dept
	 * @return
	 */
	@RequestMapping("findAll")
	@ResponseBody
	public ResultEntity findAll(){
		ResultEntity res = new ResultEntity();
		try {
			res.setData(sysMenuService.findAll());
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
