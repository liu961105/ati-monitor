package com.dfmy.dao.basedata;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import com.dfmy.entity.basedata.AtiFileType;

public interface AtiFileTypeDao extends PagingAndSortingRepository<AtiFileType, String>, 
JpaSpecificationExecutor<AtiFileType>{
	
    public List<AtiFileType> findByState(String state);
	
	@Query("select t from AtiFileType t where t.atiProjectStructure.id=?")
	public List<AtiFileType> findByStructId(String structId);
	
    public AtiFileType findByCode(String code);
}
