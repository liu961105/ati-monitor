package com.dfmy.controller.basedata;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.zip.ZipOutputStream;
import java.util.zip.ZipEntry;
import javax.servlet.http.HttpServletRequest;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import com.dfmy.controller.common.BaseController;
import com.dfmy.entity.ResultEntity;
import com.dfmy.entity.basedata.AtiFileType;
import com.dfmy.entity.basedata.FileManage;
import com.dfmy.entity.project.AtiProject;

import com.dfmy.service.basedata.FileManageService;
import com.dfmy.util.ReadProperties;
import com.dfmy.util.TimeHelper;

@Controller
@RequestMapping("/fileManage")
public class FileManageController  extends BaseController{

	@Autowired
	private FileManageService fileManageService;
	
	 /* 
	 * 文件列表分页查询
	 * @param pageCurrent
	 * @param 
	 * @return
	 */
	//@RequiresPermissions("fileManage:pageList")
	@RequestMapping(value = "/pageList")
	@ResponseBody
	private ResultEntity pageList(@RequestParam(value = "pageCurrent", defaultValue = "1") String pageCurrent,String fileId,String fileName,String strucId) {
		ResultEntity res = new ResultEntity();
		try {
			Page<FileManage> page = fileManageService.pageList(Integer.parseInt(pageCurrent), PAGESIZE, "createTime",fileName,strucId, fileId);
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
		}
		return res;
		}
	
	 /*
     * 文件批量删除
     */
	@RequestMapping("/fileDeletes")
	@ResponseBody
	public ResultEntity fileDeletes(String ID) {
		ResultEntity res = new ResultEntity();
		try {
			if(StringUtils.isNotBlank(ID)){
				String[]fileIdArr = ID.split(",");
				for(String ids:fileIdArr){
					fileManageService.delete(ids);
				}
			}
			res.setSuccess("success");
			res.setMessage("刪除成功");
		} catch (Exception e) {
			e.printStackTrace();
			res.setSuccess("error");
			res.setMessage("刪除失败，请稍后再试");
		}
		return res;
	}
	/*
	 * 单个文件删除
	 * @param ID
	 * @return
	 */
	@RequestMapping("/fileDelete")
	@ResponseBody
	public ResultEntity fileDelete(String ID) {
		ResultEntity res = new ResultEntity();
		try {
			if(StringUtils.isNotBlank(ID)){
					fileManageService.delete(ID);
			}
			res.setSuccess("success");
			res.setMessage("刪除成功");
		} catch (Exception e) {
			e.printStackTrace();
			res.setSuccess("error");
			res.setMessage("刪除失败，请稍后再试");
		}
		return res;
	}
	
