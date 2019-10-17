<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/public/taglib.jspf"%>
<!-- 列表界面 -->

<style>
	.mainPage {
	position: absolute;
	left: -10px;
	top: 60px;
	right: 0;
	bottom: 0;
	margin: 20px;
	background-color: #fff;
	padding: 20px;
	overflow: auto;
}
.title-top{
    height: 18px;
    line-height: 18px;
    font-size: 18px;
    color: #0072ff;
    margin-bottom: 12px;
}
.title-icon{
    display: inline-block;
    background-size: 100% 100%;
    width: 20px;
    height: 16px;
    background:url("${ctx}/res/img/manage/title_icon.png");
}

.requied:before {
	content: "*";
	display: inline-block;
	margin-right: 4px;
	line-height: 1;
	font-family: SimSun;
	font-size: 12px;
	color: #f30;
}

</style>
<div id="data-list" class="app" style="margin-top:20px;margin-left: 10px;">
		<div class="top"> 
			<h3 class="title-top">
				<span class="title-icon"></span>
			 	<span >公司信息设置</span>
			 </h3>
		</div>

<div class="mainPage">
		<form id="form" class="layui-form"  style="border: 1px solid #ddd;border-color: #e3e8ee;height: 570px;;width: 100%;">
			<input type='hidden' name='companyId' value="${company.companyId}"> 
			<input type='hidden' name='createTime' value="${company.createTime}"> 
			<input type='hidden' name='state' value="${company.state}">
			<div class="layui-row" style="margin-top: 35px;">
				<div class="layui-col-xs6" >
					<label class="layui-form-label requied">公司名称：</label>
					<div class="layui-input-block">
						<input type="text" name="name"  value="${company.name}" lay-verify="required" placeholder="请输入公司名称" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-col-xs6" >
					<label class="layui-form-label requied">公司简称：</label>
					<div class="layui-input-block">
						<input type="text" name="shorterForm"  value="${company.shorterForm}" lay-verify="required" placeholder="请输入公司简称" autocomplete="off" class="layui-input">
					</div>
				</div>
			</div>
			
			<div class="layui-row" style="margin-top: 35px;">
				<div class="layui-col-xs6" >
					<label class="layui-form-label requied">公司纳税登记号：</label>
					<div class="layui-input-block">
						<input type="text" name="taxNum"  value="${company.taxNum}" lay-verify="required" placeholder="请输入公司纳税登记号" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-col-xs6" >
					<label class="layui-form-label requied">公司法人姓名：</label>
					<div class="layui-input-block">
						<input type="text" name="legalPersonName"  value="${company.legalPersonName}" lay-verify="required" placeholder="请输入公司法人姓名" autocomplete="off" class="layui-input">
					</div>
				</div>
			</div>
			
			
			<div class="layui-row" style="margin-top: 35px;">
				<div class="layui-col-xs6" >
					<label class="layui-form-label requied">公司法人电话：</label>
					<div class="layui-input-block">
						<input type="text" name="legalPersonTel"  value="${company.legalPersonTel}" lay-verify="required" placeholder="请输入公司法人电话" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-col-xs6" >
					<label class="layui-form-label requied">公司法人住址：</label>
					<div class="layui-input-block">
						<input type="text" name="legalPersonAddr"  value="${company.legalPersonAddr}" lay-verify="required" placeholder="请输入公司法人住址" autocomplete="off" class="layui-input">
					</div>
				</div>
			</div>
			
			<div class="layui-row" style="margin-top: 35px;">
				<div class="layui-col-xs6" >
					<label class="layui-form-label requied">公司法人邮箱：</label>
					<div class="layui-input-block">
						<input type="text" name="legalPersonEmail"  value="${company.legalPersonEmail}" lay-verify="required" placeholder="请输入公司法人邮箱" autocomplete="off" class="layui-input">
					</div>
				</div>
				<div class="layui-col-xs6" >
					<label class="layui-form-label requied">公司简介：</label>
					<div class="layui-input-block">
						<textarea  name="briefIntroduction"  lay-verify="required" placeholder="公司简介" autocomplete="off" class="layui-textarea">${company.briefIntroduction}</textarea>
					</div>
				</div>
			</div>
			
		<div  class="layui-input-block" style="padding-right: 38px; text-align: center; margin-top: 100px;">
			<button id="btn_save" lay-submit="" lay-filter="formDemo" class="layui-btn">
				保存</button>
		</div>
		</form>


		</div>
	</div>
<!--end新增与详情页面-->
<script src="${ctx}/res/js/main.js"></script>
<script type="text/javascript">
$(function(){
	layui.use('form', function(){
  var form = layui.form;
  
  //监听提交
  form.on('submit(formDemo)', function(data){
  	$.ajax({
  		url:'${ctx}/company/saveCompany',
  		data:$("#form").serialize(),
  		dataType:'json',
  		success:function(res){
	  		if(res.success=='1'){
	  			showOkTip("保存成功");
	  		}else{
	  			showErrorTip(res.message);
	  		}
  		}
  	});
    return false;
  });
});
	
});
</script>
