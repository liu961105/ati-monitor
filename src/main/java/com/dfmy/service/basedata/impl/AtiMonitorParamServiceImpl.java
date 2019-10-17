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

import com.dfmy.dao.basedata.AtiMonitorParamDao;
import com.dfmy.entity.basedata.AtiMonitorParam;
import com.dfmy.service.basedata.AtiMonitorParamService;

@Service
@Transactional
public class AtiMonitorParamServiceImpl implements AtiMonitorParamService {

	@Autowired
	private AtiMonitorParamDao atiMonitorParamDao;

	@Override
	public Page<AtiMonitorParam> pageList(int pageNumber, int pageSize, String sortColom, final String name,
			final String typeId, final String itemId) {
		Pageable pageable = new PageRequest(pageNumber - 1, pageSize, Sort.Direction.ASC, sortColom);
		Page<AtiMonitorParam> page = atiMonitorParamDao.findAll(new Specification<AtiMonitorParam>() {
			@Override
			public Predicate toPredicate(Root<AtiMonitorParam> root, CriteriaQuery<?> query,
					CriteriaBuilder criteriaBuilder) {
				List<Predicate> list = new ArrayList<Predicate>();
				if (StringUtils.isNotBlank(name)) {
					list.add(criteriaBuilder.like(root.get("name").as(String.class), "%" + name + "%"));
				}
				if (StringUtils.isNotBlank(typeId)) {
					Path<String> atiMonitorType = root.get("atiMonitorItem").get("atiMonitorType").get("id");
					list.add(criteriaBuilder.equal(atiMonitorType, typeId));
				}
				if (StringUtils.isNotBlank(itemId)) {
					Path<String> atiMonitorItem = root.get("atiMonitorItem").get("id");
					list.add(criteriaBuilder.equal(atiMonitorItem, itemId));
				}
				Predicate[] p = new Predicate[list.size()];
				return criteriaBuilder.and(list.toArray(p));
			}
		}, pageable);
		return page;
	}

	@Override
	public AtiMonitorParam save(AtiMonitorParam atiMonitorParam) {
		return atiMonitorParamDao.save(atiMonitorParam);
	}

	@Override
	public void delete(String id) {
		atiMonitorParamDao.delete(id);
	}

	@Override
	public AtiMonitorParam findById(String id) {
		return atiMonitorParamDao.findOne(id);
	}

	@Override
	public List<AtiMonitorParam> findByState(String state) {
		return atiMonitorParamDao.findByState(state);
	}
	
	@Override
	public List<AtiMonitorParam> findByItemId(String itemId) {
		return atiMonitorParamDao.findByItemId(itemId);
	}


}
