package com.dfmy.controller.job;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dfmy.controller.common.BaseController;
import com.dfmy.entity.ResultEntity;
import com.dfmy.service.job.JobService;

/**
 * 任务管理
 *
 */
@Controller
@RequestMapping("job")
public class JobController extends BaseController{
	@Resource
	private JobService  jobService;
	
	/**
	 * 启动调度
	 * @param param
	 */
	@RequestMapping("jobStart")
	@ResponseBody
	public ResultEntity jobStart(Model model,String param){
		ResultEntity result = new ResultEntity();
		try {
			int status = jobService.jobMag(param,"1");
			result.setData(status);
			result.setSuccess(SUCCESS);
			result.setMessage(GET_SUCCESS);
		} catch (Exception e) {
			result.setData(null);
			result.setSuccess(ERROR);
			result.setMessage(OPERATE_ERROR);
			e.printStackTrace();
		} 
		return result;
	}
	
	@RequestMapping("jobStop")
	@ResponseBody
	private ResultEntity jobStop(Model model,String param){
		ResultEntity result = new ResultEntity();
		try {
			int status = jobService.jobMag(param,"0");
			result.setData(status);
			result.setSuccess(SUCCESS);
			result.setMessage(GET_SUCCESS);
		} catch (Exception e) {
			result.setData(null);
			result.setSuccess(ERROR);
			result.setMessage(OPERATE_ERROR);
			e.printStackTrace();
		} 
		return result;
	}
	
	/**
	 * 
	 * @param model
	 * @param param
	 * @return
	 */
	@RequestMapping("deleteJob")
	@ResponseBody
	private ResultEntity deleteJob(Model model,String param){
		ResultEntity result = new ResultEntity();
		try {
			jobService.deleteJob(param);
			result.setData(null);
			result.setSuccess(SUCCESS);
			result.setMessage(DELETE_SUCCESS);
		} catch (Exception e) {
			result.setData(null);
			result.setSuccess(ERROR);
			result.setMessage(DELETE_ERROR);
			e.printStackTrace();
		} 
		return result;
	}
	
}
