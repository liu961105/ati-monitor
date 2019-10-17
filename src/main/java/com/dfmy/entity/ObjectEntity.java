package com.dfmy.entity;

import java.util.List;

/**
 * 对象实体
 * @author wang
 */
public class ObjectEntity {
	
	private String pkId;//主键
	private String objectCn ;//对象中文名
	private String objectEn;//对象英文名
	private String tableName; //数据库表名
	private String pagePath; //前端页面路径
	private String sid;//对象属性键
	private List<AttributeEntity> attributes; //对象属性
	
	public String getSid() {
		return sid;
	}
	public void setSid(String sid) {
		this.sid = sid;
	}
	
	public List<AttributeEntity> getAttributes() {
		return attributes;
	}
	public void setAttributes(List<AttributeEntity> attributes) {
		this.attributes = attributes;
	}
	public String getPkId() {
		return pkId;
	}
	public void setPkId(String pkId) {
		this.pkId = pkId;
	}
	public String getObjectCn() {
		return objectCn;
	}
	public void setObjectCn(String objectCn) {
		this.objectCn = objectCn;
	}
	public String getObjectEn() {
		return objectEn;
	}
	public void setObjectEn(String objectEn) {
		this.objectEn = objectEn;
	}
	public String getTableName() {
		return tableName;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	public String getPagePath() {
		return pagePath;
	}
	public void setPagePath(String pagePath) {
		this.pagePath = pagePath;
	}
}
