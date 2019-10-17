package com.dfmy.dao.sys;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.dfmy.entity.sys.SysCompanyInfo;

public interface SysCompanyInfoDao extends PagingAndSortingRepository<SysCompanyInfo, String>,
JpaSpecificationExecutor<SysCompanyInfo>{

}
