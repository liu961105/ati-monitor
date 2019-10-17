package com.dfmy.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("main")
public class MainController {
	
	@RequestMapping("/pageMain")
	public String getMainPage(){
		return "/manage/index";
	}
}
