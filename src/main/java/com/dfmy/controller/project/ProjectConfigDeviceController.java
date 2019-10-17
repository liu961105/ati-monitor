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
import com.dfmy.entity.project.AtiMonitorProjectDevice;
import com.dfmy.service.project.AtiMonitorProjectDeviceService;
import com.dfmy.util.TimeHelper;

@Controller
@RequestMapping("/projectConfigDevice")
public class ProjectConfigDeviceController extends BaseController {

	@Autowired
	private AtiMonitorProjectDeviceService projectDeviceService;

	@RequestMapping("/getTree")
	@ResponseBody
	public ResultEntity getTree(String pid) {
		ResultEntity res = new ResultEntity();
		try {
			List<Map<String, Object>> list = projectDeviceService.getTree(pid);
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

	@RequestMapping("/getConfigDevice")
	@ResponseBody
	public ResultEntity getConfigParam(String projectId) {
		ResultEntity res = new ResultEntity();
		try {
			List<AtiMonitorProjectDevice> checkdDevices = projectDeviceService.findByProjectId(projectId);
			if (checkdDevices != null && checkdDevices.size() > 0) {
				res.setData(checkdDevices);
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

	@RequestMapping("/saveProjectDevice")
	@ResponseBody
	public ResultEntity saveProjectDevice(String configProjectId, String paramDeviceIds) {
		ResultEntity res = new ResultEntity();
		Subject currentUser = SecurityUtils.getSubject();
		try {
			// 初始化数据，删除在库里存在而未在树中选择的数据
			projectDeviceService.deleteByProjectIdAndParamDeviceIds(configProjectId, paramDeviceIds);
			if (StringUtils.isNotBlank(paramDeviceIds)) {
				String[] paramDeviceIdArr = paramDeviceIds.split(",");
				for (String paramDeviceId : paramDeviceIdArr) {
					AtiMonitorProjectDevice configed = projectDeviceService.findByProjectIdAndParamDeviceId(configProjectId, paramDeviceId);
					if (StringUtils.isBlank(configed.getId())) {
						configed.setProjectId(configProjectId);
						configed.setParamDeviceId(paramDeviceId);
						configed.setCreateTime(TimeHelper.getCurrentTime());
						configed.setCreateUser((String) currentUser.getPrincipal());
						configed.setState("1");
						projectDeviceService.save(configed);
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
