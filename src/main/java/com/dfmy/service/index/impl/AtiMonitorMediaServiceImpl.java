package com.dfmy.service.index.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dfmy.dao.index.AtiMonitorMediaDao;
import com.dfmy.entity.index.AtiMonitorMedia;
import com.dfmy.service.index.AtiMonitorMediaService;
@Service
public class AtiMonitorMediaServiceImpl implements AtiMonitorMediaService{
	
	@Autowired
	private AtiMonitorMediaDao atiMonitorMediaDao;

	@Override
	public void save(AtiMonitorMedia atiMonitorMedia) {
		atiMonitorMediaDao.save(atiMonitorMedia);
	}

	@Override
	public List<AtiMonitorMedia> findByProjectId(String projectId) {
		// TODO Auto-generated method stub
		return atiMonitorMediaDao.findByProjectId(projectId);
	}

	@Override
	public List<AtiMonitorMedia> findByProjectIdAndType(String projectId, String type) {
		// TODO Auto-generated method stub
		return atiMonitorMediaDao.findByProjectIdAndType(projectId, type);
	}

	@Override
	public void deleteById(String id) {
		// TODO Auto-generated method stub
		atiMonitorMediaDao.delete(id);
	}

	
}
