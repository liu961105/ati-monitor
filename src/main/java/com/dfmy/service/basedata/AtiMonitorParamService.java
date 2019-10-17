package com.dfmy.service.basedata;

import org.springframework.data.domain.Page;

import com.dfmy.entity.basedata.AtiMonitorParam;

import java.util.List;

public interface AtiMonitorParamService {
	/**
	 * 监测参数分页
	 * @param pageNumber
	 * @param pageSize
	 * @param sortColom
	 * @param name
	 * @param typeId
	 * @param itemId
	 * @return
	 */
	public Page<AtiMonitorParam> pageList(int pageNumber, int pageSize, String sortColom, String name,String typeId,String itemId);
	
	/**
	 * 监测参数保存
	 * @param AtiMonitorParam
	 */
	public AtiMonitorParam save(AtiMonitorParam atiMonitorParam);
	
	/**
	 * 监测参数删除
	 * @param id
	 */
	public void delete(String id);
	
	/**
	 * 监测参数查找
	 * @param id
	 * @return
	 */
	public AtiMonitorParam findById(String id);

	/**
	 * 根据有效类型查询
	 * @param state
	 * @return
	 */
	public List<AtiMonitorParam> findByState(String state);
	
	/**
	 * 根据监测项主键获取监测参数列表
	 * @param itemId
	 * @return
	 */
	public List<AtiMonitorParam> findByItemId(String itemId);
}
