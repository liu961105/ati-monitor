package com.dfmy.util;


public class PageUtils {
	
	public PageUtils(){
		
	}
	/**
	 * 
	 * @description 构造函数，方便初始化数据
	 * <p>TODO</p>
	 * @param pageNo 页码
	 * @param pageSize 条数
	 * @param orderField 排序字段
	 * @param orderSort  排序顺序
	 */
	public PageUtils(int pageNo,int pageSize,String orderField,String orderSort){
		this.pageNo=pageNo;
		this.pageSize=pageSize;
		this.orderField=orderField;
		this.orderSort=orderSort;
	}
	//-- 公共变量 --//
	public static final String ASC = "ASC";
	public static final String DESC = "DESC";
	//排序字段
	protected String orderField = null;
	//排序顺序
	protected String orderSort = null;
	//-- 分页参数 --//
	protected int pageNo = 1;
	protected int pageSize = 10;
	public int getPageNo() {
		return pageNo;
	}
	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public String getOrderField() {
		return orderField;
	}
	public void setOrderField(String orderField) {
		this.orderField = orderField;
	}
	public String getOrderSort() {
		return orderSort;
	}
	public void setOrderSort(String orderSort) {
		this.orderSort = orderSort;
	}
}
