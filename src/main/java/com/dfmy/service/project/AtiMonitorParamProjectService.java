package com.dfmy.service.project;

import java.util.List;
import java.util.Map;

import com.dfmy.entity.project.AtiMonitorParamProject;

public interface AtiMonitorParamProjectService {

	/**
	 * 项目关联监测项保存
	 * 
	 * @param atiMonitorParamProject
	 * @return
	 */
	public AtiMonitorParamProject save(AtiMonitorParamProject atiMonitorParamProject);

	/**
	 * 根据结构类型获取监测类型树结构
	 * 
	 * @param structId
	 * @return
	 */
	public List<Map<String, Object>> getTree(String pid);

	/**
	 * 获取项目下所有已关联参数
	 * 
	 * @param projectId
	 * @return
	 */
	public List<AtiMonitorParamProject> findByProjectId(String projectId);

	/**
	 * 删除项目已关联参数
	 * 
	 * @param projectId
	 * @param paramId
	 */
	public void deleteByProjectIdAndParamIds(String projectId, String paramIds);

	/**
	 * 根据项目和已关联参数获取数据实体
	 * 
	 * @param projectId
	 * @param paramId
	 * @return
	 */
	public AtiMonitorParamProject findByProjectIdAndParamId(String projectId, String paramId);
	
	/**
	 * 根据项目主键和监测类型过滤获取项目已关联的监测项和监测参数（监测内容用）
	 * @param projectId
	 * @param monitorTypeId
	 * @return
	 */
	public List<Map<String, Object>> getMonitorParamsConfig(String projectId,String monitorTypeId);

}
