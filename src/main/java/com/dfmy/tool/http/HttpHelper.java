package com.dfmy.tool.http;

import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

/**
 * Http请求处理
 *
 */
public class HttpHelper {
	
	public static Map<String,Object> getRequestParams(HttpServletRequest request)
	{
		Map<String,Object> resultMap=new HashMap<String,Object>();
        Enumeration enu = request.getParameterNames();
        while(enu.hasMoreElements()){
            String name=(String)enu.nextElement();
            String value=request.getParameter(name);
            if(!value.equals("") && !value.equals("undefined") && !value.equals("null"))
            {
            	resultMap.put(name, value);
            }
        }
       	return resultMap;
	}
}
