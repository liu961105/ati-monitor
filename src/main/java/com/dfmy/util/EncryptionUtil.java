package com.dfmy.util;

import org.apache.shiro.crypto.hash.Md5Hash;

/**
 * MD5不可逆密码加密
 *
 */
public class EncryptionUtil {
	/**
	 * MD5加密
	 * @param password
	 * @param salt
	 * @return 
	 */
	public static String Md5Hash(String password,String salt){
		return new Md5Hash(password,salt).toString();
	} 
	
	public static void main(String[] args) {
		System.out.println(EncryptionUtil.Md5Hash("111111", "gzgyy"));
	}
}
