package com.dfmy.util;

import java.io.InputStream;
import java.util.Properties;
import java.util.PropertyResourceBundle;
import java.util.ResourceBundle;
/**
 *
 * 读入配置文件
 */
public final class ReadProperties {

	private Properties properties;
	
	public ReadProperties(String fileName){
		properties = new Properties();
		InputStream stream =
			ReadProperties.class.getResourceAsStream(fileName);
		try {
			properties.load(stream);
		} catch (Exception e) {

		}
		properties.putAll(System.getProperties());
	}

	/**
	 * @param filename :文件名称
	 * @return PropertyResourceBundle
	 * 取得文件
	 */
	private PropertyResourceBundle getFile(String filename) {

		return (PropertyResourceBundle) ResourceBundle.getBundle(filename);
	}
	/**
	 * @param propertyName :对象名称
	 * @param filename :文件名称
	 * @return 对象值
	 * 取得配置文件的对象值
	 */
	private String getProperty(String propertyName, String filename) {

		return getFile(filename).getString(propertyName);

	}


	/**
	 * @param propertyName :对象名称
	 * @return 对象值
	 * 取得配置文件的对象值
	 */
	public Object getProperty(String propertyName) {
		Object result= properties.get(propertyName);
		return result;
	}

	public static void main(String args[]) {
		ReadProperties rp = new ReadProperties("/ApplicationResources.properties");

		System.out.println(rp.getProperty("fromPassword").toString());
	}
}
