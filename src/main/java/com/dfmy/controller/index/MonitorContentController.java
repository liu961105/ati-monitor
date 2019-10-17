package com.dfmy.controller.index;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.dfmy.controller.common.BaseController;
import com.dfmy.entity.ResultEntity;
import com.dfmy.entity.basedata.AtiPhotoType;
import com.dfmy.entity.index.AtiMonitorMedia;
import com.dfmy.entity.photo.AtiPhoto;
import com.dfmy.service.device.AtiDeviceDataRecordHistoryService;
import com.dfmy.service.device.AtiDeviceDataRecordService;
import com.dfmy.service.index.AtiMonitorMediaService;
import com.dfmy.service.project.AtiMonitorParamProjectService;
import com.dfmy.util.PropertiesUtil;

@Controller
@RequestMapping("/monitorContent")
public class MonitorContentController extends BaseController{

	@Autowired
	private AtiDeviceDataRecordService atiDeviceDataRecordService;
	@Autowired
	private AtiDeviceDataRecordHistoryService atiDeviceDataRecordHistoryService;
	@Autowired
	private AtiMonitorParamProjectService atiMonitorParamProjectService;
	@Autowired
	private AtiMonitorMediaService atiMonitorMediaService;
	
	
	@RequestMapping("/getMonitorItemsConfig")
	@ResponseBody
	public ResultEntity getMonitorItemsConfig (String projectId,String monitorTypeId) {
		ResultEntity res = new ResultEntity();
		try {
			List<Map<String, Object>> list = atiMonitorParamProjectService.getMonitorParamsConfig(projectId, monitorTypeId);
			res.setData(list);
			res.setSuccess(SUCCESS);
			res.setMessage(GET_SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			res.setSuccess(ERROR);
			res.setMessage(GET_ERROR);
		}
		return res;
	}
	
	@RequestMapping("/getRealTimeDatas")
	@ResponseBody
	public ResultEntity getRealTimeDatas (String projectId,String monitorParamId) {
		ResultEntity res = new ResultEntity();
		try {
			List<Map<String, Object>> list = atiDeviceDataRecordService.getRealTimeDatas(projectId, monitorParamId);
			if (list != null && list.size() > 0) {
				res.setSuccess(SUCCESS);
				res.setMessage(GET_SUCCESS);
				res.setData(list);
			} else {
				res.setSuccess(NULL);
				res.setMessage(IS_NULL);
			}
		} catch (Exception e) {
			res.setSuccess(ERROR);
			res.setMessage(GET_ERROR);
			e.printStackTrace();
		}
		return res;
	}
	
	@RequestMapping("/getAllNoDealErrorData")
	@ResponseBody
	public ResultEntity getAllNoDealErrorData (String projectId) {
		ResultEntity res = new ResultEntity();
		try {
			List<Map<String, Object>> list = atiDeviceDataRecordHistoryService.getAllNoDealErrorData(projectId);
			if (list != null && list.size() > 0) {
				res.setSuccess(SUCCESS);
				res.setMessage(GET_SUCCESS);
				res.setData(list);
			} else {
				res.setSuccess(NULL);
				res.setMessage(IS_NULL);
			}
		} catch (Exception e) {
			res.setSuccess(ERROR);
			res.setMessage(GET_ERROR);
			e.printStackTrace();
		}
		return res;
	}
	/**
	 * 检测内容模块多媒体信息上传
	 * @param request
	 * @param response
	 * @param files
	 * @return
	 */
	@RequestMapping("/upload")
	@ResponseBody
	public ResultEntity upload(HttpServletRequest request,HttpServletResponse response,@RequestParam("file[]")MultipartFile[] files){
		ResultEntity res = new ResultEntity();		
		try{
			String projectId =request.getParameter("projectId");
			if (files.length>0) {
				for (MultipartFile multipartFile : files) {
					String type=multipartFile.getOriginalFilename().substring(multipartFile.getOriginalFilename().lastIndexOf(".")+1);
					try {
						  String path =PropertiesUtil.getVal("file.upload.url")+type+"/";
						    File file = new File(path);
					        if (!file.exists()) {
					            file.mkdirs();
					        }
						    // 文件保存路径  
			                String fileName =  multipartFile.getOriginalFilename();  
			                // 转存文件  
			                multipartFile.transferTo(new File(path+fileName));
			                //存数据库
			                AtiMonitorMedia atiMonitorMedia =new AtiMonitorMedia();
			                atiMonitorMedia.setId(UUID.randomUUID().toString());
			                String typeInDb ="2";
			                if (!type.equals("mp4")) {
								typeInDb = "1";
							}
			                atiMonitorMedia.setType(typeInDb);
			                atiMonitorMedia.setProjectId(projectId);
			                atiMonitorMedia.setUrl("/upload/"+type+"/"+fileName);
			                atiMonitorMedia.setRealUrl(path+fileName);
			                SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
			                atiMonitorMedia.setCreateTime(df.format(new Date()));
			                atiMonitorMediaService.save(atiMonitorMedia);
			                res.setSuccess(SUCCESS);    
					} catch (Exception e) {
						e.printStackTrace();
						res.setSuccess(ERROR);
					}
					   
					}				
			}else {
				res.setSuccess(ERROR);
			}
		}catch (Exception e) {
			e.printStackTrace();		
			res.setSuccess(ERROR);
			}
		return res;
	}
	/**
	 * 获取检测内容照片信息
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/getPhoto")
	@ResponseBody
	public ResultEntity getPhoto (HttpServletRequest request,HttpServletResponse response) {
		ResultEntity res = new ResultEntity();
		try {
			String projectId = request.getParameter("projectId");
			List<AtiMonitorMedia> atiMonitorMedias =atiMonitorMediaService.findByProjectIdAndType(projectId,"1");
			Collections.reverse(atiMonitorMedias); // 倒序排列 
			if (atiMonitorMedias.size()>6) {
				List<AtiMonitorMedia> newList =new ArrayList<AtiMonitorMedia>();
				newList.add(atiMonitorMedias.get(0));
				newList.add(atiMonitorMedias.get(1));
				newList.add(atiMonitorMedias.get(2));
				newList.add(atiMonitorMedias.get(3));
				newList.add(atiMonitorMedias.get(4));
				newList.add(atiMonitorMedias.get(5));
				res.setData(newList);
				res.setSuccess(SUCCESS);
			}else{
				res.setData(atiMonitorMedias);
				res.setSuccess(SUCCESS);
			}
		} catch (Exception e) {
			res.setSuccess(ERROR);
			res.setMessage(GET_ERROR);
			e.printStackTrace();
		}
		return res;
	}
	/**
	 * 获取监测内容视频信息
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping("/getVideo")
	@ResponseBody
	public ResultEntity getVideo (HttpServletRequest request,HttpServletResponse response) {
		ResultEntity res = new ResultEntity();
		try {
			String projectId = request.getParameter("projectId");
			List<AtiMonitorMedia> atiMonitorMedias =atiMonitorMediaService.findByProjectIdAndType(projectId,"2");
			Collections.reverse(atiMonitorMedias); // 倒序排列 
			if (atiMonitorMedias.size()>0) {
				  res.setData(atiMonitorMedias.get(0));
				  res.setSuccess(SUCCESS);
			}else {
				 res.setSuccess(ERROR);
				 res.setMessage(GET_ERROR);				
			}
		} catch (Exception e) {
			res.setSuccess(ERROR);
			res.setMessage(GET_ERROR);
			e.printStackTrace();
		}
		return res;
	}
	
	
	
	@RequestMapping("/delPhoto")
	@ResponseBody
	public ResultEntity delPhoto (HttpServletRequest request,HttpServletResponse response) {
		ResultEntity res = new ResultEntity();
		try {
			String pid = request.getParameter("photoId");
			if (StringUtils.isNoneBlank(pid)) {
				atiMonitorMediaService.deleteById(pid);
				res.setSuccess(SUCCESS);
			}else{
				res.setSuccess(ERROR);
			}
		} catch (Exception e) {
			res.setSuccess(ERROR);
			res.setMessage(GET_ERROR);
			e.printStackTrace();
		}
		return res;
	}
	
	
}
