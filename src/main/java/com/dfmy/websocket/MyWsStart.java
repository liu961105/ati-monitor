package com.dfmy.websocket;



import java.io.IOException;

import org.tio.server.ServerGroupContext;
import org.tio.websocket.server.WsServerStarter;

public class MyWsStart {
	
	/**
	 * 测试启动
	 * @param args
	 */
	public static void main(String[] args) throws IOException {
		
	}
	
	private ServerGroupContext serverGroupContext;
	private WsServerStarter wsServerStarter;
	
	public MyWsStart(int port, MyMsgHandler wsMsgHandler) throws IOException {
		wsServerStarter = new WsServerStarter(port, wsMsgHandler);
		serverGroupContext = wsServerStarter.getServerGroupContext();
	}
	
	public ServerGroupContext getServerGroupContext() {
		return serverGroupContext;
	}

	public WsServerStarter getWsServerStarter() {
		return wsServerStarter;
	}

	public void start() throws IOException {
		wsServerStarter.start();
	}
	
	public void stop(){
		serverGroupContext.setStopped(true);
	}
}
