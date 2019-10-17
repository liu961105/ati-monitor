package com.dfmy.util;

import java.util.ResourceBundle;

public class PropertiesUtil {
	private static ResourceBundle resourceBundle;

    static {
        //properties文件的名称
        resourceBundle=ResourceBundle.getBundle("ApplicationResources");
    }

    public static String getVal(String key){
        return resourceBundle.getString(key);//文件中的key值
    }

}
