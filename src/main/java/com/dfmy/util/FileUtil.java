package com.dfmy.util;

import java.io.File;

public class FileUtil {
	//创建文件夹
	public static File createFile(String basePath,String dateString){
		//动态创建文件夹
		File f = new File(basePath+dateString);
		//如果文件夹不存在就创建，文件夹存在不就创建。
		if(!f.exists()){
			f.mkdirs();
		}
		return f;
	}
}
