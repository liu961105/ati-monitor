package com.dfmy.entity.photo;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import org.hibernate.annotations.GenericGenerator;

/**
 * AtiPhoto entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "ati_photo")

public class AtiPhoto implements java.io.Serializable {

	// Fields

	private String id;
	private String typeId;
	private String url;
	private String projectId;
	private String realUrl;

	// Constructors

	/** default constructor */
	public AtiPhoto() {
	}

	/** full constructor */
	public AtiPhoto(String typeId, String url, String projectId,String realUrl) {
		this.typeId = typeId;
		this.url = url;
		this.projectId = projectId;
		this.realUrl =realUrl;
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

	@Column(name = "type_id")

	public String getTypeId() {
		return this.typeId;
	}

	public void setTypeId(String typeId) {
		this.typeId = typeId;
	}

	@Column(name = "url")

	public String getUrl() {
		return this.url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	@Column(name = "project_id")

	public String getProjectId() {
		return this.projectId;
	}

	public void setProjectId(String projectId) {
		this.projectId = projectId;
	}
    
	@Column(name = "real_url")
	public String getRealUrl() {
		return realUrl;
	}

	public void setRealUrl(String realUrl) {
		this.realUrl = realUrl;
	}
}