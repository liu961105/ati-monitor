package com.dfmy.tool.schedule;

import org.quartz.CronScheduleBuilder;
import org.quartz.CronTrigger;
import org.quartz.JobBuilder;
import org.quartz.JobDetail;
import org.quartz.JobKey;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.SchedulerFactory;
import org.quartz.TriggerBuilder;
import org.quartz.TriggerKey;
import org.quartz.impl.StdSchedulerFactory;

/**
 * 作业注册管理器
 * @author wang
 *
 */
public class JobManager {
	
	private static int SUCCESS = 1;//启动成功
	private static int ERROR = 0;//启动失败
	private static String JOB_GROUP = "jobGroup";//JOB组
	private static String TRIGGER_GROUP = "triggerGroup";//TRIGGER组
	private static SchedulerFactory sf = new StdSchedulerFactory();
	
	private static Scheduler getScheduler(String jobName,String triggerName, Class jobClass,String cron){
		Scheduler schedule = null;
		try {
			schedule = sf.getScheduler();
			JobDetail job = JobBuilder.newJob(jobClass).withIdentity(jobName, JOB_GROUP).build();
			CronTrigger trigger = (CronTrigger) TriggerBuilder
					.newTrigger()
					.withIdentity(triggerName, TRIGGER_GROUP)
					.withSchedule(CronScheduleBuilder.cronSchedule(cron))
					.build();
			schedule.scheduleJob(job, trigger);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return schedule;
	}
	//添加任务
	public static int addJob(String jobName,String triggerName, Class jobClass,String cron) {
		try {
			Scheduler schedule = getScheduler(jobName,triggerName,jobClass,cron);
//			JobDetail job = JobBuilder.newJob(jobClass).withIdentity(jobName, jobName).build();
//			CronTrigger trigger = (CronTrigger) TriggerBuilder
//					.newTrigger()
//					.withIdentity(triggerName, triggerName)
//					.withSchedule(CronScheduleBuilder.cronSchedule(cron))
//					.build();
//			schedule.scheduleJob(job, trigger);
			// 启动
			if (!schedule.isShutdown()) {
				schedule.start();
				return SUCCESS;
			}
		} catch (Exception e) {
			
			e.printStackTrace();
			return ERROR;
		}
		return -1;
	}

	
	//删除任务
	public static void removeJob(String jobName) {
		try {
			Scheduler sched = sf.getScheduler();
			System.out.println(	sched.getSchedulerInstanceId()+"=="+sched.getSchedulerName());
			System.out.println(	sched.getJobGroupNames().size());
			System.out.println(	sched.checkExists(new JobKey("Job2")));
			JobDetail job1=sched.getJobDetail(new JobKey("Job2"));
			if(job1!=null)
			{
				 System.out.println(job1.getKey());
			}
		
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
	}
	
	
	//暂停任务
	public static int pauseJob(String jobName,String triggerName, Class jobClass,String cron) 
	{
		try {
			Scheduler scheduler = sf.getScheduler();
			JobKey jobKey = JobKey.jobKey(jobName,JOB_GROUP);
			scheduler.pauseJob(jobKey);
			TriggerKey triggerKey = TriggerKey.triggerKey(JOB_GROUP, TRIGGER_GROUP);
			scheduler.pauseTrigger(triggerKey);// 停止触发器  
	        scheduler.unscheduleJob(triggerKey);// 移除触发器  
	        scheduler.deleteJob(JobKey.jobKey(jobName, JOB_GROUP));// 删除任务  
	        System.out.println("已停止【"+jobName+"】任务");
			return SUCCESS;
		} catch (SchedulerException e) {
			e.printStackTrace();
			return ERROR;
		}
	}
	
	//恢复任务
	public static void resumeJob(String jobName) 
	{
		
		
		
	}

}
