package com.dfmy.service.basedata;

import java.util.List;

import org.springframework.data.domain.Page;

import com.dfmy.entity.basedata.AtiProjectStructure;

public interface AtiProjectStructureService {
	
public Page<AtiProjectStructure> pageList(int pageNumber, int pageSize, String sortColom, String name);
	
	/**
	 * 结构类型保存
	 * @param atiProjectStructure
	 */
	public AtiProjectStructure save(AtiProjectStructure atiProjectStructure);
	
	/**
	 * 结构类型删除
	 * @param id
	 */
	public void delete(String id);
	
	/**
	 * 结构类型查找
	 * @param id
	 * @return
	 */
	public AtiProjectStructure findById(String id);
	
	
	
	/**
	 * 根据数据状态查询结构分类列表
	 * @param state
	 * @return
	 */
	public List<AtiProjectStructure> findByState(String state); 
	
	/**
	 * 根据结构分类编码获取结构分类主键
	 * @param code
	 * @return
	 */
	public AtiProjectStructure findByCode(String code);

	/**
	 * 查询所有
	 * @return
	 */
	List<AtiProjectStructure> findAll();

}
