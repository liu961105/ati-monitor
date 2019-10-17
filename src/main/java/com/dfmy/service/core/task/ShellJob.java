package com.dfmy.service.core.task;

import org.quartz.Job;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;

import com.dfmy.tool.other.RemoteShellExecutor;

public class ShellJob implements Job  {

	@Override
	public void execute(JobExecutionContext arg0) throws JobExecutionException {
		 RemoteShellExecutor executor = new RemoteShellExecutor("10.18.28.133", "zhangjl", "zhang3137");
	        // 执行myTest.sh 参数为java Know dummy
	     try {
			System.out.println(executor.exec("/Users/zhangjl/test"));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
