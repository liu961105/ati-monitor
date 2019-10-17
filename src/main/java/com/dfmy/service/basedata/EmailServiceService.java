package com.dfmy.service.basedata;

import java.util.List;

import org.springframework.data.domain.Page;

import com.dfmy.entity.basedata.EmailService;

public interface EmailServiceService {

	/**
	 * 邮箱服务设置分页
	 * @param pageNumber
	 * @param pageSize
	 * @param sortColom
	 * @return
	 */
	public Page<EmailService> pageList(int pageNumber, int pageSize, String sortColom, String ServiceNum);
	
	/**
	 * 邮箱服务设置实体查询
	 * @param id
	 * @return
	 */
	public EmailService findById(String id);
	
	/**
	 * 邮箱服务设置保存
	 * @param emailService
	 * @return
	 */
	public EmailService save(EmailService emailService);
	
	/**
	 * 邮箱服务设置删除
	 * @param id
	 */
	public void delete(String id);
	
	/**
	 * 根据状态查询邮件服务设置列表
	 * @param state
	 * @return
	 */
	public List<EmailService> findByState(String state);

}
