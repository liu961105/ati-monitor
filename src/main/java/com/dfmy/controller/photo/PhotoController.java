package com.dfmy.controller.photo;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import com.dfmy.controller.common.BaseController;
import com.dfmy.entity.ResultEntity;
import com.dfmy.entity.basedata.AtiPhotoType;
import com.dfmy.entity.photo.AtiPhoto;
import com.dfmy.entity.photo.ShowPhoto;
import com.dfmy.entity.project.AtiProject;
import com.dfmy.service.basedata.AtiPhotoTypeService;
import com.dfmy.service.photo.AtiPhotoService;
import com.dfmy.service.project.AtiProjectService;
import com.dfmy.util.PropertiesUtil;
/**
 * 工程相册、工程相册维护Controller
 * cyx
 * */
@RestController
@RequestMapping("/photo")
public class PhotoController extends BaseController{
	
	@Resource
	private AtiProjectService  atiProjectService;
	@Resource
	private AtiPhotoTypeService atiPhotoTypeService;
	@Resource
	private AtiPhotoService atiPhotoService;
	
	@RequiresPermissions("projectPhoto:photoList")
	@RequestMapping("/getPhotoList")
	@ResponseBody
	public ResultEntity getPhotoList(HttpServletRequest request,HttpServletResponse response){
		ResultEntity res = new ResultEntity();		
		try{
			String projectId =request.getParameter("projectId");
			if (StringUtils.isNoneEmpty(projectId)) {
				AtiProject project =atiProjectService.findProjectById(projectId);
				List<ShowPhoto> showPhotos = new ArrayList<ShowPhoto>();
				List<AtiPhotoType> atiPhotoTypes =atiPhotoTypeService.findByStructId(project.getProjectStructureId());
                for (AtiPhotoType atiPhotoType : atiPhotoTypes) {
				    ShowPhoto showPhoto =new ShowPhoto();
				    showPhoto.setName(atiPhotoType.getName());
				    showPhoto.setCode(atiPhotoType.getCode());
				    List<AtiPhoto> atiPhotos = atiPhotoService.findByProjectIdAndTypeId(projectId, atiPhotoType.getId());
				    if (atiPhotos.size()>0) {
						showPhoto.setCover(atiPhotos.get(atiPhotos.size()-1).getUrl());
					}else {
						showPhoto.setCover("/ati-monitor/res/img/gcxcgl/zwzp.png");
					}
				    showPhotos.add(showPhoto);
				}				
				res.setData(showPhotos);
				res.setSuccess(SUCCESS);
			}else {
				res.setSuccess(ERROR);
			}
		}catch (Exception e) {
			e.printStackTrace();		
			res.setSuccess(ERROR);
			}
		return res;
	}
	
	
	
	@RequestMapping("/getProjectInfoPhotoList")
	@ResponseBody
	public ResultEntity getProjectInfoPhotoList(HttpServletRequest request,HttpServletResponse response){
		ResultEntity res = new ResultEntity();		
		try{
			String projectId =request.getParameter("projectId");
			if (StringUtils.isNoneEmpty(projectId)) {
				AtiProject project =atiProjectService.findProjectById(projectId);
				List<AtiPhotoType> atiPhotoTypes =atiPhotoTypeService.findByStructId(project.getProjectStructureId());
				if(atiPhotoTypes.size()<5){
				res.setData(atiPhotoTypes);
				}else{
					List<AtiPhotoType> newList =new ArrayList<AtiPhotoType>();
					newList.add(atiPhotoTypes.get(0));
					newList.add(atiPhotoTypes.get(1));
					newList.add(atiPhotoTypes.get(2));
					newList.add(atiPhotoTypes.get(3));
					res.setData(newList);
				}
				res.setSuccess(SUCCESS);
			}else {
				res.setSuccess(ERROR);
			}
		}catch (Exception e) {
			e.printStackTrace();		
			res.setSuccess(ERROR);
			}
		return res;
	}
	
