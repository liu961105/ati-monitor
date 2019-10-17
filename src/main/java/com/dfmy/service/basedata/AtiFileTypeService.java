package com.dfmy.service.basedata;

import java.util.List;
import org.springframework.data.domain.Page;

import com.dfmy.entity.basedata.AtiFileType;


public interface AtiFileTypeService {

	public AtiFileType findByCode(String code);
	
	public Page<AtiFileType> pageList(int pageNumber, int pageSize, String sortColom, String code,String strucId,String projectId);
	
	
	public AtiFileType save(AtiFileType atiFileType);
	
	
	public void delete(String id);
	
	
	public AtiFileType findById(String id);
	
	
	public List<AtiFileType> findByState(String state);
	
	
	public List<AtiFileType> findByStructId(String structId);
	


}
