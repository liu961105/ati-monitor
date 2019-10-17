package com.dfmy.controller.common;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.dfmy.entity.ResultEntity;
import com.dfmy.service.core.common.ObjectService;
import com.dfmy.service.core.jdbc.JdbcUtil;
import com.dfmy.tool.http.HttpHelper;
import com.dfmy.util.Page;
import com.dfmy.util.PageUtils;
import com.dfmy.util.PageVo;

/**
 * 通用增删改查Controller
 */
@Controller
@RequestMapping(value = "com")
public class CrudController extends BaseController {
	@Autowired
	public	ObjectService  objectService;
	@Autowired 
	private JdbcUtil jdbcUtil;
	// 查询数据
	@RequestMapping(value = "query", method = RequestMethod.POST)
	@ResponseBody
	public ResultEntity query( HttpServletRequest request, HttpServletResponse response,String sid,String ID) {
		ResultEntity result = new ResultEntity();
		Map map = null;
		try {
			map=	objectService.queryObject(sid,ID) ;
			result.setData(map);
			result.setSuccess(SUCCESS);
			result.setMessage(GET_SUCCESS);
		} catch (Exception e) {
			result.setSuccess(ERROR);
			result.setMessage(GET_ERROR);
			e.printStackTrace();
		}
		return result;
	}
		// 查询数据
		@RequestMapping(value = "queryList", method = RequestMethod.POST)
		@ResponseBody
		public ResultEntity queryList( HttpServletRequest request, HttpServletResponse response) {
			ResultEntity result = new ResultEntity();
			List<Map<String, Object>> list = null;
			try {
				list=objectService.queryList(request.getParameter("sid"), HttpHelper.getRequestParams(request)) ;
				if(list.size()>0){
					result.setData(list);
					result.setSuccess(SUCCESS);
					result.setMessage(GET_SUCCESS);
				}else{
					result.setData(list);
					result.setSuccess(NULL);
					result.setMessage("没有查到相关数据");
				}
				
			} catch (Exception e) {
				result.setData(0);
				result.setSuccess(ERROR);
				result.setMessage(GET_ERROR+":"+e.getMessage());
				e.printStackTrace();
			}
			return result;
		}
	// 增加数据
	@RequestMapping(value = "add", method = RequestMethod.POST)
	@ResponseBody
	public ResultEntity add(HttpServletRequest request,
			HttpServletResponse response) {
		ResultEntity result = new ResultEntity();
		try {
			String sid = request.getParameter("sid");
			/*==========这种处理很恶心，但是目前先暂时这样处理=======*/
			Map<String, Object> requestParams = HttpHelper.getRequestParams(request);
			/*处理系统维护系统主表的SID字段的冲突问题*/
			if(StringUtils.isNotBlank(request.getParameter("ssid"))){
				String ssid = request.getParameter("ssid");
				requestParams.put("sid", ssid);
			}
			/*==========end============*/
			objectService.saveObject(sid, requestParams);
			result.setData(null);
			result.setSuccess(SUCCESS);
			result.setMessage(OPERATE_SUCCESS);
		} catch (Exception e) {
			result.setSuccess(ERROR);
			result.setMessage(OPERATE_ERROR+":"+e.getMessage());
			e.printStackTrace();
			
		}

		return result;
	}

	// 更新数据
	@RequestMapping(value = "update", method = RequestMethod.POST)
	@ResponseBody
	public ResultEntity edit(HttpServletRequest request,
			HttpServletResponse response) {
		ResultEntity result = new ResultEntity();
		try {
			objectService.updateObject(request.getParameter("sid"), HttpHelper.getRequestParams(request));
			result.setData(null);
			result.setSuccess(SUCCESS);
			result.setMessage(OPERATE_SUCCESS);
		} catch (Exception e) {
			result.setSuccess(ERROR);
			result.setMessage(OPERATE_ERROR+":"+e.getMessage());
			e.printStackTrace();
		}
		return result;
	}

