package com.dfmy.service.sys;

import java.net.SocketException;

import org.springframework.data.domain.Page;
import org.springframework.stereotype.Service;

import com.dfmy.entity.sys.SysCompanyInfo;

@Service
public interface SysCompanyInfoService {
	
	/**
	 * 分页查询
	 * @param pageNumber
	 * @param pageSize
	 * @param sortColom
	 * @param companyInfo
	 * @return
	 */
	public Page<SysCompanyInfo> getCompanyPage(int pageNumber,int pageSize,String sortColom,final SysCompanyInfo companyInfo) throws SocketException;
	
	/**
	 * 保存
	 * @param companyInfo
	 */
	public SysCompanyInfo saveCompany(SysCompanyInfo companyInfo) throws SocketException;
	
	/**
	 * 删除
	 * @param companyId
	 */
	public void deleteCompany(String companyId) throws SocketException;
	
	/**
	 * 根据主键查询
	 * @param companyId
	 * @return
	 * @throws SocketException
	 */
	public SysCompanyInfo findOne(String companyId) throws SocketException;
}
