<%@ page language="java" pageEncoding="utf-8"%>
<%@include file="/WEB-INF/views/public/taglib.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>	
<head>
<title>Login</title>
<meta name="viewport" content="width=device-width,user-scalable=no,initial-scale=1.0,maximum-scale=1.0,minimum-scale=1.0">
<link href="${ctx}/res/css/style.css" rel='stylesheet' type='text/css' />
<style type="text/css">
.validate-tips {
	display:none;
}
</style>
</head>
<body>
 <!--SIGN UP-->
<div class="login-form">
	<div class="head-info">
		<h1>后台管理系统</h1>
	</div>
	<div class="clear"> </div>
	<div class="avtar">
		<img src="${ctx}/res/img/login/setting.png" />
	</div>
	<form id="sysLogin">
		<ul class="login-ul">
			<li class="icon-usename">
				<i></i><input name="userName"  class="validate require login-vdt" type="text" class="text" placeholder="请输入用户名" />
			</li>
			<li class="icon-password">
				<i></i><input name="password"  class="validate require login-vdt" type="password" placeholder="请输入密码" />
			</li>
			<li class="icon-identify">
				<i></i>
				<input type="text" name="kaptchaCode" class="validate require login-vdt" placeholder="请输入验证码" />
				<span><img  style="float: right;" alt="验证码" src="images/kaptcha.jpg" title="点击更换"  
                    id="img_captcha" onclick="javascript:refreshCaptcha();">(看不清<a href="javascript:void(0)" onclick="javascript:refreshCaptcha()">换一张</a>)</span>
			</li>
		</ul>
		<div class="signin">
			<input class="btn-login" type="button" id="loginbtn" value="登录"/>
		</div>
	</form>
</div>
    <%@include file="/WEB-INF/views/public/common.jspf"%>
	<script type="text/javascript">
	$(function(){
	    $(".qt-login-main").backstretch(["${ctx}/res/img/login/bj.jpg"]);
		$("#sysLogin").on('click',"#loginbtn",function(){
			loginSys();
		});
		
		//回车事件
	    $(document).keydown(function (event) {
			 if (event.keyCode == 13) {//回车键对应code值为13
				 loginSys();
		     }
		});
	})
	
	function refreshCaptcha(){  
		  document.getElementById("img_captcha").src="${ctx}/images/kaptcha.jpg?t=" + Math.random();  
	}
	
	function loginSys(){
		//表单校验
		var isTemp = $("#sysLogin").validateForm({
			msgPosition : 'right'
		});
		if (isTemp) {
			var my = {
					form : "sysLogin",
					url : "${ctx}/sysLogin",
					callback : function(res) {
						layer.msg(res.message);
						if(res.success == '1'){
							window.open(window.location.origin+"${ctx}/sysIndex","_self");
						}
					}
				}
			$._FormRequest(my);
		}
	}
	</script>
</body>
</html>