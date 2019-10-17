package com.dfmy.realm;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authc.UnknownAccountException;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;

import com.dfmy.entity.sys.SysMenu;
import com.dfmy.entity.sys.SysRole;
import com.dfmy.entity.sys.SysUser;
import com.dfmy.service.sys.SysUserService;

/**
 * realm
 * 
 * @author zhangjl
 *
 */
public class MyRealm extends AuthorizingRealm {

	@Resource
	SysUserService sysUserService;

	/**
	 * 角色与权限
	 */
	@Override
	protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals){
		String userName = (String) principals.getPrimaryPrincipal();
		SysUser sysUser = sysUserService.findByUserName(userName);
		if (sysUser != null) {
			SimpleAuthorizationInfo authorizationInfo = new SimpleAuthorizationInfo();
			List<SysRole> roles = sysUser.getRoles();
			Set<String> roleIds = new HashSet<String>();
			Set<String> permissions = new HashSet<String>();
			for (SysRole role : roles) {
				// 获得角色
				roleIds.add(role.getName());
				// 获得权限
				List<SysMenu> memus = role.getMemus();
				for (SysMenu sysMenu : memus) {
					if(StringUtils.isNotBlank(sysMenu.getPermission())){
						permissions.add(sysMenu.getPermission());
					}
				}
			}
			// 设置角色
			authorizationInfo.setRoles(roleIds);
			authorizationInfo.setStringPermissions(permissions);
			return authorizationInfo;
		}else{
			return null;
		}
	}

	/**
	 * 认证登录
	 */
	@Override
	protected AuthenticationInfo doGetAuthenticationInfo(
			AuthenticationToken token) throws AuthenticationException {
		String userName = (String) token.getPrincipal();
		SysUser user = sysUserService.findByUserName(userName);
		if (user != null) {
			if (Boolean.TRUE.equals(user.getLocked())) {
				throw new LockedAccountException("账号已锁定"); // 帐号锁定
			} else {
				return new SimpleAuthenticationInfo(
						user.getUserName(), user.getPassword(), "xx");
			}
		}else{
			throw new UnknownAccountException();
		}
	}

}
