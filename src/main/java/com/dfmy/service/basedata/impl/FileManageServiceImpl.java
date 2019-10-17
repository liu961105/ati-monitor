package com.dfmy.service.basedata.impl;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.dfmy.dao.basedata.FileManageDao;
import com.dfmy.entity.basedata.FileManage;
import com.dfmy.service.basedata.FileManageService;
import com.dfmy.util.PageUtils;

@Service
@Transactional
public class FileManageServiceImpl implements FileManageService {

	@Autowired
	private FileManageDao fileManageDao;

	@Override
	public Page<FileManage> pageList(int pageNumber, int pageSize, String sortColom, final String fileName,
			final String strucId,final String fileId) {
		Pageable pageable = new PageRequest(pageNumber - 1, pageSize, Sort.Direction.ASC, sortColom);
		Page<FileManage> page = fileManageDao.findAll(new Specification<FileManage>() {
			@Override
			public Predicate toPredicate(Root<FileManage> root, CriteriaQuery<?> query,
					CriteriaBuilder criteriaBuilder) {
				List<Predicate> list = new ArrayList<Predicate>();
				if (StringUtils.isNotBlank(fileName)) {
					list.add(criteriaBuilder.like(root.get("fileName").as(String.class), "%" + fileName + "%"));
				}
				if (StringUtils.isNotBlank(fileId)) {
					list.add(criteriaBuilder.like(root.get("fileId").as(String.class), "%" + fileId + "%"));
				}
				Predicate[] p = new Predicate[list.size()];
				return criteriaBuilder.and(list.toArray(p));
			}
		}, pageable);
		return page;
	}

	/**
	 * 
	 * @param fileId
	 * @param fileType
	 * @return
	 */
//	public List<FileManage> getFileList(String fileId, String fileType) {
//		if (StringUtils.isNoneBlank(fileType)) {
//			return fileManageDao.findByFileIdAndProjectId(fileId, fileType);
//		} else {
//			return (List<FileManage>) fileManageDao.findAll();
//		}
//	}

	@Override
	public FileManage save(FileManage fileManage) {
		// TODO Auto-generated method stub
		return fileManageDao.save(fileManage);
	}

	@Override
	public List<FileManage> getFileList(String bridgeId, PageUtils pageUtils) {

		return null;
	}

	@Override
	public void delete(String id) {
		fileManageDao.delete(id);

	}

	@Override
	public FileManage findById(String iD) {
		// TODO Auto-generated method stub
		return fileManageDao.findById(iD);
	}
}
