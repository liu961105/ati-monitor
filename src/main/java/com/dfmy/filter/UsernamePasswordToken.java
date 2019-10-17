package com.dfmy.filter;


public class UsernamePasswordToken extends org.apache.shiro.authc.UsernamePasswordToken {

	private static final long serialVersionUID = 1L;

	private String captcha;

	public String getCaptcha() {
		return captcha;
	}

	public void setCaptcha(String captcha) {
		this.captcha = captcha;
	}

	public UsernamePasswordToken() {
		super();
	}

	public UsernamePasswordToken(String userName, char[] password,
			boolean rememberMe, String host, String captcha) {
		super(userName, password, rememberMe, host);
		this.captcha = captcha;
	}

} 
