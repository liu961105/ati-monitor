package com.dfmy.controller.security;


import java.math.BigInteger;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.subject.Subject;
import org.hibernate.criterion.Projection;
import org.springframework.data.domain.Page;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import com.dfmy.controller.common.BaseController;
import com.dfmy.entity.ResultEntity;
import com.dfmy.entity.basedata.AtiMonitorType;
import com.dfmy.entity.device.AtiDeviceDataRecordHistory;
import com.dfmy.entity.project.AtiProject;
import com.dfmy.entity.sys.SysUser;
import com.dfmy.service.basedata.AtiMonitorTypeService;
import com.dfmy.service.device.AtiDeviceDataRecordHistoryService;
import com.dfmy.service.project.AtiProjectService;
import com.dfmy.service.sys.SysUserService;

/**
 * 安全预警Controller
 * cyx
 * */
@RestController
@RequestMapping("/security")
public class SecurityController  extends BaseController{
	
	@Resource
	private AtiDeviceDataRecordHistoryService atiDeviceDataRecordHistoryService;
	@Resource
	private AtiMonitorTypeService atiMonitorTypeService;
	@Resource
	private SysUserService sysUserService;
	
	@Resource
	private AtiProjectService atiProjectService;
	
	@RequiresPermissions("securityWarning:pageList")
	@RequestMapping("/getSecurityPage")
	@ResponseBody
	public ResultEntity getSecurityPage(@RequestParam(value = "pageCurrent", defaultValue = "1") String pageCurrent, AtiDeviceDataRecordHistory atiDeviceDataRecordHistory
			,@RequestParam(value = "sortOrder", defaultValue = "uploadTime") String sortOrder){
		ResultEntity res = new ResultEntity();		
		try{   			   			  
			   Page<AtiDeviceDataRecordHistory> pageInfo = atiDeviceDataRecordHistoryService.pageList(Integer.parseInt(pageCurrent), PAGESIZE, sortOrder, atiDeviceDataRecordHistory);
			 
			   if (pageInfo.getTotalPages() > 0) {
	                res.setData(pageInfo);
	                res.setMessage(GET_SUCCESS);
	                res.setSuccess(SUCCESS);
	            } else {
	                res.setMessage(IS_NULL);
	                res.setSuccess(NULL);
	            }
		}catch (Exception e) {
			e.printStackTrace();		
			res.setSuccess(ERROR);
			}
		return res;
	}
	@RequestMapping("/getMonitorType")
	@ResponseBody
	public ResultEntity getMonitorType(HttpServletRequest request,HttpServletResponse response){
		ResultEntity res = new ResultEntity();		
		try{   
		 String structureId =request.getParameter("structureId");
		 if(StringUtils.isNotEmpty(structureId)){
			 
			List<AtiMonitorType> list =atiMonitorTypeService.findByStructId(structureId);
			res.setData(list);
			res.setSuccess(SUCCESS);
		 }else{
			 res.setSuccess(ERROR);
		 }
	            
		}catch (Exception e) {
			e.printStackTrace();		
			res.setSuccess(ERROR);
			}
		return res;
	}
	
	@RequestMapping("/getStatisticsData")
	@ResponseBody
	public ResultEntity getStatisticsData(HttpServletRequest request,HttpServletResponse response){
		Map<String,Object> dataMap = new HashMap<String, Object>();
		ResultEntity res = new ResultEntity();		
		try{
			String projectId =request.getParameter("projectId");
			if (StringUtils.isNotEmpty(projectId)) {	
				dataMap.put("level1", atiDeviceDataRecordHistoryService.findByDealStatusAndWarnLevel("0", 1).size());
				dataMap.put("level2", atiDeviceDataRecordHistoryService.findByDealStatusAndWarnLevel("0", 2).size());
				dataMap.put("level3", atiDeviceDataRecordHistoryService.findByDealStatusAndWarnLevel("0", 3).size());
				res.setData(dataMap);
				res.setSuccess(SUCCESS);
			}else{
				res.setSuccess(ERROR);
			}
			
		}catch (Exception e) {
			e.printStackTrace();		
			res.setSuccess(ERROR);
			}
		return res;
	}
	
	@RequestMapping("/commitDealText")
	@ResponseBody
	public ResultEntity commitDealText(HttpServletRequest request,HttpServletResponse response){
		ResultEntity res = new ResultEntity();		
		try{
			String text =request.getParameter("text");
			String id =request.getParameter("id");
			if (StringUtils.isNotEmpty(text) && StringUtils.isNotEmpty(id)) {	
				AtiDeviceDataRecordHistory atiDeviceDataRecordHistory =atiDeviceDataRecordHistoryService.findById(id);
				atiDeviceDataRecordHistory.setDealMessage(text);
				SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");//设置日期格式
				atiDeviceDataRecordHistory.setDealTime(df.format(new Date()));
				atiDeviceDataRecordHistory.setDealStatus("1");
				SysUser sysUser = sysUserService.findByUserName(SecurityUtils.getSubject().getPrincipal().toString());			
				atiDeviceDataRecordHistory.setDealUser(sysUser.getRolename());
				atiDeviceDataRecordHistoryService.save(atiDeviceDataRecordHistory);
				BigInteger number = atiDeviceDataRecordHistoryService.findByProjectIdAndDealStatusCountAndRunningState(atiDeviceDataRecordHistory.getProjectId(), "0", "2");
				AtiProject atiProject  = atiProjectService.findProjectById(atiDeviceDataRecordHistory.getProjectId());
			    atiProject.setWarnCount(number.intValue());
				if(atiProject.getDealCount() == null){
					atiProject.setDealCount(0);
				}
				atiProject.setDealCount(atiProject.getDealCount()+1);
			    atiProjectService.save(atiProject); 	
				
				res.setSuccess(SUCCESS);
			}else{
				res.setSuccess(ERROR);
			}
			
		}catch (Exception e) {
			e.printStackTrace();		
			res.setSuccess(ERROR);
			}
		return res;
	}


}
