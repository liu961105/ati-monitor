package com.dfmy.controller.basedata;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.dfmy.controller.common.BaseController;
import com.dfmy.entity.ResultEntity;
import com.dfmy.entity.basedata.AtiFileType;
import com.dfmy.entity.basedata.AtiProjectStructure;
import com.dfmy.service.basedata.AtiFileTypeService;

import com.dfmy.service.basedata.AtiProjectStructureService;
import com.dfmy.service.basedata.FileManageService;
import com.dfmy.util.TimeHelper;

@Controller
@RequestMapping("/fileType")
public class FileTypeController extends BaseController{
	
	@Autowired
	private AtiProjectStructureService atiProjectStructureService;
	@Autowired
	private AtiFileTypeService atiFileTypeService;
	
	@Autowired
	private FileManageService fileManageService;
	
	/**
	 * 结构类型列表
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
	 * 类型分页
	 * @param pageCurrent
	 * @param name
	 * @return
	 */
	@RequiresPermissions("sysPhotoMng:pageList")
	@RequestMapping("pageList")
	@ResponseBody
	private ResultEntity pageList(@RequestParam(value = "pageCurrent", defaultValue = "1") String pageCurrent,String code,String strucId,String projectId) {
		ResultEntity res = new ResultEntity();
		try {
			Page<AtiFileType> page = atiFileTypeService.pageList(Integer.parseInt(pageCurrent), PAGESIZE, "createTime",code,strucId,projectId);
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
	 * 类型保存
	 * @param AtiPhotoType
	 * @return
	 */
	@RequestMapping("save")
	@ResponseBody
	public ResultEntity save(AtiFileType atiFileType,String projectId ){
		ResultEntity res = new ResultEntity();
		Subject currentUser = SecurityUtils.getSubject();
		try {
			if(StringUtils.isNotBlank(atiFileType.getId())){
				atiFileType.setUpdateTime(TimeHelper.getCurrentTime());
				atiFileType.setUpdateUser((String)currentUser.getPrincipal());
				atiFileType.setProjectId(projectId);
			}else{
				atiFileType.setCreateTime(TimeHelper.getCurrentTime());
				atiFileType.setCreateUser((String)currentUser.getPrincipal());
			}
			atiFileTypeService.save(atiFileType);
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
					atiFileTypeService.delete(ids);
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
	 * 
	 * @param ID
	 * @return
	 */
	@RequestMapping("findById")
	@ResponseBody
	public ResultEntity findById(String ID){
		ResultEntity res = new ResultEntity();
		try {
			res.setData(atiFileTypeService.findById(ID));
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
			List<AtiFileType> typeList = atiFileTypeService.findByStructId(structId);
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
	
	@RequestMapping("/sonPageMain")
	public String sonPageMain(Model model,String id){
		AtiFileType atiFileType = atiFileTypeService.findById(id);
		model.addAttribute("id", id);
		model.addAttribute("pname",atiFileType.getTypeName());
		return "/manage/basedata/file_list";
	}

}