	// 删除数据
	@RequestMapping(value = "delete", method = RequestMethod.POST)
	@ResponseBody
	public ResultEntity delete(HttpServletRequest request,
			HttpServletResponse response) {
		ResultEntity result = new ResultEntity();
		try {
			objectService.deleteObject(request.getParameter("sid"), HttpHelper.getRequestParams(request));
			result.setSuccess(SUCCESS);
			result.setMessage(DELETE_SUCCESS);
		} catch (Exception e) {
			result.setSuccess(ERROR);
			result.setMessage(DELETE_ERROR+":"+e.getMessage());
		}

		return result;
	}
	//删除数据
		@RequestMapping(value = "deleteAll", method = RequestMethod.POST)
		@ResponseBody
		public ResultEntity deleteAll(HttpServletRequest request,
				HttpServletResponse response) {
			ResultEntity result = new ResultEntity();
			try {
				boolean isDelete = objectService.deleteAllObject(request.getParameter("sid"), HttpHelper.getRequestParams(request));
				result.setData(isDelete);
				result.setSuccess(SUCCESS);
				result.setMessage(DELETE_SUCCESS);
			} catch (Exception e) {
				result.setSuccess(ERROR);
				result.setMessage(DELETE_ERROR+":"+e.getMessage());
			}
			return result;
		}
	
		//验证连接
	@RequestMapping(value = "verifyJDBC", method = RequestMethod.POST)
	@ResponseBody
	public ResultEntity verifyJDBC(HttpServletRequest request,
			HttpServletResponse response){
		ResultEntity result = new ResultEntity();
		try {
			int re = jdbcUtil.isConnection(HttpHelper.getRequestParams(request));
			result.setData(re);
			result.setSuccess(SUCCESS);
			result.setMessage(OPERATE_SUCCESS);
		} catch (Exception e) {
			result.setData(0);
			result.setSuccess(ERROR);
			result.setMessage(OPERATE_ERROR+":"+e.getMessage());
		}
		return result;
	}
	
	//判断编号是否存在
	@RequestMapping(value = "isId", method = RequestMethod.POST)
	@ResponseBody
	public ResultEntity isId(HttpServletRequest request,
			HttpServletResponse response){
		ResultEntity result = new ResultEntity();
		try {
			int data = objectService.selectId(HttpHelper.getRequestParams(request));
			result.setData(data);
			result.setSuccess(SUCCESS);
			result.setMessage(OPERATE_SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			result.setSuccess(ERROR);
			result.setMessage(OPERATE_ERROR+"e.getMessage()");
		}
		return result;
	}
	
	@RequestMapping("pageList")
	@ResponseBody
	public ResultEntity getSysUserList(@RequestParam(value = "pageCurrent", defaultValue = "1") int pageCurrent,
			@RequestParam(value = "order.field", defaultValue = "") String orderField,
			@RequestParam(value = "order.sort", defaultValue = "") String orderSort,
			@RequestParam(value = "findNowPage", defaultValue = "false") String findNowPage,
			String sid,
			HttpServletRequest request, HttpServletResponse response){
		ResultEntity result = new ResultEntity();
		try {
			PageUtils pageUtils = new PageUtils(pageCurrent,PAGESIZE, orderField, orderSort);
			Page<List<Map<String, Object>>> list = objectService.queryPageList(sid, HttpHelper.getRequestParams(request), pageUtils);
			List<Map<String,Object>> dataList = (List<Map<String, Object>>) list.getData();
			PageVo page = new PageVo(list.getCurrentPageNo()-1, dataList, PAGESIZE, list.getTotalPageCount(), list.getTotalCount());
			if(dataList !=null && dataList.size()>0){
				result.setData(page);
				result.setSuccess(SUCCESS);
				result.setMessage(GET_SUCCESS);
			}else{
				result.setData(list);
				result.setSuccess(NULL);
				result.setMessage(GET_SUCCESS);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			result.setSuccess(ERROR);
			result.setMessage(GET_ERROR+e.getMessage());
		}
		return result;
	}
	
	/**
	 * 查重
	 */
	@RequestMapping("onlyRow")
	@ResponseBody
	public ResultEntity onlyRow(String sid,String dataVal,String uniqField){
		ResultEntity result = new ResultEntity();
		try {
			Map<String, Object> queryObject = objectService.queryObject(sid, dataVal, uniqField);
			if(queryObject.size()>0){
				result.setSuccess(ERROR);
				result.setMessage("此数据已存在，不能重复添加");
			}
		} catch (Exception e) {
			e.printStackTrace();
			result.setSuccess(ERROR);
			result.setMessage(GET_ERROR+e.getMessage());
		}
		return result;
	}
}
