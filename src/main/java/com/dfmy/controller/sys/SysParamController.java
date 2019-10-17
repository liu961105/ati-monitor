package com.dfmy.controller.sys;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.subject.Subject;
import org.hibernate.exception.ConstraintViolationException;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dfmy.controller.common.BaseController;
import com.dfmy.entity.ResultEntity;
import com.dfmy.entity.sys.SysParam;
import com.dfmy.service.sys.SysParamService;
import com.dfmy.util.ParamUtil;
import com.dfmy.util.TimeHelper;

@Controller
@RequestMapping("sysParam")
public class SysParamController extends BaseController {
	@Resource
	private SysParamService sysParamService;

	/**
	 * 分页参数列表
	 * @return
	 */
	@RequestMapping("pageList")
	@RequiresPermissions("sysParam:pageList")
	@ResponseBody
	private ResultEntity pageList(@RequestParam(value = "pageCurrent", defaultValue = "1") String pageCurrent,SysParam param) {
		ResultEntity res = new ResultEntity();
		try {
			Page<SysParam> paramPage = sysParamService.pageList(Integer.parseInt(pageCurrent), PAGESIZE, "createTime",param);
			if (paramPage.getTotalPages() > 0) {
				res.setData(paramPage);
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
	 * 保存参数
	 * @param menu
	 * @return
	 */
	@RequestMapping("saveParam")
	@ResponseBody
	public ResultEntity saveParam(SysParam param,String parentParamPid){
		ResultEntity res = new ResultEntity();
		Subject currentUser = SecurityUtils.getSubject();
		try {
			if(StringUtils.isNotBlank(parentParamPid)){
				SysParam pParam = new  SysParam();
				pParam.setParamId(parentParamPid);
				param.setParentParam(pParam);
			}
			if(StringUtils.isNotBlank(param.getParamId())){
				param.setUpdateTime(TimeHelper.getCurrentTime());
				param.setUpdateUser((String)currentUser.getPrincipal());
			}else{
				param.setCreateTime(TimeHelper.getCurrentTime());
				param.setCreateUser((String)currentUser.getPrincipal());
			}
			sysParamService.saveParam(param);
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
	 * 删除参数
	 * @param menu
	 * @return
	 */
	@RequestMapping("delParam")
	@ResponseBody
	public ResultEntity delParam(String ID){
		ResultEntity res = new ResultEntity();
		try {
			
			String[] ids = ID.split(",");
			for (int i = 0; i < ids.length; i++) {
				if("0".equals(ids[i])){
					res.setMessage("不能删除最高级菜单");
					res.setSuccess(ERROR);
				}else {
					sysParamService.deleteParam(ids[i]);
				}
			}
			res.setMessage(DELETE_SUCCESS);
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
	 * 查询单个参数
	 * @param menu
	 * @return
	 */
	@RequestMapping("findParam")
	@ResponseBody
	public ResultEntity findParam(String ID){
		ResultEntity res = new ResultEntity();
		try {
			res.setData(sysParamService.findParam(ID));
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
	 * 根据父级查询参数
	 * @param menu
	 * @return
	 */
	@RequestMapping("findChildParam")
	@ResponseBody
	public ResultEntity findParamByPid(String ID){
		ResultEntity res = new ResultEntity();
		try {
			res.setData(sysParamService.findParamByPid(ID));
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
	 * 查询上级参数
	 * @param dept
	 * @return
	 */
	@RequestMapping("findTopList")
	@ResponseBody
	public ResultEntity findTopList(){
		ResultEntity res = new ResultEntity();
		try {
			res.setData(ParamUtil.getAllDepartments(sysParamService.findTopList()));
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
	 * 查询上级参数
	 * @param dept
	 * @return
	 */
	@RequestMapping("findAll")
	@ResponseBody
	public ResultEntity findAll(){
		ResultEntity res = new ResultEntity();
		try {
			res.setData(sysParamService.findPrentParamList());
			res.setMessage(GET_SUCCESS);
			res.setSuccess(SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			res.setMessage(GET_ERROR + ":" + e.getMessage());
			res.setSuccess(ERROR);
		}
		return res;
	}
	
	@RequestMapping("/sonPageMain")
	public String sonPageMain(Model model,String paramId){
		SysParam sysParam = sysParamService.findParam(paramId);
		model.addAttribute("paramId", paramId);
		model.addAttribute("pname", sysParam.getParamName());
		return "/manage/sys/sys_sonParamList";
	}
	
	/**
	 * 分页参数列表
	 * @return
	 */
	@RequestMapping("sonPageList")
	@ResponseBody
	private ResultEntity sonPageList(@RequestParam(value = "pageCurrent", defaultValue = "1") String pageCurrent,SysParam param,HttpServletRequest request) {
		ResultEntity res = new ResultEntity();
		try {
			Page<SysParam> paramPage = sysParamService.pageSonList(Integer.parseInt(pageCurrent), PAGESIZE, "createTime",param);
			if (paramPage.getTotalPages() > 0) {
				res.setData(paramPage);
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
}
