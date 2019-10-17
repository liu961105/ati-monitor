package com.dfmy.service.core.task;

import com.dfmy.tool.schedule.JobManager;

/**
 * 任务注册管理类
 * @author wang
 *
 */
public class RegisterJob {
	
	
	public  static  void appStartRegister(){
		
		//在数据库中查询出需要注册的任务类
		JobManager.addJob("BI_Job", "BI_trigger", HelloJob.class,  "0/1 * * * * ?");
		
	}
	
}
