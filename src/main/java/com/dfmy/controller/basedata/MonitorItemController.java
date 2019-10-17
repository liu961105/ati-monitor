package com.dfmy.controller.basedata;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.dfmy.entity.basedata.AtiMonitorItem;
import com.dfmy.entity.basedata.AtiMonitorType;
import com.dfmy.entity.basedata.AtiProjectStructure;
import com.dfmy.service.basedata.AtiMonitorItemService;
import com.dfmy.service.basedata.AtiMonitorTypeService;
import com.dfmy.service.basedata.AtiProjectStructureService;
import com.dfmy.util.TimeHelper;

@Controller
@RequestMapping("/monitorItem")
public class MonitorItemController extends BaseController{

	@Autowired
	private AtiMonitorItemService atiMonitorItemService;
	@Autowired
	private AtiMonitorTypeService atiMonitorTypeService;
	@Autowired
	private AtiProjectStructureService atiProjectStructureService;
	
	/**
	 * 监测项分页
	 * @param pageCurrent
	 * @param name
	 * @return
	 */
	@RequiresPermissions("monitorItem:pageList")
	@RequestMapping("pageList")
	@ResponseBody
	private ResultEntity pageList(@RequestParam(value = "pageCurrent", defaultValue = "1") String pageCurrent,String name,String strucId,String typeId) {
		ResultEntity res = new ResultEntity();
		try {
			Page<AtiMonitorItem> page = atiMonitorItemService.pageList(Integer.parseInt(pageCurrent), PAGESIZE, "createTime",name,strucId,typeId);
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
	 * 监测项保存
	 * @param AtiMonitorItem
	 * @return
	 */
	@RequestMapping("save")
	@ResponseBody
	public ResultEntity save(AtiMonitorItem atiMonitorType){
		
		ResultEntity res = new ResultEntity();
		Subject currentUser = SecurityUtils.getSubject();
		try {
			if(StringUtils.isNotBlank(atiMonitorType.getId())){
				atiMonitorType.setUpdateTime(TimeHelper.getCurrentTime());
				atiMonitorType.setUpdateUser((String)currentUser.getPrincipal());
			}else{
				atiMonitorType.setCreateTime(TimeHelper.getCurrentTime());
				atiMonitorType.setCreateUser((String)currentUser.getPrincipal());
			}
			atiMonitorItemService.save(atiMonitorType);
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
	 * 监测项删除
	 * @param ID
	 * @return
	 */
	@RequestMapping("delete")
	@ResponseBody
	public ResultEntity delete(String ID){
		ResultEntity res = new ResultEntity();
		try {
			if(StringUtils.isNotBlank(ID)) {
				String [] idArr = ID.split(",");
				for(String ids : idArr) {
					atiMonitorItemService.delete(ids);
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
	 * 查询监测项
	 * @param ID
	 * @return
	 */
	@RequestMapping("findById")
	@ResponseBody
	public ResultEntity findById(String ID){
		ResultEntity res = new ResultEntity();
		try {
			res.setData(atiMonitorItemService.findById(ID));
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
	 * 获取结构类型列表
	 * @return
	 */
	@RequestMapping("/getStructAndType")
	@ResponseBody
	public ResultEntity getStructAndType () {
		ResultEntity res = new ResultEntity();
		try {
			Map<String, Object> resMap = new HashMap<String, Object>();
			List<AtiProjectStructure> strucList = atiProjectStructureService.findByState("1");
			List<AtiMonitorType> typeList = atiMonitorTypeService.findByState("1");
			
			resMap.put("strucList", strucList);
			resMap.put("typeList", typeList);
			
			res.setData(resMap);
			res.setMessage(GET_SUCCESS);
			res.setSuccess(SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			res.setMessage(GET_ERROR + ":" + e.getMessage());
			res.setSuccess(ERROR);
		}
		return res;
	}
	
	@RequestMapping("/getItemsByStructIdTypeId")
	@ResponseBody
	public ResultEntity getItemsByStructIdTypeId (String structId,String typeId) {
		ResultEntity res = new ResultEntity();
		try {
			Map<String, Object> resMap = new HashMap<String, Object>();
			List<AtiMonitorType> typeList = atiMonitorTypeService.findByStructId(structId);
			List<AtiMonitorItem> itemList = atiMonitorItemService.findByTypeId(typeId);
			
			resMap.put("typeList", typeList);
			resMap.put("itemList", itemList);
			
			res.setData(resMap);
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
	 * 根据监测类型获取监测项列表
	 * @param monitorTypeId
	 * @return
	 */
	@RequestMapping("/getItemListByType")
	@ResponseBody
	public ResultEntity getItemListByType (String monitorTypeId) {
		ResultEntity res = new ResultEntity();
		try {
			List<AtiMonitorItem> itemList = atiMonitorItemService.findByTypeId(monitorTypeId);
			res.setData(itemList);
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
