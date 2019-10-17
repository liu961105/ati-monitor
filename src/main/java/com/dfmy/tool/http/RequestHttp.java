package com.dfmy.tool.http;

import java.io.IOException;
import java.io.InputStream;

import org.apache.http.HttpEntity;
import org.apache.http.client.config.RequestConfig;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.SerializableEntity;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;

import com.dfmy.entity.MessageEntity;
import com.dfmy.tool.other.GetPropertyData;

/**
 * Http请求工具类
 * @author wang
 */
public  class RequestHttp {
	public   void requestService(MessageEntity em) throws Exception {
	        CloseableHttpClient httpclient = HttpClients.createDefault();
	        try {
	            HttpPost httppost = new HttpPost(GetPropertyData.getProperty("SERVERURL"));
	            RequestConfig requestConfig =RequestConfig.custom().setSocketTimeout(5000).setConnectTimeout(5000).build();
	            httppost.setConfig(requestConfig);
	            httppost.setEntity(new SerializableEntity(em, true));
	            CloseableHttpResponse response = httpclient.execute(httppost);
	            try {
	                System.out.println("|---远程服务响应状态："+response.getStatusLine().getStatusCode());
	                HttpEntity entity = response.getEntity();
	                if (entity != null) {
	                    InputStream instream = entity.getContent();
	                    //处理响应结果.......
	                    try {
	                        instream.read();
	                    } catch (IOException ex) {

	                    } finally {
	                        instream.close();
	                    }
	                }
	            } finally {
	                response.close();
	            }
	        } finally {
	            httpclient.close();
	        }
	    }  
}
