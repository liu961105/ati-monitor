package com.dfmy.entity.index;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import org.hibernate.annotations.GenericGenerator;

/**
 * AtiMonitorMedia entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "ati_monitor_media", catalog = "ati_monitor")

public class AtiMonitorMedia implements java.io.Serializable {

	// Fields

	private String id;
	private String projectId;
	private String type;
	private String url;
	private String realUrl;
	private String createTime;

	// Constructors

	/** default constructor */
	public AtiMonitorMedia() {
	}

	/** full constructor */
	public AtiMonitorMedia(String projectId, String type, String url, String realUrl,String createTime) {
		this.projectId = projectId;
		this.type = type;
		this.url = url;
		this.realUrl = realUrl;
		this.createTime =createTime;
	}

	

	// Property accessors
	@GenericGenerator(name = "generator", strategy = "uuid.hex")
	@Id
	@GeneratedValue(generator = "generator")

	@Column(name = "id", unique = true, nullable = false, length = 32)

	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
	}

	@Column(name = "project_id", length = 64)

	public String getProjectId() {
		return this.projectId;
	}

	public void setProjectId(String projectId) {
		this.projectId = projectId;
	}

	@Column(name = "type", length = 32)

	public String getType() {
		return this.type;
	}

	public void setType(String type) {
		this.type = type;
	}

	@Column(name = "url", length = 64)

	public String getUrl() {
		return this.url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	@Column(name = "real_url", length = 64)

	public String getRealUrl() {
		return this.realUrl;
	}

	public void setRealUrl(String realUrl) {
		this.realUrl = realUrl;
	}
	
	@Column(name = "create_time", length = 32)
	
	public String getCreateTime() {
		return createTime;
	}

	public void setCreateTime(String createTime) {
		this.createTime = createTime;
	}

}