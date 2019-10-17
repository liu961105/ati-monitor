package com.dfmy.websocket;

import java.io.IOException;

import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextRefreshedEvent;

public class SpringAfterStart implements ApplicationListener<ContextRefreshedEvent>{

	@Override
	public void onApplicationEvent(ContextRefreshedEvent arg0) {
		try {
			MyMsgType.WS = new MyWsStart(12315,new MyMsgHandler());
			MyMsgType.WS.start();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
