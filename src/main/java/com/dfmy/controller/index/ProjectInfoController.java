package com.dfmy.controller.index;

import com.dfmy.service.project.AtiProjectService;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dfmy.controller.common.BaseController;
import com.dfmy.entity.ResultEntity;
import com.dfmy.entity.index.AtiProjectInfo;
import com.dfmy.entity.project.AtiProject;
import com.dfmy.entity.sys.SysUser;
import com.dfmy.service.index.AtiProjectInfoService;
import com.dfmy.service.index.AtiProjectInfoService;
import com.dfmy.service.sys.SysUserService;
import com.dfmy.util.TimeHelper;

@Controller
@RequestMapping("/projectInfoo")
public class ProjectInfoController extends BaseController{
	
	@Autowired
	private AtiProjectInfoService atiProjectInfoService;
	@Autowired
	private AtiProjectService projectInfoService;
	@Autowired
	private SysUserService sysUserService;
	
	/**
	 * 获取项目工程信息
	 * @param projectId
	 * @return
	 */
	@RequestMapping("/getDataPage")
	@ResponseBody
	public ResultEntity getData (String projectId) {
		ResultEntity res = new ResultEntity();
		try {
			AtiProject project = projectInfoService.findProjectById(projectId);
			res.setSuccess(SUCCESS);
			res.setMessage(GET_SUCCESS);
			res.setData(project);
		} catch (Exception e) {
			res.setSuccess(ERROR);
			res.setMessage(GET_ERROR);
			e.printStackTrace();
		}
		return res;
	}
	
	/**
	 * 
	 * @param projectId
	 * @return
	 */
	@RequestMapping("/saveDataPage")
	@ResponseBody
	public ResultEntity saveDataPage (String projectId,String objKeys,String objValues) {
		ResultEntity res = new ResultEntity();
		try {
			Subject currentUser = SecurityUtils.getSubject();
			String userName = (String)currentUser.getPrincipal();
			SysUser sysUser = sysUserService.findByUserName(userName);
			AtiProject project = projectInfoService.findProjectById(projectId);
			if (StringUtils.isNotBlank(projectId)) {
				atiProjectInfoService.deleteByProject(project);
				if (StringUtils.isNotBlank(objKeys)) {
					String[] objKeyArr = objKeys.split(",");
					String[] objValueArr = objValues.split(",");
					for (int i=0;i<objKeyArr.length;i++) {
						AtiProjectInfo projectInfo = new AtiProjectInfo();
						projectInfo.setAtiProject(project);
						projectInfo.setObjKey(objKeyArr[i]);
						projectInfo.setObjValue(objValueArr[i]);
						projectInfo.setCreateTime(TimeHelper.getCurrentTime());
						projectInfo.setCreateUser(sysUser.getRolename());
						projectInfo.setState("1");
						atiProjectInfoService.save(projectInfo);
					}
				}
			}
			res.setSuccess(SUCCESS);
			res.setMessage(GET_SUCCESS);
			res.setData(project);
		} catch (Exception e) {
			res.setSuccess(ERROR);
			res.setMessage(GET_ERROR);
			e.printStackTrace();
		}
		return res;
	}

}
