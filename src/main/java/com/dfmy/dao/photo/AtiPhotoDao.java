package com.dfmy.dao.photo;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;
import com.dfmy.entity.photo.AtiPhoto;

public interface AtiPhotoDao extends PagingAndSortingRepository<AtiPhoto, String>, 
JpaSpecificationExecutor<AtiPhoto>{
	 List<AtiPhoto> findByProjectId(String id);
	 List<AtiPhoto> findByTypeId(String typeId);
	 List<AtiPhoto> findByProjectIdAndTypeId(String projectId,String typeId);
	 List<AtiPhoto> findByTypeIdAndProjectId(String typeId,String projectId);
}
