package com.dfmy.controller.common;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Enumeration;

/**
 * 页面跳转路由
 *
 */
@Controller
@RequestMapping(value = "/route")
public class RouteController {
	/**
	 * @param path：文件夹
	 * @param page：页面
	 * @return
	 */
	@RequestMapping(value = "/{path}/{page}")
	public String path(@PathVariable String path,@PathVariable String page,HttpServletRequest request,
			HttpServletResponse response,String showRight,String showLocation,String index_no,Model model) {
		Enumeration<String> enumeration = request.getParameterNames();

		while (enumeration.hasMoreElements()){
			String paramName = enumeration.nextElement();
			model.addAttribute(paramName,request.getParameter(paramName));
		}
		return path+"/"+page;  
	}
	/**
	 * @param path：文件夹
	 * @param page：页面
	 * @return
	 */
	@RequestMapping(value = "/{path}/{subpath}/{page}")
	public String path(@PathVariable String path,@PathVariable String page,@PathVariable String subpath,HttpServletRequest request,
			HttpServletResponse response,String showRight,String showLocation,String index_no,Model model) {
		return path+"/"+subpath+"/"+page;  
	}
}
