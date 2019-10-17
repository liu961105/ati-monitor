package com.dfmy.service.project;

import com.dfmy.entity.project.AtiProject;
import org.springframework.data.domain.Page;

import java.util.List;


public interface AtiProjectService {

    Page<AtiProject> pageList(int pageNumber, int pageSize, String sortColom, final AtiProject atiProject);

    AtiProject saveProjectInfo(AtiProject atiProject);

    AtiProject findProjectById(String id);

    void deleteProjectId(String id);

    List<AtiProject> findAllByState(String state);

    /**
     * 获取所有被选中的项目
     * @return
     */
    List<AtiProject> findAllByManagerId(String managerId);

    /**
     * 根据结构类型  负责人id查询项目
     */
    List<AtiProject> findCurrentBeResponsibleForProject(String structureId);

    /**
     * 赋权项目负责人
     * @param projectIds
     * @param managerId
     */
    void updateProjectManagerId(List<String> projectIds,String managerId);

    Long countAllByState();
    
    public  AtiProject save(AtiProject atiProject);
}
