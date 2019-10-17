package com.dfmy.tool.other;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;

/**
 * 模块功能：序列化反序列化工具
 * 创建人：wang 
 * 创建日期：2016年9月22日下午8:33:18
 */
public class SerializeUtil {

	/**
	 * 序列化为二进制
	 */
	public static byte[] serialize(Object obj) {

		ObjectOutputStream oos = null;
		ByteArrayOutputStream baos = null;
		try {
			// 序列化
			baos = new ByteArrayOutputStream();
			oos = new ObjectOutputStream(baos);
			oos.writeObject(obj);
			byte[] byteArray = baos.toByteArray();
			return byteArray;
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 序列化二进制后返回字符串
	 */
	public static String  serializeByteToString(Object obj) {

		ObjectOutputStream oos = null;
		ByteArrayOutputStream baos = null;
		try {
			// 序列化
			baos = new ByteArrayOutputStream();
			oos = new ObjectOutputStream(baos);
			oos.writeObject(obj);
			return baos.toString("ISO-8859-1");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 反序列化二进制
	 */
	public static Object unSerialize(byte[] bytes) {
		ByteArrayInputStream bais = null;
		try {
			// 反序列化为对象
			bais = new ByteArrayInputStream(bytes);
			ObjectInputStream ois = new ObjectInputStream(bais);
			return ois.readObject();

		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 二进制字符串反序列化为对象
	 */
	public static Object unSerialize(String  byteString) {
		ByteArrayInputStream bais = null;
		try {
			// 反序列化为对象
			bais = new ByteArrayInputStream(byteString.getBytes("ISO-8859-1"));
			ObjectInputStream ois = new ObjectInputStream(bais);
			return ois.readObject();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}
