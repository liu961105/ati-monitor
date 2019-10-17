package com.dfmy.service.sys.impl;

import com.dfmy.entity.sys.SysUser;
import com.dfmy.service.sys.SysloginService;
import com.dfmy.tool.other.MD5;

/**
 * 用户登录管理
 * @author zhangjl
 *
 */
public class SysloginServiceImpl implements SysloginService {

	@Override
	public SysUser login(SysUser user) {
		MD5 m = new MD5();
		String Md5Pwd = m.getMD5ofStr(user.getPassword());
		return null;
	}

}
