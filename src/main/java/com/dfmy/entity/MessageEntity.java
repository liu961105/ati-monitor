package com.dfmy.entity;

import java.io.Serializable;

/**
 * 消息实体--用于组件之间的通信
 * 
 * @author wang
 */
public class MessageEntity implements Serializable {

	private static final long serialVersionUID = -5175178255179812101L;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getCreatDate() {
		return creatDate;
	}

	public void setCreatDate(String creatDate) {
		this.creatDate = creatDate;
	}

	public String getCreatUser() {
		return creatUser;
	}

	public void setCreatUser(String creatUser) {
		this.creatUser = creatUser;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	private String id;
	private String creatDate;
	private String creatUser;
	private String content;

	@Override
	public String toString() {
		
		return "id=" + id + ", creatDate=" + creatDate;
		
	}
}
