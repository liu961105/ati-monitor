package com.dfmy.dao.sys;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.dfmy.entity.sys.SysLog;

public interface SysLogDao extends PagingAndSortingRepository<SysLog, String>,
JpaSpecificationExecutor<SysLog>{

}
