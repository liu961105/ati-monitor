package com.dfmy.service.core;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.dfmy.tool.other.MD5;

@Service
public class LoginService {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	/**
	 * 用户登录
	 * @param userName
	 * @param password
	 * @return
	 */
	public Boolean login(String userName, String password) {
		MD5 m = new MD5();
		String Md5Pwd = m.getMD5ofStr(password);
		List<Map<String,Object>> userList = jdbcTemplate.queryForList("select t.USERNAME,t.PASSWORD FROM SYS_USER t WHERE t.USERNAME='"+userName+"' AND t.PASSWORD='"+Md5Pwd+"'");
		if(userList!=null && userList.size() == 1){
			return true;
		}else{
			return false;
		}
	}
	
}
