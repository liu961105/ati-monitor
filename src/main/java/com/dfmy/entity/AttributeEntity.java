package com.dfmy.entity;

/**
 * 对象属性实体
 * @author wang
 */
public class AttributeEntity {
	
	private String pkID;//主键
	private String fKObject;//所属对象
	private String nameCn;//中文名
	private String nameEn;//英文名
	private String columnName;//数据库字段名
	private String columnType;//数据库字段类型
	private String columnSize;//数据库字段大小
	private Object value;//属性值
	private boolean isSystemField; //是否系统字段
	
	public boolean isSystemField() {
		return isSystemField;
	}
	public void setSystemField(boolean isSystemField) {
		this.isSystemField = isSystemField;
	}
	public Object getValue() {
		return value;
	}
	public void setValue(Object value) {
		this.value = value;
	}
	public String getPkID() {
		return pkID;
	}
	public void setPkID(String pkID) {
		this.pkID = pkID;
	}
	public String getfKObject() {
		return fKObject;
	}
	public void setfKObject(String fKObject) {
		this.fKObject = fKObject;
	}
	public String getNameCn() {
		return nameCn;
	}
	public void setNameCn(String nameCn) {
		this.nameCn = nameCn;
	}
	public String getNameEn() {
		return nameEn;
	}
	public void setNameEn(String nameEn) {
		this.nameEn = nameEn;
	}
	public String getColumnName() {
		return columnName;
	}
	public void setColumnName(String columnName) {
		this.columnName = columnName;
	}
	public String getColumnType() {
		return columnType;
	}
	public void setColumnType(String columnType) {
		this.columnType = columnType;
	}
	public String getColumnSize() {
		return columnSize;
	}
	public void setColumnSize(String columnSize) {
		this.columnSize = columnSize;
	}
}
