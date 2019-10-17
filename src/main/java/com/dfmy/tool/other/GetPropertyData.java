/** 获得配置文件信息
 * @author wang
 *
 */
package com.dfmy.tool.other;

import java.io.InputStream;
import java.util.Properties;

public class GetPropertyData {

	public static String getProperty(String name)
	{
		Properties prop = new Properties();
		String value="";
		try {
			InputStream stream = Thread.currentThread().getContextClassLoader().getResourceAsStream("comm.properties");
		        if(stream!=null )
		        {
		        	 prop.load(stream);
				     value =prop.getProperty(name);
		        }
		        stream.close();
		       
		} catch (Exception e) {
			   e.printStackTrace();
		}
	    return value;
	}
}
