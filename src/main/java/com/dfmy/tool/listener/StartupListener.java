package com.dfmy.tool.listener;

import javax.annotation.PostConstruct;

import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.stereotype.Component;

@Component
public class StartupListener  implements ApplicationListener<ContextRefreshedEvent>{

	@Override
	public void onApplicationEvent(ContextRefreshedEvent event) {
		if (event.getApplicationContext().getParent() == null) {
			System.out.println("============>Spring 容器加载后的执行方法");
        }
	}
	@PostConstruct
	public void initial()
	{
		//JobManager.addJob("BI_Job", "BI_trigger", HelloJob.class, "0/20 * * * * ?");
	}

}
