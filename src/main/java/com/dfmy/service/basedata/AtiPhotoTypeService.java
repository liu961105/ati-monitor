package com.dfmy.service.basedata;

import java.util.List;
import org.springframework.data.domain.Page;
import com.dfmy.entity.basedata.AtiPhotoType;

public interface AtiPhotoTypeService {

	public AtiPhotoType findByCode(String code);
	/**
	 * 相册类型分页
	 * @param pageNumber
	 * @param pageSize
	 * @param sortColom
	 * @param name
	 * @param strucId
	 * @return
	 */
	public Page<AtiPhotoType> pageList(int pageNumber, int pageSize, String sortColom, String name,String strucId);
	
	/**
	 * 相册类型保存
	 * @param atiMonitorType
	 */
	public AtiPhotoType save(AtiPhotoType atiPhotoType);
	
	/**
	 * 相册类型删除
	 * @param id
	 */
	public void delete(String id);
	
	/**
	 * 相册类型查找
	 * @param id
	 * @return
	 */
	public AtiPhotoType findById(String id);
	
	/**
	 * 根据数据状态获取所有相册类型列表
	 * @param state
	 * @return
	 */
	public List<AtiPhotoType> findByState(String state);
	
	/**
	 * 根据结构类型获取所有相册类型列表
	 * @param structId
	 * @return
	 */
	public List<AtiPhotoType> findByStructId(String structId);
	


}
