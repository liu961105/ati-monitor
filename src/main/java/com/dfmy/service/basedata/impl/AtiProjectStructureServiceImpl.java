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

import com.dfmy.dao.basedata.AtiProjectStructureDao;
import com.dfmy.entity.basedata.AtiProjectStructure;
import com.dfmy.service.basedata.AtiProjectStructureService;

@Service
@Transactional
public class AtiProjectStructureServiceImpl implements AtiProjectStructureService {

	@Autowired
	private AtiProjectStructureDao atiProjectStructureDao;

	@Override
	public Page<AtiProjectStructure> pageList(int pageNumber, int pageSize, String sortColom, final String name) {
		Pageable pageable = new PageRequest(pageNumber - 1, pageSize, Sort.Direction.ASC, sortColom);
		Page<AtiProjectStructure> page = atiProjectStructureDao.findAll(new Specification<AtiProjectStructure>() {
			@Override
			public Predicate toPredicate(Root<AtiProjectStructure> root, CriteriaQuery<?> query,
					CriteriaBuilder criteriaBuilder) {
				List<Predicate> list = new ArrayList<Predicate>();
				if (StringUtils.isNotBlank(name)) {
					list.add(criteriaBuilder.like(root.get("name").as(String.class), "%" + name + "%"));
				}
				Predicate[] p = new Predicate[list.size()];
				return criteriaBuilder.and(list.toArray(p));
			}
		}, pageable);
		return page;
	}

	@Override
	public AtiProjectStructure save(AtiProjectStructure atiProjectStructure) {
		return atiProjectStructureDao.save(atiProjectStructure);
	}

	@Override
	public void delete(String id) {
		atiProjectStructureDao.delete(id);
	}

	@Override
	public AtiProjectStructure findById(String id) {
		return atiProjectStructureDao.findOne(id);
	}

	@Override
	public List<AtiProjectStructure> findByState(String state) {
		return atiProjectStructureDao.findByState(state);
	}
	
	@Override
	public AtiProjectStructure findByCode(String code) {
		return atiProjectStructureDao.findByCode(code); 
	}

	@Override
	public List<AtiProjectStructure> findAll() {
		return (List<AtiProjectStructure>) atiProjectStructureDao.findAll();
	}

}