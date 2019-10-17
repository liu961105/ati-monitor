package com.dfmy.service.device.impl;

import com.dfmy.dao.device.AtiProjectMonitorSitesDao;
import com.dfmy.entity.device.AtiProjectMonitorSites;
import com.dfmy.service.device.AtiProjectMonitorSitesService;


import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.ArrayList;
import java.util.List;


@Service
@Transactional
public class AtiProjectMonitorSitesServiceImpl implements AtiProjectMonitorSitesService {


    @Autowired
    private AtiProjectMonitorSitesDao atiProjectMonitorSitesDao;


    @Override
    public List<AtiProjectMonitorSites> findMonitorSites(final AtiProjectMonitorSites monitorSites) {
        List<AtiProjectMonitorSites> pageInfo = atiProjectMonitorSitesDao.findAll(new Specification<AtiProjectMonitorSites>() {
            @Override
            public Predicate toPredicate(Root<AtiProjectMonitorSites> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                List<Predicate> list = new ArrayList<Predicate>();
                if(StringUtils.isNotBlank(monitorSites.getProjectId())){
                    list.add(criteriaBuilder.like(root.get("projectId").as(String.class), monitorSites.getProjectId()));
                }
                if(StringUtils.isNotBlank(monitorSites.getMonitorParamId())){
                    list.add(criteriaBuilder.like(root.get("monitorParamId").as(String.class), monitorSites.getMonitorParamId()));
                }
                if(StringUtils.isNotBlank(monitorSites.getDeviceId())){
                    list.add(criteriaBuilder.like(root.get("deviceId").as(String.class), monitorSites.getDeviceId()));
                }
                list.add(criteriaBuilder.equal(root.get("state").as(Character.class),'1'));

                Predicate[] p = new Predicate[list.size()];
                return criteriaBuilder.and(list.toArray(p));
            }
        });
        return pageInfo;
    }

    @Override
    public void save(AtiProjectMonitorSites atiProjectMonitorSites) {
        atiProjectMonitorSitesDao.save(atiProjectMonitorSites);
    }

    @Override
    public void delete(String id) {
        atiProjectMonitorSitesDao.delete(id);
    }

	@Override
	public List<AtiProjectMonitorSites> findByMonitorParamIdAndProjectId(String paramId,String projectId) {

		return atiProjectMonitorSitesDao.findByMonitorParamIdAndProjectId(paramId,projectId);
	}

    @Override
    public AtiProjectMonitorSites findMonitorById(String id) {
        return atiProjectMonitorSitesDao.findOne(id);
    }

    @Override
    public List<AtiProjectMonitorSites> findAllByProjectId(String projectId) {
        return atiProjectMonitorSitesDao.findAllByProjectId(projectId);
    }
}
