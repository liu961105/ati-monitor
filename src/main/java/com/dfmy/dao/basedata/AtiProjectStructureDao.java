package com.dfmy.dao.basedata;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.dfmy.entity.basedata.AtiProjectStructure;

public interface AtiProjectStructureDao
		extends PagingAndSortingRepository<AtiProjectStructure, String>, JpaSpecificationExecutor<AtiProjectStructure> {

	public List<AtiProjectStructure> findByState(String state);
	
	public AtiProjectStructure findByCode(String code);
}
