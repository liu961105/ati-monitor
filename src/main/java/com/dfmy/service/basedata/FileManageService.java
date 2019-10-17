package com.dfmy.service.basedata;

import java.util.List;

import org.springframework.data.domain.Page;

import com.dfmy.entity.basedata.AtiPhotoType;
import com.dfmy.entity.basedata.FileManage;

import com.dfmy.util.PageUtils;

public interface FileManageService {

	/**
	 * 获取文件
	 * @param 
	 * @param pageUtils
	 * @return
	 */
	public List<FileManage> getFileList(String fileId,PageUtils pageUtils);
	
	/**
	 * 文件列表分页
	 */
	public Page<FileManage> pageList(int pageNumber, int pageSize, String sortColom, String fileName,String strucId,String fileId);
	
	/**
	 * 文件信息保存
	 * @param fileManage
	 * @return
	 */
	public FileManage save (FileManage fileManage);
   /*
    * 文件删除
    */
	public void delete(String id);

	public FileManage findById(String iD);

}
