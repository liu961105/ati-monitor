package com.dfmy.controller.project;

import java.util.List;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dfmy.controller.common.BaseController;
import com.dfmy.entity.ResultEntity;
import com.dfmy.entity.project.AtiMonitorParamProject;
import com.dfmy.service.project.AtiMonitorParamProjectService;
import com.dfmy.service.sys.SysUserService;
import com.dfmy.util.TimeHelper;

@Controller
@RequestMapping("/projectConfigParam")
public class ProjectConfigParamController extends BaseController{

	@Autowired
	private AtiMonitorParamProjectService atiMonitorParamProjectService;
	@Autowired
	private SysUserService sysUserService;
	
	@RequestMapping("/getTree")
	@ResponseBody
	public ResultEntity getTree(String pid) {
		ResultEntity res = new ResultEntity();
		try {
			List<Map<String, Object>> list = atiMonitorParamProjectService.getTree(pid);
			if (list != null && list.size() > 0) {
				res.setData(list);
				res.setSuccess(SUCCESS);
				res.setMessage(GET_SUCCESS);
			} else {
				res.setSuccess(NULL);
				res.setMessage(IS_NULL);
			}
		} catch (Exception e) {
			res.setSuccess(ERROR);
			res.setMessage(GET_ERROR);
			e.printStackTrace();
		}
		return res;
	}
	
	@RequestMapping("/getConfigParam")
	@ResponseBody
	public ResultEntity getConfigParam (String projectId) {
		ResultEntity res = new ResultEntity();
		try {
			List<AtiMonitorParamProject> checkdParams = atiMonitorParamProjectService.findByProjectId(projectId);
			if (checkdParams != null && checkdParams.size() > 0) {
				res.setData(checkdParams);
				res.setSuccess(SUCCESS);
				res.setMessage(GET_SUCCESS);
			} else {
				res.setSuccess(NULL);
				res.setMessage(IS_NULL);
			}
		} catch (Exception e) {
			res.setSuccess(ERROR);
			res.setMessage(GET_ERROR);
			e.printStackTrace();
		}
		return res;
	}
	
	@RequestMapping("/saveMonitorParam")
	@ResponseBody
	public ResultEntity saveMonitorParam (String configProjectId,String paramIds) {
		ResultEntity res = new ResultEntity();
		Subject currentUser = SecurityUtils.getSubject();
		try {
			//初始化数据，删除在库里存在而未在树中选择的数据
			atiMonitorParamProjectService.deleteByProjectIdAndParamIds(configProjectId, paramIds);
			if (StringUtils.isNotBlank(paramIds)) {
				String[] paramIdArr = paramIds.split(",");
				for (String paramId : paramIdArr) {
					AtiMonitorParamProject configed = atiMonitorParamProjectService.findByProjectIdAndParamId(configProjectId, paramId);
					if (StringUtils.isBlank(configed.getId())) {
						configed.setProjectId(configProjectId);
						configed.setMonitorParamId(paramId);
						configed.setCreateTime(TimeHelper.getCurrentTime());
						configed.setCreateUser((String)currentUser.getPrincipal());
						configed.setState("1");
						atiMonitorParamProjectService.save(configed);
					}
				}
			}
			res.setSuccess(SUCCESS);
			res.setMessage(OPERATE_SUCCESS);
		} catch (Exception e) {
			res.setSuccess(ERROR);
			res.setMessage(OPERATE_SUCCESS);
			e.printStackTrace();
		}
		return res;
	}
	
}
