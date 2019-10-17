package com.dfmy.dao.basedata;
import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;
import com.dfmy.entity.basedata.FileManage;

/**
 * 文档管理DAO
 */



public interface FileManageDao extends PagingAndSortingRepository<FileManage, String>,
JpaSpecificationExecutor<FileManage>{

	public FileManage findById(String iD);
	
}
