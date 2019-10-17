package com.dfmy.dao.basedata;

import java.util.List;

import org.springframework.data.jpa.repository.JpaSpecificationExecutor;
import org.springframework.data.repository.PagingAndSortingRepository;

import com.dfmy.entity.basedata.EmailService;

public interface EmailServiceDao
		extends PagingAndSortingRepository<EmailService, String>, JpaSpecificationExecutor<EmailService> {

	public List<EmailService> findByState(String state);
}
