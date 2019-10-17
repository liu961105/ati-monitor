package com.dfmy.service.sys;

import java.util.List;
import java.util.Map;

import org.springframework.data.domain.Page;

import com.dfmy.entity.sys.SysParam;

public interface SysParamService {
	
	/**
	 * 参数分页列表查询
	 * @param pageNumber
	 * @param pageSize
	 * @param sortColom
	 * @param param
	 * @return
	 */
	Page<SysParam> pageList(int pageNumber,int pageSize,String sortColom,SysParam param);
	
	/**
	 * 子参数分页列表
	 * @param pageNumber
	 * @param pageSize
	 * @param sortColom
	 * @param param
	 * @return
	 */
	Page<SysParam> pageSonList(int pageNumber,int pageSize,String sortColom,SysParam param);

	/**
	 * 参数实体保存
	 * @param param
	 * @return
	 */
	SysParam saveParam(SysParam param);

	/**
	 * 根据主键删除参数
	 * @param iD
	 */
	void deleteParam(String iD);

	/**
	 * 根据主键查找参数
	 * @param iD
	 * @return
	 */
	SysParam findParam(String iD);
	
	/**
	 * 查找最顶级参数
	 * @return
	 */
	List<SysParam> findTopList();
	
	/**
	 * 查找所有参数
	 * @return
	 */
	List<Map<String,Object>> findAll();
	
	/**
	 * 根据父级编码查询
	 * @param parentCode
	 * @return
	 */
	public List<SysParam> findByParentCode(SysParam parentParam);
	
	/**
	 * 根据父级编码和当前编码查询
	 * @param parentCode
	 * @param code
	 * @return
	 */
	public SysParam findByPcodeAndCode(SysParam parentCode,String code);
	
	/**
	 * 根据参数编码查参数
	 * @param paramCode
	 * @return
	 */
	public SysParam findByParamCode(String paramCode);

	/**
	 * 根据父级id查找参数
	 * @param iD
	 * @return
	 */
	public List<SysParam> findParamByPid(String iD);
	
	public List<Map<String, Object>> findPrentParamList();
	
	/**
	 * 根据父级编码获取自定义参数列表
	 * @return
	 */
	public List<Map<String, Object>> getListByParentParamCodeIn(String paramCodeIn);
	
	/**
	 * 根据状态获取参数列表
	 * @param status
	 * @return
	 */
	public List<SysParam> findByStatus (String status);
	
}
