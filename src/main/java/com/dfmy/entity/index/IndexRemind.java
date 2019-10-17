package com.dfmy.entity.index;

import java.io.Serializable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;

/**
 * 事务提醒表
 * @author anix
 *
 */

@Entity
@Table(name="index_remind")
public class IndexRemind implements Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String remindId;
	private String name;//名称
	private String content;//内容
	private String source;//来源
	private String status;//状态
	
	private String createTime;//创建时间
	

	@Id
	@GeneratedValue(generator="system-uuid")
	@GenericGenerator(name="system-uuid", strategy="uuid.hex")
    @Column(name="id", nullable=false, length=50, scale=0)
	public String getRemindId() {
		return remindId;
	}
	public void setRemindId(String remindId) {
		this.remindId = remindId;
	}
	
	@Column(name="name")
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	@Column(name="content")
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	@Column(name="source")
	public String getSource() {
		return source;
	}
	public void setSource(String source) {
		this.source = source;
	}
	
	@Column(name="create_time",updatable=false)
	public String getCreateTime() {
		return createTime;
	}
	
	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

	@Column(name="status")
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	
	
	
	
	
}