	@RequestMapping("/getImageByType")
	@ResponseBody
	public ResultEntity getImageByType(HttpServletRequest request,HttpServletResponse response){
		ResultEntity res = new ResultEntity();		
		try{
			String projectId =request.getParameter("projectId");
			String type =request.getParameter("type");
			AtiPhotoType atiPhotoType =atiPhotoTypeService.findByCode(type);
			if (StringUtils.isNotEmpty(projectId) && StringUtils.isNotEmpty(type)) {
				List<AtiPhoto> atiPhotos =atiPhotoService.findByProjectIdAndTypeId(projectId, atiPhotoType.getId());				
				res.setData(atiPhotos);
				res.setSuccess(SUCCESS);
			}else {
				res.setSuccess(ERROR);
			}
		}catch (Exception e) {
			e.printStackTrace();		
			res.setSuccess(ERROR);
			}
		return res;
	}
	
	@RequestMapping("/delPhoto")
	@ResponseBody
	public ResultEntity delPhoto(HttpServletRequest request,HttpServletResponse response){
		ResultEntity res = new ResultEntity();		
		try{
			String photoId =request.getParameter("photoId");

			if (StringUtils.isNotEmpty(photoId)) {
				String typeIdString = atiPhotoService.findById(photoId).getTypeId();
				atiPhotoService.DeleteById(photoId);
				if (atiPhotoService.findByTypeId(typeIdString).size()==0) {
					AtiPhotoType atiPhotoType= atiPhotoTypeService.findById(typeIdString);
					atiPhotoType.setCover("/ati-monitor/res/img/gcxcgl/zwzp.png");
					atiPhotoTypeService.save(atiPhotoType);
				}else{
					AtiPhotoType atiPhotoType= atiPhotoTypeService.findById(typeIdString);
					AtiPhoto atiPhoto = atiPhotoService.findByTypeId(atiPhotoType.getId()).get(0);
					atiPhotoType.setCover(atiPhoto.getUrl());
					atiPhotoTypeService.save(atiPhotoType);
				}
				
				res.setSuccess(SUCCESS);
			}else {
				res.setSuccess(ERROR);
			}
		}catch (Exception e) {
			e.printStackTrace();		
			res.setSuccess(ERROR);
			}
		return res;
	}
	

	@RequestMapping("/upload")
	@ResponseBody
	public ResultEntity upload(HttpServletRequest request,HttpServletResponse response,@RequestParam("file[]")MultipartFile[] files){
		ResultEntity res = new ResultEntity();		
		try{
			String type =request.getParameter("type");
			String projectId =request.getParameter("projectId");
			if (StringUtils.isNotEmpty(type) && files.length>0) {
				for (MultipartFile multipartFile : files) {
					 try {   
						    String path =PropertiesUtil.getVal("file.upload.url")+"/"+type+"/";
						    File file = new File(path);
					        if (!file.exists()) {
					            file.mkdirs();
					        }
						    // 文件保存路径  
			                String fileName =  multipartFile.getOriginalFilename();  
			                // 转存文件  
			                multipartFile.transferTo(new File(path+fileName));  
			                //存数据库
			                AtiPhotoType atiPhotoType =atiPhotoTypeService.findByCode(type);
			                AtiPhoto atiPhoto =new AtiPhoto(); 
                            atiPhoto.setId(UUID.randomUUID().toString());
                            atiPhoto.setTypeId(atiPhotoType.getId());
                            atiPhoto.setRealUrl(path+fileName);
                            atiPhoto.setUrl("/upload/"+type+"/"+fileName);
                            atiPhoto.setProjectId(projectId);
                            atiPhotoService.savePhoto(atiPhoto);
                            atiPhotoType.setCover("/upload/"+type+"/"+fileName);
                            atiPhotoTypeService.save(atiPhotoType);
			                res.setSuccess(SUCCESS);    
			            } catch (Exception e) {  
			                e.printStackTrace();  
			                res.setSuccess(ERROR);
			            }  
				}			
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
