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

import com.dfmy.dao.basedata.AtiFileTypeDao;
import com.dfmy.entity.basedata.AtiFileType;
import com.dfmy.entity.basedata.AtiProjectStructure;
import com.dfmy.service.basedata.AtiFileTypeService;

@Service
@Transactional
public class AtiFileTypeServiceImpl implements AtiFileTypeService {
	
	@Autowired
	private AtiFileTypeDao atiFileTypeDao;

	@Override
	public Page<AtiFileType> pageList(int pageNumber, int pageSize, String sortColom, final String code,
			final String strucId,final String projectId) {
		Pageable pageable = new PageRequest(pageNumber - 1, pageSize, Sort.Direction.ASC, sortColom);
		Page<AtiFileType> page = atiFileTypeDao.findAll(new Specification<AtiFileType>() {
			@Override
			public Predicate toPredicate(Root<AtiFileType> root, CriteriaQuery<?> query,
					CriteriaBuilder criteriaBuilder) {
				List<Predicate> list = new ArrayList<Predicate>();
				if (StringUtils.isNotBlank(code)) {
					list.add(criteriaBuilder.like(root.get("code").as(String.class), "%" +code	 + "%"));
				}
				if (StringUtils.isNotBlank(strucId)) {
					//Path<String> atiProjectStructure = root.get("atiProjectStructure").get("id");
					list.add(criteriaBuilder.like( root.get("atiProjectStructure").get("id").as(String.class), "%" +strucId	 + "%"));
				}
				if (StringUtils.isNotBlank(projectId)) {
					list.add(criteriaBuilder.like( root.get("projectId").as(String.class), "%" +projectId	 + "%"));
				}
			    
				Predicate[] p = new Predicate[list.size()];
				return criteriaBuilder.and(list.toArray(p));
			}
		}, pageable);
		return page;
	}

	@Override
	public AtiFileType save(AtiFileType atiFileType) {
		return atiFileTypeDao.save(atiFileType);
	}

	@Override
	public void delete(String id) {
		atiFileTypeDao.delete(id);
	}

	@Override
	public AtiFileType findById(String id) {
		return atiFileTypeDao.findOne(id);
	}

	@Override
	public List<AtiFileType> findByState(String state) {
		return atiFileTypeDao.findByState(state);
	}

	@Override
	public List<AtiFileType> findByStructId(String structId) {
		return atiFileTypeDao.findByStructId(structId);
	}

	@Override
	public AtiFileType findByCode(String code) {
		// TODO Auto-generated method stub
		return atiFileTypeDao.findByCode(code);
	}
}