	/*
	 * 查找项目名称
	 */
	@RequestMapping("/getProjectName")
	@ResponseBody
	public ResultEntity getProjectName(String ID) {
		ResultEntity res = new ResultEntity();
		try {
			if(StringUtils.isNotBlank(ID)){
				String[]fileIdArr = ID.split(",");
				for(String ids:fileIdArr){
					fileManageService.delete(ids);
				}
			}
			res.setSuccess("success");
			res.setMessage("刪除成功");
		} catch (Exception e) {
			e.printStackTrace();
			res.setSuccess("error");
			res.setMessage("刪除失败，请稍后再试");
		}
		return res;
	}
	@RequestMapping("findById")
	@ResponseBody
	public ResultEntity findById(String ID){
		ResultEntity res = new ResultEntity();
		try {
			
			res.setData(fileManageService.findById(ID));
			res.setMessage(GET_SUCCESS);
			res.setSuccess(SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			res.setMessage(GET_ERROR + ":" + e.getMessage());
			res.setSuccess(ERROR);
		}
		return res;
	}
	@RequestMapping("save")
	@ResponseBody
	public ResultEntity save(FileManage fileManage,String projectId ){
		ResultEntity res = new ResultEntity();
		Subject currentUser = SecurityUtils.getSubject();
		try {
			if(StringUtils.isNotBlank(fileManage.getId())){
				fileManage.setUpdateTime(TimeHelper.getCurrentTime());
				fileManage.setUpdateUser((String)currentUser.getPrincipal());
			}else{
				fileManage.setCreateTime(TimeHelper.getCurrentTime());
				fileManage.setCreateUser((String)currentUser.getPrincipal());
			}
			fileManageService.save(fileManage);
			res.setMessage(OPERATE_SUCCESS);
			res.setSuccess(SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			res.setMessage(OPERATE_ERROR + ":" + e.getMessage());
			res.setSuccess(ERROR);
		}
		return res;
	}
	
	

	/*
	 *  文件上传
	 */
	@RequestMapping("/uploadFile")
	@ResponseBody
	public ResultEntity uploadFile(MultipartFile file, String mfCode,String projectName,
			String fileId, HttpServletRequest request ) {
		ResultEntity res = new ResultEntity();
		try {
			if (!file.isEmpty()) {
				// 上传文件路径
				ReadProperties pro = new ReadProperties("/ApplicationResources.properties");
				String path = pro.getProperty("file.upload.url").toString();
				// String path =
				// request.getServletContext().getRealPath("/images/");
				// 上传文件名
				String filename = file.getOriginalFilename();
				File filepath = new File(path, filename);
				// 判断路径是否存在，如果不存在就创建一个
				if (!filepath.getParentFile().exists()) {
					filepath.getParentFile().mkdirs();
				}
				// 将上传文件保存到一个目标文件当中
				file.transferTo(new File(path + File.separator + filename));
				// 将文件信息保存到数据库
				mfCode = "undefined".equals(mfCode)?"":mfCode;
				FileManage fileManage = new FileManage();
				Subject currentUser = SecurityUtils.getSubject();
				String userName = (String)currentUser.getPrincipal();
				fileManage.setCreateUser(userName);
				AtiProject atiProject = new AtiProject();
				atiProject.setProjectName(projectName);
				fileManage.setAtiProject(atiProject);
				fileManage.setFileId((fileId));
				fileManage.setFileType("");
				fileManage.setFileName(filename);
				fileManage.setFilePath(path);
				fileManage.setFileSize(String.valueOf(file.getSize()) + "K");
				fileManage.setUploadTime(TimeHelper.getCurrentTime());
				fileManage.setCreateTime(TimeHelper.getCurrentTime());
				fileManage.setShStatus("1");
				fileManage.setStatus("1");
				fileManageService.save(fileManage);
				res.setSuccess("success");
				res.setMessage("上传成功");
			} else {
				res.setSuccess("error");
				res.setMessage("文件不能为空");
			}
		} catch (Exception e) {
			e.printStackTrace();
			res.setSuccess("error");
			res.setMessage("系统错误，请联系管理员");
		}
		return res;
	}
	
	/**
	 * 单个文件下载
	 * 
	 * @param fileName
	 * @param filePath
	 * @return
	 * @throws IOException
	 */
	
	@RequestMapping("/download")
	public ResponseEntity<byte[]> export(String fileName, String filePath) throws IOException {

		HttpHeaders headers = new HttpHeaders();
		String resultPath = filePath+"/"+fileName;
		File file = new File(resultPath);
		headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
		headers.setContentDispositionFormData("attachment", fileName);

		return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file), headers, HttpStatus.CREATED);
	}
	
	/**
	 * 批量文件压缩包下载
	 * 
	 * @param fileNames
	 * @param filePaths
	 * @param request
	 * @return
	 * @throws IOException
	 */
	
	@RequestMapping("/downLoadFiles")
	public ResponseEntity<byte[]> download2(String fileNames, String filePaths, HttpServletRequest request)
			throws IOException {

		// 需要压缩的文件
		String[] filenameArr = fileNames.substring(0, fileNames.length() - 1).split(",");
		String[] filePathArr = filePaths.substring(0, filePaths.length() - 1).split(",");
		// 压缩后的文件
		String resourcesName = "文件下载.zip";
		ReadProperties pro = new ReadProperties("/ApplicationResources.properties");
		String path = pro.getProperty("file.download.tmp.url").toString();
		ZipOutputStream zipOut = new ZipOutputStream(new FileOutputStream(path + resourcesName));
		InputStream input = null;

		for (int i = 0; i < filenameArr.length; i++) {
			String name = filePathArr[i] + File.separator + filenameArr[i];
			input = new FileInputStream(new File(name));
			zipOut.putNextEntry(new ZipEntry(filenameArr[i]));
			int temp = 0;
			while ((temp = input.read()) != -1) {
				zipOut.write(temp);
			}
			input.close();
		}
		zipOut.close();
		File file = new File(path + resourcesName);
		HttpHeaders headers = new HttpHeaders();
		String filename = new String(resourcesName.getBytes("utf-8"), "iso-8859-1");
		headers.setContentDispositionFormData("attachment", filename);
		headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
		return new ResponseEntity<byte[]>(FileUtils.readFileToByteArray(file), headers, HttpStatus.CREATED);
	}
}
