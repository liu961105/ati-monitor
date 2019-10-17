package com.dfmy.service.index;

import java.util.List;

import com.dfmy.entity.index.AtiMonitorMedia;

public interface AtiMonitorMediaService {
	
	/**
	 * 保存监测内容媒体信息
	 * @param atiMonitorMedia
	 */
	public void save(AtiMonitorMedia atiMonitorMedia);
	
	void deleteById(String id);
	
	List<AtiMonitorMedia> findByProjectId(String projectId);
	
	List<AtiMonitorMedia> findByProjectIdAndType(String projectId,String type);

}
