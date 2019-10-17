package com.dfmy.controller.basedata;

import java.util.List;
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

import com.dfmy.entity.basedata.EmailService;

import com.dfmy.service.basedata.EmailServiceService;
import com.dfmy.util.TimeHelper;


@Controller
@RequestMapping("/emailService")
public class EmailServiceController extends BaseController{
	@Autowired
	private EmailServiceService emailServiceService;
	
	/**
	 * 邮件分页
	 * @param pageCurrent
	 * @param name
	 * @return
	 */
	@RequiresPermissions("emailService:pageList")
	@RequestMapping("pageList")
	@ResponseBody
	private ResultEntity pageList(@RequestParam(value = "pageCurrent", defaultValue = "1") String pageCurrent,String serviceNum) {
		ResultEntity res = new ResultEntity();
		try {
			Page<EmailService> page = emailServiceService.pageList(Integer.parseInt(pageCurrent), PAGESIZE, "createTime",serviceNum);
			if (page.getTotalPages() > 0) {
				res.setData(page);
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
	 * 邮件保存
	 * 
	 */
	@RequestMapping("save")
	@ResponseBody
	public ResultEntity save(EmailService emailService){
		
		ResultEntity res = new ResultEntity();
		try {
			if(StringUtils.isNotBlank(emailService.getId())){
				emailService.setUpdateTime(TimeHelper.getCurrentTime());
			}else{
				emailService.setCreateTime(TimeHelper.getCurrentTime());
			}
			emailServiceService.save(emailService);
			res.setMessage("保存成功");
			res.setSuccess(SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			res.setMessage("OPERATE_ERROR" + ":" + e.getMessage());
			res.setSuccess(ERROR);
		}
		return res;
	}
	/**
	 * 邮件服务删除
	 */
	@RequestMapping("delete")
	@ResponseBody
	public ResultEntity delete(String ID){
		ResultEntity res = new ResultEntity();
		try {
			if(StringUtils.isNotBlank(ID)) {
				String [] idArr = ID.split(",");
				for(String ids : idArr) {
					emailServiceService.delete(ids);
				}
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
	 * 邮件服务单个查询
	 */
	@RequestMapping("findById")
	@ResponseBody
	public ResultEntity findById(String ID){
		ResultEntity res = new ResultEntity();
		try {
			res.setData(emailServiceService.findById(ID));
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
