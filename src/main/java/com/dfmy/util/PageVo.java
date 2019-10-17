package com.dfmy.util;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class PageVo {
	private int number;//当前页数
	private List<Map<String, Object>> content= new ArrayList<Map<String, Object>>();
	private int size;//每页显示条数
	private long totalPages;//总页数
	private long totalElements;//总记录数
	
	
	public PageVo(int number, List<Map<String, Object>> dataList, int size, long totalPages,
			long totalElements) {
		this.number = number;
		this.content = dataList;
		this.size = size;
		this.totalPages = totalPages;
		this.totalElements = totalElements;
	}


	public int getNumber() {
		return number;
	}


	public void setNumber(int number) {
		this.number = number;
	}


	public List<Map<String, Object>> getContent() {
		return content;
	}


	public void setContent(List<Map<String, Object>> content) {
		this.content = content;
	}


	public long getSize() {
		return size;
	}


	public void setSize(int size) {
		this.size = size;
	}


	public long getTotalPages() {
		return totalPages;
	}


	public void setTotalPages(long totalPages) {
		this.totalPages = totalPages;
	}


	public long getTotalElements() {
		return totalElements;
	}


	public void setTotalElements(long totalElements) {
		this.totalElements = totalElements;
	}
	
	
	
	
}
