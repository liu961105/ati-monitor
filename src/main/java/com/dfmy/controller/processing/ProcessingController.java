package com.dfmy.controller.processing;


import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.dfmy.controller.common.BaseController;
import com.dfmy.entity.ResultEntity;
import com.dfmy.entity.basedata.AtiMonitorItem;
import com.dfmy.entity.basedata.AtiMonitorParam;
import com.dfmy.entity.basedata.AtiMonitorType;
import com.dfmy.entity.device.AtiMonitorParamDevice;
import com.dfmy.entity.device.AtiProjectMonitorSites;
import com.dfmy.service.basedata.AtiMonitorItemService;
import com.dfmy.service.basedata.AtiMonitorParamService;
import com.dfmy.service.basedata.AtiMonitorTypeService;
import com.dfmy.service.device.AtiProjectMonitorSitesService;
/**
 * 数据处理Controller
 * cyx
 * 
 **/
@RestController
@RequestMapping("/processing")
public class ProcessingController extends BaseController{
	@Resource
	private AtiMonitorTypeService atiMonitorTypeService;
	@Resource
	private AtiMonitorItemService atiMonitorItemService;
	@Resource
	private AtiMonitorParamService atiMonitorParamService;
	@Resource
	private AtiProjectMonitorSitesService atiProjectMonitorSitesService;
	
	
	@RequiresPermissions("dataProcessing:dataList")
	@RequestMapping("/getMonitorData")
	@ResponseBody
	public ResultEntity getMonitorData(HttpServletRequest request,HttpServletResponse response){
		ResultEntity res = new ResultEntity();		
		try{
			String structureId =request.getParameter("structureId");
			if(StringUtils.isNotEmpty(structureId)){
			 List<AtiMonitorType> atiMonitorTypes =	atiMonitorTypeService.findByStructId(structureId);
			 res.setData(atiMonitorTypes);
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
	@RequestMapping("/getMonitorItem")
	@ResponseBody
	public ResultEntity getMonitorItem(HttpServletRequest request,HttpServletResponse response){
		ResultEntity res = new ResultEntity();		
		try{
			String typeId =request.getParameter("typeId");
			if(StringUtils.isNotEmpty(typeId)){
			  List<AtiMonitorItem> monitorItems = atiMonitorItemService.findByTypeId(typeId);	
			 res.setData(monitorItems);
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
	@RequestMapping("/getParam")
	@ResponseBody
	public ResultEntity getParam(HttpServletRequest request,HttpServletResponse response){
		ResultEntity res = new ResultEntity();		
		try{
			String itemId =request.getParameter("itemId");
			if(StringUtils.isNotEmpty(itemId)){
			 List<AtiMonitorParam> monitorItems = atiMonitorParamService.findByItemId(itemId);
			 res.setData(monitorItems);
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
	@RequestMapping("/getSpoy")
	@ResponseBody
	public ResultEntity getSpoy(HttpServletRequest request,HttpServletResponse response){
		ResultEntity res = new ResultEntity();		
		try{
			String paramId =request.getParameter("paramId");
			String projectId = request.getParameter("projectId");
			if(StringUtils.isNotEmpty(paramId)){
				List<AtiProjectMonitorSites> atiProjectMonitorSites =atiProjectMonitorSitesService.findByMonitorParamIdAndProjectId(paramId,projectId);
			 res.setData(atiProjectMonitorSites);
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
