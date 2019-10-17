package com.dfmy.service.basedata;

import java.util.List;

import org.springframework.data.domain.Page;

import com.dfmy.entity.basedata.AtiMonitorType;

public interface AtiMonitorTypeService {

	/**
	 * 监测类型分页
	 * @param pageNumber
	 * @param pageSize
	 * @param sortColom
	 * @param name
	 * @param strucId
	 * @return
	 */
	public Page<AtiMonitorType> pageList(int pageNumber, int pageSize, String sortColom, String name,String strucId);
	
	/**
	 * 监测类型保存
	 * @param atiMonitorType
	 */
	public AtiMonitorType save(AtiMonitorType atiMonitorType);
	
	/**
	 * 监测类型删除
	 * @param id
	 */
	public void delete(String id);
	
	/**
	 * 监测类型查找
	 * @param id
	 * @return
	 */
	public AtiMonitorType findById(String id);
	
	/**
	 * 根据数据状态获取所有监测类型列表
	 * @param state
	 * @return
	 */
	public List<AtiMonitorType> findByState(String state);
	
	/**
	 * 根据结构类型获取所有监测类型列表
	 * @param structId
	 * @return
	 */
	public List<AtiMonitorType> findByStructId(String structId);
	
}
