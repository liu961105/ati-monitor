package com.dfmy.tool.other;

import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSON;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import com.google.gson.JsonPrimitive;
import com.google.gson.reflect.TypeToken;

import org.apache.commons.lang3.StringUtils;
/**
 * 模块功能：基于Gson的JSON处理工具类 
 * 创建人：wang 
 * 创建日期：2016年9月22日下午8:33:18
 */
public class JsonUtils {

	public static void main(String[] args) {

		//测试构建和解析Json对象
	/*	String test = "{\"A\":{\"A_1\":[{\"a\":\"01\"},{\"b\":\"02\"}]}}";
		  JsonParser parser = new JsonParser();
		  JsonObject object = (JsonObject) parser.parse(test);
		  JsonArray array = (JsonArray) ((JsonObject) object.get("A")).get("A_1");
		  JsonObject tem=new JsonObject();
		  tem.addProperty("c", "03");
		  array.add(tem);
		  //-------------------------------------
		  JsonElement jele=parser.parse(test);
		  object= jele.getAsJsonObject();
		  String back = array.toString();
		  System.out.println(back);*/
		/*List<Map<String,Object>> list;
		list=jsonToList("[{c:indexex_value,n:门诊人次,type:bar}]");
		System.out.println(list.get(0).get("t"));*/
	}
	 /**
     * 对象转化为json对象
     */
    public static String objectToJson(Object object) {
        if (object == null) {
            return "";
        }
        Gson gson;
        try {
            gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
            return gson.toJson(object);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }
    /**
     * json转化为对象
     */
    public static <T> T jsonToObject(String jsonData, Class<T> clazz) {
        if (StringUtils.isEmpty(jsonData)) {
            return null;
        }
        T finalResult = null;
        try {
            Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
            finalResult = gson.fromJson(jsonData, clazz);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return finalResult;
    }
	/**
	 * Json转化为List集合
	 */
	public static List jsonToList(String jsonData) {
		if (StringUtils.isEmpty(jsonData)) {
			return null;
		}
		List list = null;
		try {
			Type listType = new TypeToken<ArrayList>() {}.getType();
			Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
			list = gson.fromJson(jsonData, listType);
		} catch (Exception e) {
		}
		return list;
	}
	/**
     *json转化为Map
     */
    public static Map jsonToMap(String jsonData){
        if (StringUtils.isEmpty(jsonData)) {
            return null;
        }
        Map map = null;
        try {
            Type mapType = new TypeToken<Map>() { }.getType();
            Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd HH:mm:ss").create();
            map = gson.fromJson(jsonData, mapType);
        } catch (Exception e) {
        }
        return map;
    }
    

    public static <T> List<T> readListValue(String json, Class<T> tClazz){
		return JSON.parseArray(json, tClazz);
	}
}
