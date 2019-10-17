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
import com.dfmy.entity.basedata.AtiMonitorParam;
import com.dfmy.entity.basedata.AtiMonitorType;
import com.dfmy.entity.basedata.AtiProjectStructure;
import com.dfmy.service.basedata.AtiMonitorItemService;
import com.dfmy.service.basedata.AtiMonitorParamService;
import com.dfmy.service.basedata.AtiMonitorParamService;
import com.dfmy.service.basedata.AtiMonitorTypeService;
import com.dfmy.service.basedata.AtiProjectStructureService;
import com.dfmy.util.TimeHelper;

@Controller
@RequestMapping("/monitorParam")
public class MonitorParamController extends BaseController {

	@Autowired
	private AtiMonitorParamService atiMonitorParamService;
	@Autowired
	private AtiMonitorItemService atiMonitorItemService;
	@Autowired
	private AtiMonitorTypeService atiMonitorTypeService;
	@Autowired
	private AtiProjectStructureService atiProjectStructureService;

	/**
	 * 监测项分页
	 * 
	 * @param pageCurrent
	 * @param name
	 * @return
	 */
	@RequiresPermissions("monitorParam:pageList")
	@RequestMapping("pageList")
	@ResponseBody
	private ResultEntity pageList(@RequestParam(value = "pageCurrent", defaultValue = "1") String pageCurrent,
			String name, String typeId, String itemId) {
		ResultEntity res = new ResultEntity();
		try {
			Page<AtiMonitorParam> page = atiMonitorParamService.pageList(Integer.parseInt(pageCurrent), PAGESIZE,
					"createTime", name, typeId, itemId);
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
	 * 
	 * @param AtiMonitorParam
	 * @return
	 */
	@RequestMapping("save")
	@ResponseBody
	public ResultEntity save(AtiMonitorParam atiMonitorParam) {

		ResultEntity res = new ResultEntity();
		Subject currentUser = SecurityUtils.getSubject();
		try {
			if (StringUtils.isNotBlank(atiMonitorParam.getId())) {
				atiMonitorParam.setUpdateTime(TimeHelper.getCurrentTime());
				atiMonitorParam.setUpdateUser((String) currentUser.getPrincipal());
			} else {
				atiMonitorParam.setCreateTime(TimeHelper.getCurrentTime());
				atiMonitorParam.setCreateUser((String) currentUser.getPrincipal());
			}
			atiMonitorParamService.save(atiMonitorParam);
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
	 * 
	 * @param ID
	 * @return
	 */
	@RequestMapping("delete")
	@ResponseBody
	public ResultEntity delete(String ID) {
		ResultEntity res = new ResultEntity();
		try {
			if (StringUtils.isNotBlank(ID)) {
				String[] idArr = ID.split(",");
				for (String ids : idArr) {
					atiMonitorParamService.delete(ids);
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
	 * 
	 * @param ID
	 * @return
	 */
	@RequestMapping("findById")
	@ResponseBody
	public ResultEntity findById(String ID) {
		ResultEntity res = new ResultEntity();
		try {
			res.setData(atiMonitorParamService.findById(ID));
			res.setMessage(GET_SUCCESS);
			res.setSuccess(SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			res.setMessage(GET_ERROR + ":" + e.getMessage());
			res.setSuccess(ERROR);
		}
		return res;
	}

	@RequestMapping("/getTypeAndItem")
	@ResponseBody
	public ResultEntity getTypeAndItem(String structId) {
		ResultEntity res = new ResultEntity();
		try {
			Map<String, Object> resMap = new HashMap<String, Object>();
			List<AtiMonitorType> typeList = atiMonitorTypeService.findByStructId(structId);
			List<AtiMonitorItem> itemList = atiMonitorItemService.findByState("1");

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
	 * 根据
	 * @param monitorTypeId
	 * @return
	 */
	@RequestMapping("/getParamListByItem")
	@ResponseBody
	public ResultEntity getParamsListByItem (String monitorItemId) {
		ResultEntity res = new ResultEntity();
		try {
			List<AtiMonitorParam> itemList = atiMonitorParamService.findByItemId(monitorItemId);
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
