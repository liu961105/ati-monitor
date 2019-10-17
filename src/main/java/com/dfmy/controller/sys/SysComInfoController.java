package com.dfmy.controller.sys;

import java.net.SocketException;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dfmy.controller.common.BaseController;
import com.dfmy.entity.ResultEntity;
import com.dfmy.entity.sys.SysCompanyInfo;
import com.dfmy.service.sys.DepartmentService;
import com.dfmy.service.sys.SysCompanyInfoService;
import com.dfmy.util.TimeHelper;

@Controller
@RequestMapping(value="company")
public class SysComInfoController extends BaseController{
	
	@Autowired
	private SysCompanyInfoService sysCompanyInfoService;
	@Autowired
	private DepartmentService departmentService;
	
	
	/**
	 * 分页查询
	 * @param pageCurrent
	 * @param sysCompanyInfo
	 * @return
	 */
	@RequestMapping(value="/pageList")
	@RequiresPermissions("company:getPageList")
	@ResponseBody
	public ResultEntity pageList(@RequestParam(value = "pageCurrent", defaultValue = "1") String pageCurrent,SysCompanyInfo sysCompanyInfo){
		ResultEntity res = new ResultEntity();
		try {
			Page<SysCompanyInfo> companyPage = sysCompanyInfoService.getCompanyPage(Integer.parseInt(pageCurrent), PAGESIZE, "createTime",sysCompanyInfo);
			if (companyPage.getTotalPages() > 0) {
				res.setData(companyPage);
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
	 * 保存公司
	 * @param menu
	 * @return
	 */
	@RequestMapping("saveCompany")
	@ResponseBody
	public ResultEntity saveCompany(SysCompanyInfo sysCompanyInfo,String companyId){
		ResultEntity res = new ResultEntity();
		try {
			if(StringUtils.isNotBlank(sysCompanyInfo.getCompanyId())){
				sysCompanyInfo.setUpdateTime(TimeHelper.getCurrentTime());
				SysCompanyInfo newComp = sysCompanyInfoService.saveCompany(sysCompanyInfo);
/*				List<SysDepartment> dept = departmentService.findByCompanyId(companyId);
				SysDepartment deptFirst = dept.get(0);
				deptFirst.setDeptName(newComp.getName());
				departmentService.save(deptFirst);*/
			}else{
				sysCompanyInfo.setState("1");
				sysCompanyInfo.setCreateTime(TimeHelper.getCurrentTime());
				sysCompanyInfo.setUpdateTime(TimeHelper.getCurrentTime());
				SysCompanyInfo newCompany = sysCompanyInfoService.saveCompany(sysCompanyInfo);
/*				SysDepartment sysDepartment = new SysDepartment();
				sysDepartment.setCompanyId(newCompany.getCompanyId());
				sysDepartment.setDeptName(newCompany.getName());
				sysDepartment.setParentDeptCode("0");
				sysDepartment.setDeptCode("001");
				sysDepartment.setDeptSeq(1);
				sysDepartment.setCreateTime(TimeHelper.getCurrentTime());
				sysDepartment.setUpdateTime(TimeHelper.getCurrentTime());
				sysDepartment.setState("1");
				departmentService.save(sysDepartment);*/
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
	 * 删除公司
	 * @param user
	 * @return
	 */
	@RequestMapping("delCompany")
	@ResponseBody
	public ResultEntity delUser(String ID){
		ResultEntity res = new ResultEntity();
		SysCompanyInfo sysCompanyInfo = null;
		String msg = "";
		try {
			String[] ids = ID.split(",");
			for (int i = 0; i < ids.length; i++) {
				sysCompanyInfo = sysCompanyInfoService.findOne(ID);
				if(sysCompanyInfo != null){
					sysCompanyInfoService.deleteCompany(ids[i]);
					res.setMessage(DELETE_SUCCESS);
					res.setSuccess(SUCCESS);
				}else{
					res.setMessage(DELETE_ERROR);
					res.setSuccess(ERROR);
				}
			}
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
	 * @param menu
	 * @return
	 */
	@RequestMapping("findCompany")
	@ResponseBody
	public ResultEntity findMenu(String ID){
		ResultEntity res = new ResultEntity();
		try {
			res.setData(sysCompanyInfoService.findOne(ID));
			res.setMessage(GET_SUCCESS);
			res.setSuccess(SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			res.setMessage(GET_ERROR + ":" + e.getMessage());
			res.setSuccess(ERROR);
		}
		return res;
	}
	
	
	@RequiresPermissions("company:editCompany")
	@ResponseBody
	@RequestMapping(value="editCompany")
	public ModelAndView editCompany(HttpServletRequest request){
		try {
			String compamyId="40289ff7659fa52301659fa5d8440000";
			SysCompanyInfo company = sysCompanyInfoService.findOne(compamyId);
			request.setAttribute("company", company);
		} catch (Exception e) {
			// TODO: handle exception
		}
		return new ModelAndView("/manage/sys/sys_companyList");

	}
	

}
