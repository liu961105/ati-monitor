package com.dfmy.util;

import java.io.IOException;
import java.io.StringWriter;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.alibaba.fastjson.JSONPath;
import org.codehaus.jackson.JsonGenerationException;
import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.JsonParser.Feature;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.type.TypeReference;

import com.alibaba.fastjson.JSON;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

/**
 * 类名: JsonParser <br/>
 * 功能: json转换工具类. <br/>
 * 
 * @author jinl
 * @version
 * @since Jdk 1.7
 */
public class JsonParser {

	/**
	 * TODO将对象转换为json字符串
	 * 
	 * @param obj
	 * @return
	 */
	public static String objectToString(Object obj) {
		ObjectMapper mapper = new ObjectMapper();
		try {
			return mapper.writeValueAsString(obj);
		} catch (JsonGenerationException e) {

		} catch (JsonMappingException e) {

		} catch (IOException e) {

		}
		return "";
	}

	public static Object stringToObject(String obj, Class cls) {
		ObjectMapper mapper = new ObjectMapper();
		try {
			return mapper.readValue(obj, cls);
		} catch (JsonGenerationException e) {

		} catch (JsonMappingException e) {

		} catch (IOException e) {

		}
		return "";
	}

	public static <T> Object stringToObject(String obj, TypeReference<T> t) {
		ObjectMapper mapper = new ObjectMapper();
		try {
			return mapper.readValue(obj, t);
		} catch (JsonParseException e) {

		} catch (JsonMappingException e) {

		} catch (IOException e) {

		}
		return "";
	}

	private static final ObjectMapper MAPPER = new ObjectMapper();
	private static JsonParser jsonUtil = null;

	private JsonParser() {
	}

	public static JsonParser getInstance() {
		synchronized (JsonParser.class) {
			if (jsonUtil == null) {
				jsonUtil = new JsonParser();
			}
		}

		return jsonUtil;
	}

	public static String fromObject(Object obj) throws IOException,
			JsonGenerationException, JsonMappingException {
		StringWriter stringWriter = new StringWriter();
		MAPPER.writeValue(stringWriter, obj);
		return stringWriter.toString();
	}

	public static String fromListForData(List<?> list) throws IOException,
			JsonGenerationException, JsonMappingException {
		StringWriter stringWriter = new StringWriter();
		stringWriter.write("{data:[");
		for (int i = 0; i < list.size(); i++) {
			stringWriter.write(fromObject(list.get(i)));
			if (i != list.size() - 1) {
				stringWriter.write(",");
			}
		}
		stringWriter.write("]}");
		return stringWriter.toString();
	}

	public static List<?> toList(String json) throws IOException,
			JsonGenerationException, JsonMappingException {

		MAPPER.configure(Feature.ALLOW_SINGLE_QUOTES, true);
		return MAPPER.readValue(json, List.class);
	}

	public static Map<?, ?> toMap(String json) throws IOException,
			JsonGenerationException, JsonMappingException {
		MAPPER.configure(Feature.ALLOW_SINGLE_QUOTES, true);
		return MAPPER.readValue(json, Map.class);
	}

	public static Map<?, ?> toMap1(String json) throws Exception {
		MAPPER.configure(Feature.ALLOW_SINGLE_QUOTES, true);
		return MAPPER.readValue(json, Map.class);
	}

	/**
	 * 从Json字串中得到指定属性值
	 * 
	 * @param jsonStr
	 * @param proertyName
	 * @return
	 */
	public static Object getFromJson(String jsonStr, String proertyName) {
		Map map = new HashMap();
		try {
			map = JsonParser.getInstance().toMap(jsonStr);
		} catch (Exception e) {

		}
		return (Object) map.get(proertyName);
	}

	public Object json2Object(String json, Class clazz)
			throws JsonParseException, JsonMappingException, IOException {

		ObjectMapper mapper = new ObjectMapper();
		return mapper.readValue(json, clazz);
	}

	@SuppressWarnings("unchecked")
	public static Map ConvertObjToMap(Object obj) {
		Map<String, Object> reMap = new LinkedHashMap<String, Object>();
		if (obj == null)
			return null;
		Field[] fields = obj.getClass().getDeclaredFields();
		try {
			for (int i = 0; i < fields.length; i++) {
				try {
					Field f = obj.getClass().getDeclaredField(
							fields[i].getName());
					f.setAccessible(true);
					Object o = f.get(obj);
					reMap.put(fields[i].getName(), o);
				} catch (NoSuchFieldException e) {

					e.printStackTrace();
				} catch (IllegalArgumentException e) {

					e.printStackTrace();
				} catch (IllegalAccessException e) {

					e.printStackTrace();
				}
			}
		} catch (SecurityException e) {

			e.printStackTrace();
		}
		return reMap;
	}
	
	/***
	 * String字符串转换为List<Map>>
	 * @param tc
	 * @return
	 */
	public static List<Map<String, Object>> stringToList(String tc){
		JSONArray array = JSONArray.fromObject(tc);
		  List<Map<String, Object>> tcList = new ArrayList<Map<String, Object>>();
		    for (int i = 0; i < array.size(); i++) {
		        JSONObject jsonObject = array.getJSONObject(i);
		        Map<String, Object> map1 = new HashMap<String, Object>();
		        for (Iterator<?> iter = jsonObject.keys(); iter.hasNext(); ) {
		            String key = (String) iter.next();
		            String value = jsonObject.get(key).toString();
		            map1.put(key, value);
		        }
		        tcList.add(map1);
		    }
		return tcList; 		
	}
	
	 public static <T> List<T> readListValue(String json, Class<T> tClazz){
		return JSON.parseArray(json, tClazz);
	}

	/**
	 * https://github.com/alibaba/fastjson/wiki/JSONPath （jsonPath 语法链接）
	 * @param jsonPathKey
	 * @param jsonObject
	 * @param <V>
	 * @return
	 */
	public static  <V> V getJsonValueByJsonPath(String jsonPathKey,String jsonObject){
		JSONPath jsonPath = new JSONPath(jsonPathKey);
		return (V) jsonPath.eval(jsonObject);
	}
}

