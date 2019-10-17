package com.dfmy.dao.index;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.dfmy.entity.index.AtiProjectInfo;
import com.dfmy.entity.project.AtiProject;

public interface AtiProjectInfoDao
		extends PagingAndSortingRepository<AtiProjectInfo, String>, JpaSpecificationExecutor<AtiProjectInfo> {

	@Modifying
	@Query("delete from AtiProjectInfo t where t.atiProject = ?")
	public void deleteByProject(AtiProject atiProject);
}
