package com.dfmy.controller.sys;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.dfmy.entity.ResultEntity;
import com.dfmy.entity.sys.SysBaseInfo;
import com.dfmy.service.sys.BaseInfoService;

/**
 * 基本信息配置表
 *
 */
@Controller
@RequestMapping("baseInfo")
public class BaseInfoController {
	private BaseInfoService baseInfoService;
	@RequestMapping("getDetail")
	public ResultEntity getDetail(){
		SysBaseInfo baseInfo = baseInfoService.getDetail();
		return null;
	}
}
