package com.dfmy.dao.basedata;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import com.dfmy.entity.basedata.AtiPhotoType;

public interface AtiPhotoTypeDao extends PagingAndSortingRepository<AtiPhotoType, String>, 
JpaSpecificationExecutor<AtiPhotoType>{
	
    public List<AtiPhotoType> findByState(String state);
	
	@Query("select t from AtiPhotoType t where t.atiProjectStructure.id=?")
	public List<AtiPhotoType> findByStructId(String structId);
	
    public AtiPhotoType findByCode(String code);
}
