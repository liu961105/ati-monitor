package com.dfmy.controller.sys;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dfmy.controller.common.BaseController;
import com.dfmy.entity.ResultEntity;
import com.dfmy.entity.sys.SysLog;
import com.dfmy.service.sys.SysLogService;

@Controller
@RequestMapping("sysLog")
public class SysLogController extends BaseController{
	
	@Autowired
	private SysLogService sysLogService;
	
	/**
	 * 分页日志列表
	 * @return
	 */
	@RequestMapping("pageList")
	@RequiresPermissions("sysLog:pageList")
	@ResponseBody
	private ResultEntity pageList(@RequestParam(value = "pageCurrent", defaultValue = "1") String pageCurrent,SysLog log) {
		ResultEntity res = new ResultEntity();
		try {
			Page<SysLog> paramPage = sysLogService.pageList(Integer.parseInt(pageCurrent), PAGESIZE, "createtime",log);
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
