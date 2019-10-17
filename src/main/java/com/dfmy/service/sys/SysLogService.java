package com.dfmy.service.sys;

import org.springframework.data.domain.Page;

import com.dfmy.entity.sys.SysLog;

public interface SysLogService {
	/**
	 * 日志保存
	 * @param sysLog
	 * @return
	 */
	public SysLog save(SysLog sysLog);
	
	/**
	 * 日志分页列表查询
	 * @param pageNumber
	 * @param pageSize
	 * @param sortColom
	 * @param log
	 * @return
	 */
	public Page<SysLog> pageList(int pageNumber,int pageSize,String sortColom,SysLog log);
}
