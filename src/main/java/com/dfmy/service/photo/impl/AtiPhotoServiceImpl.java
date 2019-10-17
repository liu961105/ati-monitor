package com.dfmy.service.photo.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.dfmy.dao.photo.AtiPhotoDao;
import com.dfmy.entity.photo.AtiPhoto;
import com.dfmy.service.photo.AtiPhotoService;

@Service
public class AtiPhotoServiceImpl implements AtiPhotoService{
	
	@Autowired
	private AtiPhotoDao atiPhotoDao;

	@Override
	public void savePhoto(AtiPhoto atiPhoto) {
		// TODO Auto-generated method stub
		atiPhotoDao.save(atiPhoto);
	}

	@Override
	public List<AtiPhoto> findByProjectId(String id) {
		// TODO Auto-generated method stub
		return atiPhotoDao.findByProjectId(id);
	}

	@Override
	public List<AtiPhoto> findByProjectIdAndTypeId(String projectId, String typeId) {
		// TODO Auto-generated method stub
		return atiPhotoDao.findByProjectIdAndTypeId(projectId, typeId);
	}

	@Override
	public void DeleteById(String id) {
		atiPhotoDao.delete(id);
	}

	@Override
	public AtiPhoto findById(String id) {
		// TODO Auto-generated method stub
		return atiPhotoDao.findOne(id);
	}

	@Override
	public List<AtiPhoto> findByTypeId(String typeId) {
		// TODO Auto-generated method stub
		return atiPhotoDao.findByTypeId(typeId);
	}

	@Override
	public List<AtiPhoto> findByTypeIdAndProjectId(String typeId, String projectId) {
		// TODO Auto-generated method stub
		return atiPhotoDao.findByTypeIdAndProjectId(typeId, projectId);
	}

}
