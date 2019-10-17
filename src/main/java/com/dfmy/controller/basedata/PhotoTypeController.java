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
import com.dfmy.entity.basedata.AtiPhotoType;
import com.dfmy.entity.basedata.AtiProjectStructure;
import com.dfmy.service.basedata.AtiPhotoTypeService;
import com.dfmy.service.basedata.AtiProjectStructureService;
import com.dfmy.util.TimeHelper;

@Controller
@RequestMapping("/photoType")
public class PhotoTypeController extends BaseController{
	
	@Autowired
	private AtiProjectStructureService atiProjectStructureService;
	@Autowired
	private AtiPhotoTypeService atiPhotoTypeService;
	
	/**
	 * 获取结构类型列表
	 * @return
	 */
	@RequestMapping("/getStrucList")
	@ResponseBody
	public ResultEntity getStrucList () {
		ResultEntity res = new ResultEntity();
		try {
			List<AtiProjectStructure> strucList = atiProjectStructureService.findByState("1");
			res.setData(strucList);
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
	 * 相册类型分页
	 * @param pageCurrent
	 * @param name
	 * @return
	 */
	@RequiresPermissions("sysPhotoMng:pageList")
	@RequestMapping("pageList")
	@ResponseBody
	private ResultEntity pageList(@RequestParam(value = "pageCurrent", defaultValue = "1") String pageCurrent,String name,String strucId) {
		ResultEntity res = new ResultEntity();
		try {
			Page<AtiPhotoType> page = atiPhotoTypeService.pageList(Integer.parseInt(pageCurrent), PAGESIZE, "createTime",name,strucId);
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
	 * 相册类型保存
	 * @param AtiPhotoType
	 * @return
	 */
	@RequestMapping("save")
	@ResponseBody
	public ResultEntity save(AtiPhotoType atiPhotoType){
		
		ResultEntity res = new ResultEntity();
		Subject currentUser = SecurityUtils.getSubject();
		try {
			if(StringUtils.isNotBlank(atiPhotoType.getId())){
				atiPhotoType.setUpdateTime(TimeHelper.getCurrentTime());
				atiPhotoType.setUpdateUser((String)currentUser.getPrincipal());
			}else{
				atiPhotoType.setCreateTime(TimeHelper.getCurrentTime());
				atiPhotoType.setCreateUser((String)currentUser.getPrincipal());
			}
			atiPhotoType.setCover("/ati-monitor/res/img/gcxcgl/zwzp.png");
			atiPhotoTypeService.save(atiPhotoType);
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
	 * 相册类型删除
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
					atiPhotoTypeService.delete(ids);
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
	 * 查询相册类型
	 * @param ID
	 * @return
	 */
	@RequestMapping("findById")
	@ResponseBody
	public ResultEntity findById(String ID){
		ResultEntity res = new ResultEntity();
		try {
			res.setData(atiPhotoTypeService.findById(ID));
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
	 * 根据结构类型主键获取监测类型列表
	 * @param structId
	 * @return
	 */
	@RequestMapping("/getTypeList")
	@ResponseBody
	public ResultEntity getTypeList (String structId) {
		ResultEntity res = new ResultEntity();
		try {
			List<AtiPhotoType> typeList = atiPhotoTypeService.findByStructId(structId);
			res.setData(typeList);
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
