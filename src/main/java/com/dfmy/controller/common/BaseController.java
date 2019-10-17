/**
 * @author zhangjl
 */
package com.dfmy.controller.common;

public class BaseController{
	
		//{{ 请求响应标识常量

	public final String  ERROR="0";
	public final String  SUCCESS="1";
	public final String  NULL="2";

	public final String  OPERATE_SUCCESS="操作成功";
	public final String  OPERATE_ERROR="操作失败";
	
	public final String  ADD_SUCCESS="添加成功";
	public final String  ADD_ERROR="添加失败";

	public final String  UPDATE_SUCCESS="更新成功";
	public final String  UPDATE_ERROR="更新失败";

	public final String  DELETE_SUCCESS="删除成功";
	public final String  DELETE_ERROR="删除失败";

	public final String  GET_SUCCESS="获取信息成功";
	public final String  GET_ERROR="获取信息失败";
	public static final String IS_NULL="暂无数据";
	public final String  QUERY="查询";
	public final String  ADD="添加";
	public final String  EDIT="更新";
	public final String  DELETE="删除";

	public final String  REFERER="*";//跨域范围识别
	
	//}}

	public final int PAGESIZE = 10;
	
}