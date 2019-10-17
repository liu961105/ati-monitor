package com.dfmy.service.basedata;

import java.util.List;

import org.springframework.data.domain.Page;

import com.dfmy.entity.basedata.AtiMonitorItem;


public interface AtiMonitorItemService {
	
	/**
	 * 监测项分页
	 * @param pageNumber
	 * @param pageSize
	 * @param sortColom
	 * @param name
	 * @param typeId
	 * @return
	 */
	public Page<AtiMonitorItem> pageList(int pageNumber, int pageSize, String sortColom, String name,String strucId,String typeId);
	
	/**
	 * 监测项保存
	 * @param atiMonitorItem
	 */
	public AtiMonitorItem save(AtiMonitorItem atiMonitorItem);
	
	/**
	 * 监测项删除
	 * @param id
	 */
	public void delete(String id);
	
	/**
	 * 监测项查找
	 * @param id
	 * @return
	 */
	public AtiMonitorItem findById(String id);
	
	/**
	 * 根据数据状态查询所有监测项列表
	 * @param state
	 * @return
	 */
	public List<AtiMonitorItem> findByState(String state);
	
	/**
	 * 根据监测类型主键获取监测项列表
	 * @param typeId
	 * @return
	 */
	public List<AtiMonitorItem> findByTypeId(String typeId);
}
