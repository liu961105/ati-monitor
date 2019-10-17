package com.dfmy.controller.sys;

import java.net.SocketException;
import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dfmy.controller.common.BaseController;
import com.dfmy.entity.ResultEntity;
import com.dfmy.entity.sys.SysDept;
import com.dfmy.entity.sys.SysProfession;
import com.dfmy.service.sys.SysDeptService;
import com.dfmy.service.sys.SysLogService;
import com.dfmy.service.sys.SysProfessionService;
import com.dfmy.util.DepartmentUtil;
import com.dfmy.util.ProFeUtil;
import com.dfmy.util.TimeHelper;

/**
 * 岗位管理
 * 
 * @author anix
 *
 */

@Controller
@RequestMapping("sysProfession")
public class SysProfessionController extends BaseController {
	@Resource
	private SysProfessionService sysProfessionService;
	
	@Resource
	private SysDeptService deptsv;
	
	@Resource
	private SysLogService sysLogService;
	//private BaseInfoService baseInfoService;
	
	/**
	 * 分页用户列表
	 * 
	 * @return
	 */
	@RequiresPermissions("sysProfession:pageList")
	@RequestMapping("pageList")
	@ResponseBody
	private ResultEntity pageList(@RequestParam(value = "pageCurrent", defaultValue = "1") String pageCurrent,SysProfession Profession) {
		ResultEntity res = new ResultEntity();
		try {
			Page<SysProfession> ProfessionPage = sysProfessionService.pageList(Integer.parseInt(pageCurrent), PAGESIZE, "createTime",Profession);
			if (ProfessionPage.getTotalPages() > 0) {
				res.setData(ProfessionPage);
				res.setMessage(GET_SUCCESS);
				res.setSuccess(SUCCESS);
			} else {
				res.setMessage(IS_NULL);
				res.setSuccess(NULL);
			}
		} catch(SocketException e){
			e.printStackTrace();
			res.setMessage("网络异常:"+e.getMessage());
			res.setSuccess(ERROR);
		}catch (Exception e) {
			e.printStackTrace();
			res.setMessage(GET_ERROR + ":" + e.getMessage());
			res.setSuccess(ERROR);
		}
		return res;
	}
	
	/**
	 * 保存
	 * @param Profession
	 * @return
	 */
	@RequestMapping("saveProfession")
	@ResponseBody
	public ResultEntity saveProfession(SysProfession Profession,String sysDeptIds,String parentDeptIds){
		ResultEntity res = new ResultEntity();
		//Subject currentProfession = SecurityUtils.getSubject();
		String msg = "";
		try {
				
			/*if(StringUtils.isNotEmpty(sysDeptIds)){
				//设置部门
				SysDept dept = new SysDept();
				dept.setDeptId(sysDeptIds);
				Profession.setSysDept(dept);
			 }*/
			if(StringUtils.isNotEmpty(Profession.getDeptId())){
				//设置部门
				SysDept dept = deptsv.findDept(Profession.getDeptId());
				String deptnameString=dept.getName();
				Profession.setDept_name(deptnameString);
			 }
				//设置上级
			if(StringUtils.isNotBlank(parentDeptIds) && !parentDeptIds.equals(Profession.getProfessionId())){
				SysProfession pdept = new SysProfession();
				pdept.setProfessionId(parentDeptIds);
				Profession.setParentProfession(pdept);
			}else {
				res.setMessage("上级组织不能为空或不能选自己作为上级组织");
				res.setSuccess(ERROR);
				return res;
			}
			Profession.setCreateTime(TimeHelper.getCurrentTime());
			//保存
			sysProfessionService.saveProfession(Profession);
			res.setMessage(OPERATE_SUCCESS);
			res.setSuccess(SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			msg = e.getMessage();
			res.setMessage(OPERATE_ERROR + ":" + msg);
			res.setSuccess(ERROR);
		}
		return res;
	}
	
	
	/**
	 * 删除用户
	 * @param Profession
	 * @return
	 */
	@RequestMapping("delProfession")
	@ResponseBody
	public ResultEntity delProfession(String ID){
		ResultEntity res = new ResultEntity();
		SysProfession sysProfession = null;
		String msg = "";
		try {
			String[] ids = ID.split(",");
			for (int i = 0; i < ids.length; i++) {
				sysProfession = sysProfessionService.findProfession(ID);
				if(sysProfession != null){
					sysProfessionService.deleteProfession(ids[i]);
				}
			}
			res.setMessage(DELETE_SUCCESS);
			res.setSuccess(SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			msg = e.getMessage();
			res.setMessage(DELETE_ERROR + ":" +msg);
			res.setSuccess(ERROR);
		} 
		return res;
	}
	
	/**
	 * 查询单个用户
	 * @param Profession
	 * @return
	 */
	@RequestMapping("findProfession")
	@ResponseBody
	public ResultEntity findProfession(String ID){
		ResultEntity res = new ResultEntity();
		try { 
			res.setData(sysProfessionService.findProfession(ID));
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
	 * 查询上级
	 * @param dept
	 * @return
	 */
	@RequestMapping("findTopList")
	@ResponseBody
	public ResultEntity findTopList(){
		ResultEntity res = new ResultEntity();
		try {
			res.setData(ProFeUtil.getAllProFes(sysProfessionService.findTopList()));
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
