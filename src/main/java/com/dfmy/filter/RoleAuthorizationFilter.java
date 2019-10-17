package com.dfmy.filter;

import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.subject.Subject;
import org.apache.shiro.web.filter.authz.AuthorizationFilter;

public class RoleAuthorizationFilter extends AuthorizationFilter {  
  
    @Override  
    protected boolean isAccessAllowed(ServletRequest request,  
            ServletResponse response, Object object) throws Exception {  
        // 获取请求的资源（即请求的URI）  
        HttpServletRequest httpReq = (HttpServletRequest) request;  
        String uri = httpReq.getRequestURI();  
          
        //根据请求响应获取已登录的Subject对象。  
        Subject subject = getSubject(request, response);  
          
        // 判断登录的用户是否有此权限  
        return subject.isPermitted(uri);  
    }  

}
