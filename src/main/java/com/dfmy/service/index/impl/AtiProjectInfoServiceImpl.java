package com.dfmy.service.index.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.dfmy.dao.index.AtiProjectInfoDao;
import com.dfmy.entity.index.AtiProjectInfo;
import com.dfmy.entity.project.AtiProject;
import com.dfmy.service.index.AtiProjectInfoService;

@Service
@Transactional
public class AtiProjectInfoServiceImpl implements AtiProjectInfoService {
	
	@Autowired
	private AtiProjectInfoDao atiProjectInfoDao;

	@Override
	public void deleteByProject(AtiProject atiProject) {
		atiProjectInfoDao.deleteByProject(atiProject);
	}
	
	@Override
	public AtiProjectInfo save (AtiProjectInfo atiProjectInfo) {
		return atiProjectInfoDao.save(atiProjectInfo);
	}

}
