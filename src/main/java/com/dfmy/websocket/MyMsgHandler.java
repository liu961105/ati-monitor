package com.dfmy.websocket;

import java.nio.ByteBuffer;

import org.tio.core.Aio;
import org.tio.core.ChannelContext;
import org.tio.http.common.HttpRequest;
import org.tio.http.common.HttpResponse;
import org.tio.websocket.common.WsRequest;
import org.tio.websocket.server.handler.IWsMsgHandler;

public class MyMsgHandler implements IWsMsgHandler {

	/**
	 * 握手时走这个方法，业务可以在这里获取cookie，request参数等
	 */
	public HttpResponse handshake(HttpRequest request, HttpResponse httpResponse, ChannelContext channelContext)
			throws Exception {
		String type = request.getParam("type");
		Aio.bindGroup(channelContext, type);
		return httpResponse;
	}

	/**
	 * 字节消息（binaryType = arraybuffer）过来后会走这个方法
	 */
	public Object onBytes(WsRequest wsRequest, byte[] bytes, ChannelContext channelContext) throws Exception {
		String ss = new String(bytes, "utf-8");
		ByteBuffer buffer = ByteBuffer.allocate(bytes.length);
		buffer.put(bytes);
		return buffer;
	}

	/**
	 * 当客户端发close flag时，会走这个方法
	 */
	public Object onClose(WsRequest wsRequest, byte[] bytes, ChannelContext channelContext) throws Exception {
		Aio.remove(channelContext, "");
		return null;
	}

	/**
	 * 字符消息（binaryType = blob）过来后会走这个方法
	 */
	public Object onText(WsRequest wsRequest, String text, ChannelContext channelContext) throws Exception {
		System.out.println(text);
		return "握手成功";
	}

	@Override
	public void onAfterHandshaked(HttpRequest request, HttpResponse response, ChannelContext channelContext) throws Exception {
		
	}

}
