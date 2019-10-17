package com.dfmy.websocket;

import org.tio.core.Aio;
import org.tio.websocket.common.WsResponse;

public class AlarmSendKit {

	public static void send(String json, String type) {
		try {
			WsResponse p = new WsResponse();
			p.setBody(json.getBytes("UTF-8"));
			Aio.bSendToGroup(MyMsgType.WS.getServerGroupContext(), type, p);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
