package com.dfmy.service.device.impl;

import com.dfmy.dao.device.AtiDeviceDao;
import com.dfmy.dao.device.AtiMonitorParamDeviceDao;
import com.dfmy.entity.device.AtiDevice;
import com.dfmy.entity.device.AtiMonitorParamDevice;
import com.dfmy.service.device.AtiDeviceService;
import com.dfmy.service.device.AtiMonitorParamDeviceService;
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
public class AtiDeviceServiceImpl implements AtiDeviceService {

    @Autowired
    private AtiDeviceDao atiDeviceDao;

    @Autowired
    private AtiMonitorParamDeviceDao atiMonitorParamDeviceDao;

    @Override
    public Page<AtiDevice> pageList(int pageNumber, int pageSize, String sortColom,final AtiDevice atiDevice) {
        Pageable pageable = new PageRequest(pageNumber-1, pageSize, Sort.Direction.ASC,sortColom);
        Page<AtiDevice> pageInfo = atiDeviceDao.findAll(new Specification<AtiDevice>() {
            @Override
            public Predicate toPredicate(Root<AtiDevice> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                List<Predicate> list = new ArrayList<Predicate>();
                if(StringUtils.isNotBlank(atiDevice.getDeviceName())){
                    list.add(criteriaBuilder.like(root.get("deviceName").as(String.class), "%" + atiDevice.getDeviceName()+"%"));
                }
                if(StringUtils.isNotBlank(atiDevice.getDeviceCode())){
                    list.add(criteriaBuilder.like(root.get("deviceCode").as(String.class), "%" + atiDevice.getDeviceCode()+"%"));
                }
                list.add(criteriaBuilder.equal(root.get("state").as(Character.class),'1'));

                Predicate[] p = new Predicate[list.size()];
                return criteriaBuilder.and(list.toArray(p));
            }
        },pageable);

        return pageInfo;
    }

    @Override
    public AtiDevice saveAtiDevice(AtiDevice atiProject) {
        return atiDeviceDao.save(atiProject);
    }

    @Override
    public AtiDevice findAtiDeviceById(String id) {
        return atiDeviceDao.findOne(id);
    }

    @Override
    public void deleteAtiDevice(String id) {
        atiDeviceDao.delete(id);
        //同时删除该表的关联项
        atiMonitorParamDeviceDao.deleteByDeviceId(id);
    }
}
