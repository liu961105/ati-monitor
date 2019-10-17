package com.dfmy.service.basedata.impl;

import java.util.ArrayList;
import java.util.List;
import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Path;
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

import com.dfmy.dao.basedata.AtiPhotoTypeDao;
import com.dfmy.entity.basedata.AtiPhotoType;
import com.dfmy.service.basedata.AtiPhotoTypeService;
@Service
@Transactional
public class AtiPhotoTypeServiceImpl implements AtiPhotoTypeService {
	
	@Autowired
	private AtiPhotoTypeDao atiPhotoTypeDao;

	@Override
	public Page<AtiPhotoType> pageList(int pageNumber, int pageSize, String sortColom, final String name,
			final String strucId) {
		Pageable pageable = new PageRequest(pageNumber - 1, pageSize, Sort.Direction.ASC, sortColom);
		Page<AtiPhotoType> page = atiPhotoTypeDao.findAll(new Specification<AtiPhotoType>() {
			@Override
			public Predicate toPredicate(Root<AtiPhotoType> root, CriteriaQuery<?> query,
					CriteriaBuilder criteriaBuilder) {
				List<Predicate> list = new ArrayList<Predicate>();
				if (StringUtils.isNotBlank(name)) {
					list.add(criteriaBuilder.like(root.get("name").as(String.class), "%" + name + "%"));
				}
				if (StringUtils.isNotBlank(strucId)) {
					Path<String> atiProjectStructure = root.get("atiProjectStructure").get("id");
					list.add(criteriaBuilder.equal(atiProjectStructure, strucId));
				}
				Predicate[] p = new Predicate[list.size()];
				return criteriaBuilder.and(list.toArray(p));
			}
		}, pageable);
		return page;
	}

	@Override
	public AtiPhotoType save(AtiPhotoType atiPhotoType) {
		return atiPhotoTypeDao.save(atiPhotoType);
	}

	@Override
	public void delete(String id) {
		atiPhotoTypeDao.delete(id);
	}

	@Override
	public AtiPhotoType findById(String id) {
		return atiPhotoTypeDao.findOne(id);
	}

	@Override
	public List<AtiPhotoType> findByState(String state) {
		return atiPhotoTypeDao.findByState(state);
	}

	@Override
	public List<AtiPhotoType> findByStructId(String structId) {
		return atiPhotoTypeDao.findByStructId(structId);
	}

	@Override
	public AtiPhotoType findByCode(String code) {
		// TODO Auto-generated method stub
		return atiPhotoTypeDao.findByCode(code);
	}
}
