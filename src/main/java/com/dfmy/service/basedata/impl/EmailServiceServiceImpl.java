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

import com.dfmy.dao.basedata.EmailServiceDao;
import com.dfmy.entity.basedata.AtiPhotoType;
import com.dfmy.entity.basedata.EmailService;
import com.dfmy.service.basedata.EmailServiceService;
import com.google.common.base.FinalizablePhantomReference;

@Service
@Transactional
public class EmailServiceServiceImpl implements EmailServiceService {

	@Autowired
	private EmailServiceDao emailServiceDao;

	@Override
	public Page<EmailService> pageList(int pageNumber, int pageSize, String sortColom, final String serviceNum) {
		Pageable pageable = new PageRequest(pageNumber - 1, pageSize, Sort.Direction.ASC, sortColom);
		Page<EmailService> page = emailServiceDao.findAll(new Specification<EmailService>() {
			@Override
			public Predicate toPredicate(Root<EmailService> root, CriteriaQuery<?> query,
					CriteriaBuilder criteriaBuilder) {
				List<Predicate> list = new ArrayList<Predicate>();
				if (StringUtils.isNotBlank(serviceNum)) {
					list.add(criteriaBuilder.like(root.get("serviceNum").as(String.class), "%" + serviceNum + "%"));
				}
				Predicate[] p = new Predicate[list.size()];
				return criteriaBuilder.and(list.toArray(p));
			}
		}, pageable);
		return page;
	}

	@Override
	public EmailService findById(String id) {
		return emailServiceDao.findOne(id);
	}

	@Override
	public EmailService save(EmailService emailService) {
		return emailServiceDao.save(emailService);
	}

	@Override
	public void delete(String id) {
		emailServiceDao.delete(id);
	}
	
	@Override
	public List<EmailService> findByState(String state) {
		return emailServiceDao.findByState(state);
	}
}
