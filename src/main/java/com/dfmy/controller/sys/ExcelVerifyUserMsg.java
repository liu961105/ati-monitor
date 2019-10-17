package com.dfmy.controller.sys;

import org.jeecgframework.poi.excel.entity.result.ExcelVerifyHanlderResult;
import org.jeecgframework.poi.handler.inter.IExcelVerifyHandler;

import com.dfmy.util.StringHelper;

public class ExcelVerifyUserMsg implements IExcelVerifyHandler<UserImport>{

	@Override
	public ExcelVerifyHanlderResult verifyHandler(UserImport u) {
		
		StringBuilder builder = new StringBuilder();
		
		/*{"序号","工号（必填项）","真实姓名（必填项）","性别（必填项）","手机号码（必填项）","出生日期（必填项）","身份证号（必填项）","紧急联系人（必填项）","岗位（必填项）","入职日期（必填项）",
        "是否缴纳社保（必填项）","是否缴纳公积金（必填项）","劳动合同签订日期（必填项）","劳动合同到期时间（必填项）","合同签订次数（必填项）",
        "毕业院校","专业","毕业时间","学历","职称","是否党员（必填项）","是否团员（必填项）",
        "在岗/离职状态（必填项）","离职原因","离职时间","备注"}*/
		
		if(!StringHelper.isNotBlack(u.getGh())){
			builder.append("工号不能为空！");
		}
		if(!StringHelper.isNotBlack(u.getYhm())){
			builder.append("姓名不能为空！");
		}
		if(!StringHelper.isNotBlack(u.getXb())){
			builder.append("性别不能为空！");
		}
		if(!StringHelper.isNotBlack(u.getCsrq())){
			builder.append("出生日期不能为空！");
		}
		if(!StringHelper.isNotBlack(u.getLxdh())){
			builder.append("联系电话不能为空！");
		}
		if(!StringHelper.isNotBlack(u.getGw())){
			builder.append("岗位不能为空！");
		}
		if(!StringHelper.isNotBlack(u.getRzsj())){
			builder.append("入职时间不能为空！");
		}
		if(!StringHelper.isNotBlack(u.getSfz())){
			builder.append("身份证号不能为空！");
		}
		if(!StringHelper.isNotBlack(u.getJjlxr())){
			builder.append("紧急联系人不能为空！");
		}
		
		/*if(!StringHelper.isNotBlack(u.getSb())){
			builder.append("是否缴纳社保不能为空！");
		}
		if(!StringHelper.isNotBlack(u.getGjj())){
			builder.append("是否缴纳公积金不能为空！");
		}*/
		
		/*if(!StringHelper.isNotBlack(u.getHtq())){
			builder.append("劳动合同签订日期不能为空！");
		}
		if(!StringHelper.isNotBlack(u.getHtz())){
			builder.append("劳动合同到期时间不能为空！");
		}
		if(!StringHelper.isNotBlack(u.getHtlx())){
			builder.append("合同类型不能为空！");
		}*/
		
		/*if(!StringHelper.isNotBlack(u.getSfdy())){
			builder.append("是否党员不能为空！");
		}
		*/

		/*if(!StringHelper.isNotBlack(u.getXl())){
			builder.append("学历不能为空！");
		}
		if(!StringHelper.isNotBlack(u.getZy())){
			builder.append("专业不能为空！");
		}
		    *******
		*/
		return new ExcelVerifyHanlderResult(false, builder.toString());
	}

}
