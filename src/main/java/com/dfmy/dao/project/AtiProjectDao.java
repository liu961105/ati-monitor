package com.dfmy.dao.project;

import com.dfmy.entity.project.AtiProject;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.data.repository.query.Param;

import java.util.List;


/**
 * caoxudong
 */
public interface AtiProjectDao extends PagingAndSortingRepository<AtiProject, String>,
        JpaSpecificationExecutor<AtiProject> {

    /**
     * 查询所有有效的项目
     * @param state
     * @return
     */
    List<AtiProject> findAllByState(Boolean state);

    /**
     * 获取所有被选中的项目
     * @return
     */
    List<AtiProject> findAllByManagerId(String managerId);

    /**
     * 赋权项目负责人
     * @param projectIds
     * @param managerId
     */
    @Modifying
    @Query("update AtiProject set managerId = :managerId where id in (:projectIds)")
    void updateProjectManagerId(@Param("projectIds") List<String> projectIds,@Param("managerId") String managerId);

    @Modifying
    @Query("update AtiProject set managerId = '' where managerId = :managerId")
    void clearManagerId(@Param("managerId") String managerId);

}
