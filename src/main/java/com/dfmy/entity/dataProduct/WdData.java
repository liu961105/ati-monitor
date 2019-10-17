package com.dfmy.entity.dataProduct;
/**
 * 温度 湿度实体
 * @author LZN
 *
 */
public class WdData {
	private String gcmc;
	private String code;
	private String gcbw;
	private String jcyj;
	private String zyyqsb;
	private String sj;
	private String wd;
	private String sd;
	private String jcr;
	private String jlr;
	private String fhr;
	private String time;
	
	
	
	public WdData() {
		
	}
	
	public WdData(String gcmc, String code, String gcbw, String jcyj, String zyyqsb, String sj, String wd, String sd,
			String jcr, String jlr, String fhr, String time) {
		this.gcmc = gcmc;
		this.code = code;
		this.gcbw = gcbw;
		this.jcyj = jcyj;
		this.zyyqsb = zyyqsb;
		this.sj = sj;
		this.wd = wd;
		this.sd = sd;
		this.jcr = jcr;
		this.jlr = jlr;
		this.fhr = fhr;
		this.time = time;
	}

	public String getGcmc() {
		return gcmc;
	}
	public void setGcmc(String gcmc) {
		this.gcmc = gcmc;
	}
	public String getCode() {
		return code;
	}
	public void setCode(String code) {
		this.code = code;
	}
	public String getGcbw() {
		return gcbw;
	}
	public void setGcbw(String gcbw) {
		this.gcbw = gcbw;
	}
	public String getJcyj() {
		return jcyj;
	}
	public void setJcyj(String jcyj) {
		this.jcyj = jcyj;
	}
	public String getZyyqsb() {
		return zyyqsb;
	}
	public void setZyyqsb(String zyyqsb) {
		this.zyyqsb = zyyqsb;
	}
	public String getSj() {
		return sj;
	}
	public void setSj(String sj) {
		this.sj = sj;
	}
	public String getWd() {
		return wd;
	}
	public void setWd(String wd) {
		this.wd = wd;
	}
	public String getSd() {
		return sd;
	}
	public void setSd(String sd) {
		this.sd = sd;
	}
	public String getJcr() {
		return jcr;
	}
	public void setJcr(String jcr) {
		this.jcr = jcr;
	}
	public String getJlr() {
		return jlr;
	}
	public void setJlr(String jlr) {
		this.jlr = jlr;
	}
	public String getFhr() {
		return fhr;
	}
	public void setFhr(String fhr) {
		this.fhr = fhr;
	}
	public String getTime() {
		return time;
	}
	public void setTime(String time) {
		this.time = time;
	}
	
	
	
	
}
