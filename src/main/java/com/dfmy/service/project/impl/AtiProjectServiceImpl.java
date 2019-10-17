package com.dfmy.service.project.impl;

import com.dfmy.dao.project.AtiProjectDao;
import com.dfmy.dao.sys.SysUserDao;
import com.dfmy.entity.project.AtiProject;
import com.dfmy.entity.sys.SysRole;
import com.dfmy.entity.sys.SysUser;
import com.dfmy.service.project.AtiProjectService;
import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.*;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.ArrayList;
import java.util.List;

@Transactional
@Service
public class AtiProjectServiceImpl implements AtiProjectService {

    @Autowired
    private AtiProjectDao atiProjectDao;

    @Autowired
    private SysUserDao sysUserDao;


    @Override
    public Page<AtiProject> pageList(int pageNumber, int pageSize, String sortColom, final AtiProject atiProject) {
        Pageable pageable = new PageRequest(pageNumber-1, pageSize, Sort.Direction.ASC,sortColom);
        String userName = SecurityUtils.getSubject().getPrincipal().toString();
        SysUser sysUser = sysUserDao.findByUserName(userName);

        int roleType = getUserType(sysUser);
        if(roleType == 0){
            //说明为其他不识别数据 不予处理 直接返回
            return new PageImpl<AtiProject>(new ArrayList<AtiProject>(),pageable,0);
        }
        atiProject.setRoleType(roleType);
        atiProject.setSearchUserId(sysUser.getUserId());

        Page<AtiProject> pageInfo = atiProjectDao.findAll(new Specification<AtiProject>() {
            @Override
            public Predicate toPredicate(Root<AtiProject> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                List<Predicate> list = new ArrayList<Predicate>();
                if(StringUtils.isNotBlank(atiProject.getProjectName())){
                    list.add(criteriaBuilder.like(root.get("projectName").as(String.class), "%" + atiProject.getProjectName()+"%"));
                }
                if(StringUtils.isNotBlank(atiProject.getAddress())){
                    list.add(criteriaBuilder.like(root.get("address").as(String.class), "%" + atiProject.getAddress()+"%"));
                }
                if(atiProject.getProjectStatus() != null){
                    if(0 == atiProject.getProjectStatus()){
                        list.add(criteriaBuilder.equal(root.get("warnCount").as(Integer.class), 0));
                    }else {
                        list.add(criteriaBuilder.gt(root.get("warnCount").as(Integer.class), 0));
                    }
                }
                if(StringUtils.isNotBlank(atiProject.getProjectStructureId())){
                    list.add(criteriaBuilder.equal(root.get("projectStructureId").as(String.class),atiProject.getProjectStructureId()));
                }

                Integer rType = atiProject.getRoleType();
                if(rType == 2){
                    list.add(criteriaBuilder.equal(root.get("managerId").as(String.class),atiProject.getSearchUserId()));
                }


                list.add(criteriaBuilder.equal(root.get("state").as(Character.class),'1'));

                Predicate[] p = new Predicate[list.size()];
                return criteriaBuilder.and(list.toArray(p));
            }
        },pageable);

        return pageInfo;
    }

    @Override
    public AtiProject saveProjectInfo(AtiProject atiProject) {
        String userName = SecurityUtils.getSubject().getPrincipal().toString();
        SysUser sysUser = sysUserDao.findByUserName(userName);
        int roleType = getUserType(sysUser);
        if(roleType == 2){
            //说明为项目负责人  设置改人员id
            atiProject.setManagerId(sysUser.getUserId());
        }
        return atiProjectDao.save(atiProject);
    }

    @Override
    public AtiProject findProjectById(String id) {
        return atiProjectDao.findOne(id);
    }

    @Override
    public void deleteProjectId(String id) {
        atiProjectDao.delete(id);
    }

    @Override
    public List<AtiProject> findAllByState(String state) {
        return atiProjectDao.findAllByState(true);
    }

    @Override
    public List<AtiProject> findAllByManagerId(String managerId) {
        return atiProjectDao.findAllByManagerId(managerId);
    }

    @Override
    public List<AtiProject> findCurrentBeResponsibleForProject(final String structureId) {
        String userName = SecurityUtils.getSubject().getPrincipal().toString();
        final SysUser sysUser = sysUserDao.findByUserName(userName);
        final int roleType = getUserType(sysUser);
        if(roleType == 0){
            //说明为其他不识别数据 不予处理 直接返回
            return new ArrayList<>();
        }

        List<AtiProject> atiProjects = atiProjectDao.findAll(new Specification<AtiProject>() {
            @Override
            public Predicate toPredicate(Root<AtiProject> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                List<Predicate> list = new ArrayList<Predicate>();
                    list.add(criteriaBuilder.equal(root.get("projectStructureId").as(String.class),structureId));

                Integer rType = roleType;
                if(rType == 2){
                    list.add(criteriaBuilder.equal(root.get("managerId").as(String.class),sysUser.getUserId()));
                }
                list.add(criteriaBuilder.equal(root.get("state").as(Character.class),'1'));
                Predicate[] p = new Predicate[list.size()];
                return criteriaBuilder.and(list.toArray(p));
            }
        });
        return atiProjects;
    }


    @Override
    public void updateProjectManagerId(List<String> projectIds, String managerId) {
        //先把当前的项目managerID 清空
        atiProjectDao.updateProjectManagerId(projectIds,"");
        //先把当前的项目managerID
        atiProjectDao.clearManagerId(managerId);
        //赋权
        atiProjectDao.updateProjectManagerId(projectIds, managerId);
    }

    @Override
    public Long countAllByState(){
        return atiProjectDao.count(new Specification<AtiProject>() {
            @Override
            public Predicate toPredicate(Root<AtiProject> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                List<Predicate> list = new ArrayList<Predicate>();
                list.add(criteriaBuilder.equal(root.get("state").as(Character.class),'1'));
                Predicate[] p = new Predicate[list.size()];
                return criteriaBuilder.and(list.toArray(p));
            }
        });
    }

    private static int getUserType(SysUser sysUser){
        //1为超级管理员  2为项目负责人 0未知身份
        int roleType = 0;
        List<String> roleAdmin = new ArrayList<>();
        roleAdmin.add("8a929c0c60dda9f10160ddaecae00006");
        roleAdmin.add("402880e860f555c20160f584af0c0002");
        roleAdmin.add("402880e860f555c20160f58478880001");
        for(SysRole role : sysUser.getRoles()){
            if(roleAdmin.contains(role.getRoleId())){
                roleType = 1;
                break;
            }
            if("402881ee6bb57e18016bb57fdc090001".equals(role.getRoleId())){
                roleType = 2;
                break;
            }
        }
        return roleType;
    }
    
    @Override
    public  AtiProject save(AtiProject atiProject) {
    	return atiProjectDao.save(atiProject);
    }
}
