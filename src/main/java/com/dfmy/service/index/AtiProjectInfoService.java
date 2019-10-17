package com.dfmy.service.index;

import com.dfmy.entity.index.AtiProjectInfo;
import com.dfmy.entity.project.AtiProject;

public interface AtiProjectInfoService {

	/**
	 * 根据项目删除工程信息
	 * @param atiProject
	 */
	public void deleteByProject(AtiProject atiProject);
	
	/**
	 * 工程信息保存
	 * @param atiProjectInfo
	 * @return
	 */
	public AtiProjectInfo save (AtiProjectInfo atiProjectInfo);
}
