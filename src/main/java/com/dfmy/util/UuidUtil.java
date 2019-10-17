package com.dfmy.util;

import java.util.UUID;

public class UuidUtil {

	/**
	 * 去除减号获取uuid
	 * @return
	 */
	public static String getUUIDNoMinus(){
		return UUID.randomUUID().toString().replaceAll("-","");
	}
	
	public static String getUUID(){
		return UUID.randomUUID().toString();
	}
	
	/**
	 * 生成指定位数的随机字符串
	 *
	 * @param len
	 * @return
	 */
	public static String generateRandomStr(int len) {
	    //字符源，可以根据需要删减
	    String generateSource = "0123456789abcdefghigklmnopqrstuvwxyz";
	    String rtnStr = "";
	    for (int i = 0; i < len; i++) {
	        //循环随机获得当次字符，并移走选出的字符
	        String nowStr = String.valueOf(generateSource.charAt((int) Math.floor(Math.random() * generateSource.length())));
	        rtnStr += nowStr;
	        generateSource = generateSource.replaceAll(nowStr, "");
	    }
	    return rtnStr;
	}
	
	public static void main(String[] args) {
		for(int i =0;i<10;i++){
			System.out.println(generateRandomStr(8));
			System.out.println(getUUIDNoMinus());
		}
	}
}
