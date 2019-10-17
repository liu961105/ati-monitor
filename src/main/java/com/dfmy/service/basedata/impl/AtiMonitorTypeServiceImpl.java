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

import com.dfmy.dao.basedata.AtiMonitorTypeDao;
import com.dfmy.entity.basedata.AtiMonitorType;
import com.dfmy.service.basedata.AtiMonitorTypeService;

@Service
@Transactional
public class AtiMonitorTypeServiceImpl implements AtiMonitorTypeService {

	@Autowired
	private AtiMonitorTypeDao atiMonitorTypeDao;

	@Override
	public Page<AtiMonitorType> pageList(int pageNumber, int pageSize, String sortColom, final String name,
			final String strucId) {
		Pageable pageable = new PageRequest(pageNumber - 1, pageSize, Sort.Direction.ASC, sortColom);
		Page<AtiMonitorType> page = atiMonitorTypeDao.findAll(new Specification<AtiMonitorType>() {
			@Override
			public Predicate toPredicate(Root<AtiMonitorType> root, CriteriaQuery<?> query,
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
	public AtiMonitorType save(AtiMonitorType atiMonitorType) {
		return atiMonitorTypeDao.save(atiMonitorType);
	}

	@Override
	public void delete(String id) {
		atiMonitorTypeDao.delete(id);
	}

	@Override
	public AtiMonitorType findById(String id) {
		return atiMonitorTypeDao.findOne(id);
	}

	@Override
	public List<AtiMonitorType> findByState(String state) {
		return atiMonitorTypeDao.findByState(state);
	}

	@Override
	public List<AtiMonitorType> findByStructId(String structId) {
		return atiMonitorTypeDao.findByStructId(structId);
	}

}
