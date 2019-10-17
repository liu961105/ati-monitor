package com.dfmy.service.core.task;

import java.util.Date;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

public class HelloJob implements Job {

	public HelloJob() {

	}

	public void execute(JobExecutionContext context)
			throws JobExecutionException {
		System.out.println("|---BI定时任务处理" + new Date());
	}
	
//	public static void main(String[] args) {
//		JobManager.addJob("dd1","tr",HelloJob.class,"*/10 * * * * ?");
//	}
	
	

}
