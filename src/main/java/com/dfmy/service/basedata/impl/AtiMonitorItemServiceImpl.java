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

import com.dfmy.dao.basedata.AtiMonitorItemDao;
import com.dfmy.entity.basedata.AtiMonitorItem;
import com.dfmy.service.basedata.AtiMonitorItemService;

@Service
@Transactional
public class AtiMonitorItemServiceImpl implements AtiMonitorItemService {

	@Autowired
	private AtiMonitorItemDao atiMonitorItemDao;

	@Override
	public Page<AtiMonitorItem> pageList(int pageNumber, int pageSize, String sortColom, final String name,
			final String strucId, final String typeId) {
		Pageable pageable = new PageRequest(pageNumber - 1, pageSize, Sort.Direction.ASC, sortColom);
		Page<AtiMonitorItem> page = atiMonitorItemDao.findAll(new Specification<AtiMonitorItem>() {
			@Override
			public Predicate toPredicate(Root<AtiMonitorItem> root, CriteriaQuery<?> query,
					CriteriaBuilder criteriaBuilder) {
				List<Predicate> list = new ArrayList<Predicate>();
				if (StringUtils.isNotBlank(name)) {
					list.add(criteriaBuilder.like(root.get("name").as(String.class), "%" + name + "%"));
				}
				if (StringUtils.isNotBlank(strucId)) {
					Path<String> atiProjectStructure = root.get("atiMonitorType").get("atiProjectStructure").get("id");
                    list.add(criteriaBuilder.equal(atiProjectStructure, strucId));
				}
				if (StringUtils.isNotBlank(typeId)) {
					Path<String> atiMonitorType = root.get("atiMonitorType").get("id");
                    list.add(criteriaBuilder.equal(atiMonitorType, typeId));
				}
				Predicate[] p = new Predicate[list.size()];
				return criteriaBuilder.and(list.toArray(p));
			}
		}, pageable);
		return page;
	}

	@Override
	public AtiMonitorItem save(AtiMonitorItem atiMonitorItem) {
		return atiMonitorItemDao.save(atiMonitorItem);
	}

	@Override
	public void delete(String id) {
		atiMonitorItemDao.delete(id);
	}

	@Override
	public AtiMonitorItem findById(String id) {
		return atiMonitorItemDao.findOne(id);
	}

	@Override
	public List<AtiMonitorItem> findByState(String state) {
		return atiMonitorItemDao.findByState(state);
	}
	
	@Override
	public List<AtiMonitorItem> findByTypeId(String typeId) {
		return atiMonitorItemDao.findByTypeId(typeId);
	}

}
