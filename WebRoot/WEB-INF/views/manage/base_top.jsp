<%@ page language="java" pageEncoding="utf-8"%>
<%@include file="/WEB-INF/views/public/taglib.jspf"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="multipart/form-data; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="user-scalable=no,initial-scale=1,maximum-scale=1,minimum-scale=1">
<link rel="stylesheet" href="${ctx}/res/css/manage/gyy-bi.css?7">
<link rel="stylesheet" href="${ctx}/res/css/manage/iconfont.css?4">
<link rel="stylesheet" href="${ctx}/res/ztree/css/zTreeStyle/zTreeStyle.css?2">
<link rel="stylesheet" href="${ctx}/res/js/lib/layui/css/layui.css">
<title>后台管理系统</title>
<style type="text/css">
.layui-layout-admin .layui-header {
	background-color: #384158;
	cursor:pointer;
}

.layui-layout-admin .layui-logo {
	color: #ffffff;
	font-weight: 400;
	font-size: 25px;
	text-align:left;
	display: inline-block;
	background-size: 23%;
}

.layui-nav-tree .layui-nav-child dd.layui-this, .layui-nav-tree .layui-nav-child dd.layui-this a,
	.layui-nav-tree .layui-this, .layui-nav-tree .layui-this>a,
	.layui-nav-tree .layui-this>a:hover {
	background-color: #516a88 !important;
	color: #fff;
}

.layui-nav-tree .layui-nav-child a {
	color: #fff;
}

.layui-nav-tree a cite {
	margin-left: 7px;
}

.layui-nav-tree .layui-nav-bar {
	background-color: #516a88;
}

.layui-nav-down {
	top: 20px;
	right: 10px;
	margin: 0;
}

.layui-nav-down {
	content: '';
	width: 0;
	height: 0;
	border-style: dashed;
	border-color: transparent;
	overflow: hidden;
	cursor: pointer;
	transition: all .2s;
	-webkit-transition: all .2s;
}

.layui-nav-down {
	position: absolute;
	border-width: 6px;
	border-top-style: solid;
	border-top-color: #fff;
	border-top-color: rgba(255, 255, 255, .7);
}

.layui-nav .layui-nav-child dd {
	padding-left: 22px;
}

.fa {
	margin-right: 5px;
	line-height: 35px !important;
}

#menuLeft .layui-nav-item.active {
	background: #5d616f;
}

a:hover {
	text-decoration-line: none;
}
.layui-layout-admin .layui-body {
    top: 60px;
    bottom: 0;
}
.layui-layout-admin .layui-body {
    bottom: 0;
}
.layui-table {
    background: #172147;
    color: aliceblue;
}
.layui-table tbody tr:hover, .layui-table thead tr, .layui-table-click, .layui-table-header, .layui-table-hover, .layui-table-mend, .layui-table-patch, .layui-table-tool, .layui-table-total, .layui-table-total tr, .layui-table[lay-even] tr:nth-child(even) {
    background-color: #24336a;
}
.layui-table td {
	border-color: #51697e;
}
.first-title {
	height: 60px;
    line-height: 60px;
    padding-left: 20px;
}
.second-title {
    height: 50px;
    line-height: 50px;
    font-size: 20px;
    font-weight: 100;
    left: 40vw;
    color: #dae0fd;
    margin: 0px auto;
    width: 30%;
    text-align: center;
    padding-top: 8px;
}
.layui-side-scroll{
    width: 200px;
    position: relative;
}
.layui-side-scroll .contract-btn {
	position: absolute;
    bottom: 15px;
    width: 100%;
    padding-left: 40px;
    cursor:pointer;
}
.spread-btn {
	position: absolute;
    bottom: 15px;
    left: 0px;
    width: 25px;
    height: 45px;
    line-height: 45px;
    padding-left: 4px;
    cursor: pointer;
    color: #fff;
    background: #7abdf77a;
    border-radius: 0px 3px 3px 0px;
    display:none;
}
</style>
</head>
<body class="layui-layout-body">
	<div class="layui-layout layui-layout-admin">
		<div class="layui-header">
			<input type="hidden" id="flagProjectId"/>
			<input type="hidden" id="structureId" value="${structureId}"/>
			<input type="hidden" id="strucTypeCode" value="${strucTypeCode}"/>
			<input type="hidden" id="strucTypeName" value="${strucTypeName}"/>
			<div class="layui-logo">
				<p class="first-title">${strucTypeName}管理系统</p>
			</div>
			<!-- 头部区域（可配合layui已有的水平导航） -->
			<ul id="menuTop" class="layui-nav layui-layout-left">
				<li class="layui-nav-item layui-this"><a href="">系统控制台</a></li>
			</ul>
			<div class="second-title"></div>
			<ul id="menuTopRight" class="layui-nav layui-layout-right" style="right:220px;">
				<!-- <li class="layui-nav-item" data-id="123"><a>首页</a></li> -->
			</ul>
			<ul class="layui-nav layui-layout-right">
				<li class="layui-nav-item">
					<a>
						<img id="userCover" src="${ctx}/res/img/userImg/cover000.jpg" class="layui-nav-img">
						<span id="user"><shiro:principal /></span> <%-- <span id="user">${sessionScope.userName}</span> --%>
					</a>
					<dl class="layui-nav-child">
						<shiro:hasPermission name="sysUser:updatePassword">
							<dd>
								<a id="updatePass">修改密码</a>
							</dd>
						</shiro:hasPermission>
						<dd>
							<a title="个人中心" id="user_center">个人中心</a>
						</dd>
						<!-- <dd><a href="">基本资料</a></dd>
						<dd><a href="">安全设置</a></dd> -->
					</dl></li>
				<li class="layui-nav-item"><a id="exit">退出</a></li>
			</ul>
		</div>

		<div id="menu_l" class="layui-side layui-bg-black" style="width:0px;">
			<div class="layui-side-scroll">
				<!-- 左侧导航区域（可配合layui已有的垂直导航） -->
				<ul id="menuLeft" class="layui-nav layui-nav-tree">
					<li class="layui-nav-item"><a href="javascript:;"
						lay-tips="主页" lay-direction="2"> <!-- <i class="layui-icon layui-icon-home"></i> -->
							<cite>主页</cite> <span class="layui-nav-more"></span>
					</a>
						<dl class="layui-nav-child">
							<dd class="layui-this">
								<a lay-href="home/console.html">控制台</a>
							</dd>
						</dl></li>
					<li class="layui-nav-item layui-nav-itemed"><a
						href="javascript:;"> <!-- <i class="layui-icon layui-icon-component"></i> -->
							<span class="layui-nav-more"></span> <cite>组件</cite>
					</a>
						<dl class="layui-nav-child">
							<dd>
								<a href="javascript:;">栅格<span class="layui-nav-more"></span></a>
								<dl class="layui-nav-child">
									<dd>
										<a lay-href="component/grid/list.html">等比例列表排列</a>
									</dd>
									<dd>
										<a lay-href="component/grid/mobile.html">按移动端排列</a>
									</dd>
								</dl>
							</dd>
							<dd>
								<a lay-href="component/button/index.html">按钮</a>
							</dd>
						</dl></li>
					<!-- <li class="layui-nav-item"><a class="" href="javascript:;">所有商品</a>
						<dl class="layui-nav-child">
							<dd><a href="javascript:;">列表一</a></dd>
							<dd><a href="javascript:;">列表二</a></dd>
							<dd><a href="javascript:;">列表三</a></dd>
							<dd><a href="">超链接</a></dd>
						</dl>
					</li>
					<li class="layui-nav-item layui-nav-itemed"><a href="javascript:;">解决方案</a>
						<dl class="layui-nav-child">
							<dd><a href="javascript:;">列表一</a></dd>
							<dd><a href="javascript:;">列表二</a></dd>
							<dd><a href="">超链接</a></dd>
						</dl>
					</li>
					<li class="layui-nav-item"><a href="">云市场</a></li>
					<li class="layui-nav-item"><a href="">发布商品</a></li> -->
				</ul>
				<div class="contract-btn">
					<span>&lt;&lt; 点击收缩</span>
				</div>
			</div>
		</div>

		<div class="layui-body mainCont" style="left:0px;background: #171939;">
			<div class="main">
				<ul class="bread-dis fn-clear">
					<li><i class="iconfont icon-home base-blue"></i> <span>我的项目</span></li>
					<li style="display:none;"><em>&gt;</em><span>首页</span></li>
					<li class="base-blue-01" style="display:none;"><em>&gt;</em><span></span></li>
				</ul>
			</div>
			<!-- 内容主体区域 -->
			<div class="data-content">内容主体区域</div>
			<div class="spread-btn">
				<span>&gt;&gt;</span>
			</div>
		</div>

		<!-- <div class="layui-footer">
			//底部固定区域
			© layui.com - 底部固定区域
		</div> -->
	</div>
	<div id="user-form" class="data-form" data-title='修改密码'>
		<form id="userForm">
			<table class="base-table form">
				<input type='hidden' name='userId'>
				<tr>
					<td width="150">原密码</td>
					<td><input name="password" id="password" type="password"
						class="base-input validate require"> <input
						name="userName" type="hidden" class="base-input"
						value='<shiro:principal/>'></td>
				</tr>
				<tr>
					<td width="150">新密码</td>
					<td><input name="password1" type="password" id="password1"
						class="base-input validate require" data-exp="w{2-20}"></td>
				</tr>
			</table>
		</form>
		<div class="toolbar buttom-btn">
			<button id="pass-save" type="button" class="base-btn base-bg-blue">保存</button>
		</div>
	</div>
	<div style="display: none;" id="user_center_panel">
		<form id="center_form" class="layui-form-pane userSaveForm">
			<input type='hidden' name='userId'>
			<div class="layui-row">
				<div class="layui-col-md4">
					<div class="layui-form-item">
						<label class="layui-form-label">登录用户名</label>
						<div class="layui-input-block">
							<input name="userName" class="layui-input validate require admin">
						</div>
					</div>
				</div>
				<div class="layui-col-md4">
					<div class="layui-form-item">
						<label class="layui-form-label">真实姓名</label>
						<div class="layui-input-block">
							<input name="rolename" class="layui-input validate require admin">
						</div>
					</div>
				</div>
				<div class="layui-col-md4">
					<div class="layui-form-item">
						<label class="layui-form-label">性别</label>
						<div class="layui-input-block">
							<select class="base-select validate require admin project"  name="sex">
								<option value="男">男</option>
								<option value="女">女</option>
							</select>
						</div>
					</div>
				</div>
			</div>
			<div class="layui-row">
				<div class="layui-col-md4">
					<div class="layui-form-item">
						<label class="layui-form-label">出生日期</label>
						<div class="layui-input-block">
							<input name="brithday" class="layui-input validate admin project" onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})">
						</div>
					</div>
				</div>
				<div class="layui-col-md4">
					<div class="layui-form-item">
						<label class="layui-form-label">民族</label>
						<div class="layui-input-block">
							<input name="minority" class="layui-input validate require admin project">
						</div>
					</div>
				</div>
				<div class="layui-col-md4">
					<div class="layui-form-item">
						<label class="layui-form-label">身份证号码</label>
						<div class="layui-input-block">
							<input name="idcardno" class="layui-input validate admin project">
						</div>
					</div>
				</div>
			</div>
			<div class="layui-row">
				<div class="layui-col-md4">
					<div class="layui-form-item">
						<label class="layui-form-label">户籍地址</label>
						<div class="layui-input-block">
							<input name="domicile" class="layui-input validate admin project">
						</div>
					</div>
				</div>
				<div class="layui-col-md4">
					<div class="layui-form-item">
						<label class="layui-form-label">手机号码</label>
						<div class="layui-input-block">
							<input name="phoneNum" class="layui-input validate require admin">
						</div>
					</div>
				</div>
				<div class="layui-col-md4">
					<div class="layui-form-item">
						<label class="layui-form-label">婚姻状况</label>
						<div class="layui-input-block">
							<select class="base-select admin project"  name="marStatus">
								<option value="">请选择</option>
								<option value="未婚">未婚</option>
								<option value="已婚">已婚</option>
							</select>
						</div>
					</div>
				</div>
			</div>
			<div class="layui-row">
				<div class="layui-col-md4">
					<div class="layui-form-item">
						<label class="layui-form-label">政治面貌</label>
						<div class="layui-input-block">
							<input name="isMember" class="layui-input validate admin project">
						</div>
					</div>
				</div>
				<div class="layui-col-md4">
					<div class="layui-form-item">
						<label class="layui-form-label">拥有角色</label>
						<div class="layui-input-block">
							<select class="base-select validate require roleIds admin" disabled="disabled" id="roleIds" name="roleIds">
								<option value="">请选择</option>
							</select>
						</div>
					</div>
				</div>
				<div class="layui-col-md4">
					<div class="layui-form-item">
						<label class="layui-form-label">邮箱</label>
						<div class="layui-input-block">
							<input name="email" class="layui-input validate admin project">
						</div>
					</div>
				</div>
			</div>
			<div class="layui-row">
				<div class="layui-col-md4">
					<div class="layui-form-item">
						<label class="layui-form-label">毕业院校</label>
						<div class="layui-input-block">
							<input name="graduateSchool" class="layui-input validate admin project">
						</div>
					</div>
				</div>
				<div class="layui-col-md4">
					<div class="layui-form-item">
						<label class="layui-form-label">毕业时间</label>
						<div class="layui-input-block">
							<input name="graduateTime" class="layui-input validate admin project" onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})">
						</div>
					</div>
				</div>
				<div class="layui-col-md4">
					<div class="layui-form-item">
						<label class="layui-form-label">学历</label>
						<div class="layui-input-block">
							<select class="base-select admin project"  name="education">
								<option value="">请选择</option>
								<option value="小学">小学</option>
								<option value="初中">初中</option>
								<option value="高中">高中</option>
								<option value="中专">中专</option>
								<option value="大专">大专</option>
								<option value="本科">本科</option>
								<option value="硕士">硕士</option>
								<option value="博士">博士</option>
								<option value="博士后">博士后</option>
							</select>
						</div>
					</div>
				</div>
			</div>
			<div class="layui-row">
				<div class="layui-col-md4">
					<div class="layui-form-item">
						<label class="layui-form-label">紧急联系人</label>
						<div class="layui-input-block">
							<input name="linkman" class="layui-input validate admin project">
						</div>
					</div>
				</div>
				<div class="layui-col-md4">
					<div class="layui-form-item">
						<label class="layui-form-label">关系</label>
						<div class="layui-input-block">
							<input name="linkmanRtp" class="layui-input validate admin project">
						</div>
					</div>
				</div>
				<div class="layui-col-md4">
					<div class="layui-form-item">
						<label class="layui-form-label">联系人电话</label>
						<div class="layui-input-block">
							<input name="linkmanPhone" class="layui-input validate admin project">
						</div>
					</div>
				</div>
			</div>
			<div class="layui-row">

				<div class="layui-col-md4">
					<div class="layui-form-item">
						<label class="layui-form-label">所属部门</label>
						<div class="layui-input-block">
							<select class="base-select sysDeptIds admin" disabled="disabled"  name="sysDeptIds" id="sysDeptIds">
								<option value="">请选择</option>
							</select>
						</div>
					</div>
				</div>
				<div class="layui-col-md4">
					<div class="layui-form-item">
						<label class="layui-form-label">岗位</label>
						<div class="layui-input-block">
							<select class="base-select postId admin" id="postId">
								<option value="">请选择</option>
							</select>
						</div>
					</div>
				</div>
				<div class="layui-col-md4">
					<div class="layui-form-item">
						<label class="layui-form-label">入职日期</label>
						<div class="layui-input-block">
							<input name="joindate" class="layui-input validate admin project" onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})">
						</div>
					</div>
				</div>
			</div>
			<div class="layui-row">
				<div class="layui-col-md4">
					<div class="layui-form-item">
						<label class="layui-form-label">qq号码</label>
						<div class="layui-input-block">
							<input name="qqNo" class="layui-input validate admin project">
						</div>
					</div>
				</div>
				<div class="layui-col-md4">
					<div class="layui-form-item">
						<label class="layui-form-label">单位名称</label>
						<div class="layui-input-block">
							<input name="companyName" class="layui-input validate admin project">
						</div>
					</div>
				</div>
				<div id="user_content_btn" class="layui-col-md4">
					<!-- data-state:edit or readonly  -->
					<button type="button" id="editBtn" data-state="edit" class="layui-btn">编辑</button>
					<button id="saveBtn" type="button"  class="layui-btn">保存</button>
				</div>
			</div>
		</form>
	</div>

	<script src="${ctx}/res/js/lib/layui/layui.all.js"></script>
	<script src="${ctx}/res/js/menuExt.js"></script>
	<%@include file="/WEB-INF/views/public/common.jspf"%>
	<script>
/* layui.use(['layer', 'form', 'element'], function(){
  var layer = layui.layer
  ,form = layui.form
  ,element = layui.element
});	 */
	
var menus;
var MyMarhq;
$(function(){
    getDept();
    getRole();
    getProdeId();

    //切换到主页
	$(".layui-logo").click(function(){
		window.location.href = "${ctx}/sysIndex";
	});
	
    //收缩左侧菜单栏
	$(".contract-btn").click(function(){
		$("#menu_l").animate({
		    width: "0"
		});
		$(".mainCont").animate({
		    left: "0"
		});
		$(".spread-btn").show();
	});
    
    //展开左侧菜单栏
	$(".spread-btn").click(function(){
		$("#menu_l").animate({
		    width: "200px"
		});
		$(".mainCont").animate({
		    left: "200px"
		});
		$(".spread-btn").hide();
	})
	$.ajax({
		url:'${ctx}/getUserInfo',
		type:'post',
		data:{},
		dataTyep:'json',
		success:function(res){
			if(res.success=="1"){
				menus = res.data.roles[0].memus;
				checkMenuHasSon();
				menus = sortMenu(menus);
				loadTopMenus(menus);
				//initMenu(getMenus($("#menuTop li:eq(0)").attr("data-id")));
				/* var dataUrl = $("#menuLeft li:eq(0)>a").attr("data-url");
				$(".data-content").load(dataUrl); */
				$("#menuTop li").on("click",function(){
					$(".bread-dis li:eq(0) span").text($(this).find("a").text());
					$(".bread-dis li:eq(1)").hide();
					$(".bread-dis li:eq(2)").hide();
					$("#menuTopRight li").removeClass("layui-this");
					$(this).addClass("layui-this").siblings().removeClass("layui-this");
					$("#menuLeft").empty();
					var parentId = $(this).attr("data-id");
					intitLeftMenus(getMenus(parentId));
					$("#menu_l").animate({width: '200px'});
					$(".mainCont").animate({left: '200px'});
					$(".spread-btn").hide();
				});
				$("#menuTopRight li").on("click",function(){
					$(".bread-dis li:eq(0) span").text($(this).find("a").text());
					$(".bread-dis li:eq(1)").hide();
					$(".bread-dis li:eq(2)").hide();
					$(".second-title").hide();
					$("#menuTop li").removeClass("layui-this");
					$(this).addClass("layui-this").siblings().removeClass("layui-this");
					$("#menuLeft").empty();
					var parentId = $(this).attr("data-id");
					intitLeftMenus(getMenus(parentId));
					$("#menu_l").animate({
					    width: "0"
					});
					$(".mainCont").animate({
					    left: "0"
					});
					$(".spread-btn").hide();
					$(".data-content").load("${ctx}/main/pageMain");
					/* $("#menu_l").animate({width: '200px'});
					$(".mainCont").animate({left: '200px'}); */
				})
				
			     var imgUrl= "/itws/res/img/userImg/cover000.jpg"
			     if(res.data.userImg){
			         imgUrl="/itws/res/img/userImg/"+res.data.userImg;
			     }
				//显示头像
				//showCover(imgUrl);
			}
		},
		
		error:function(){
			layer.msg("请求失败");
		}
	})
	
	//默认主页加载首页
	$(".data-content").load("${ctx}/main/pageMain");
	
	//密码修改
	$("#updatePass").click(function(){
		layer.open({
          		  type: 1,
          		  shade: false,
          		  title: "<span class='dialog_title base-zb-info'>"+$("#user-form").data("title")+"</span>",
          		  area: ['400px', '300px'],
          		  content: $('#user-form')
        		});
		$.clear();
	});
	//个人中心
	var catchData = null;
    //超级管理员  2 项目负责人  0未知角色用户 readonly-all
    var userType = 0;
	$("#user_center").click(function () {
	    //个人中心查询之前 首先返现各个字段
		var findUserByIdUrl = "${ctx}/sysUser/findCurrentUser";
		//锁定所有按钮
        $(".admin").attr("readonly","readonly").attr("disabled","disabled");
		$.post(findUserByIdUrl,{},function (data) {
            //初始化数据
			$.setValue(data.data);
			//初始化显示
            var adminIds = ["8a929c0c60dda9f10160ddaecae00006","402880e860f555c20160f584af0c0002","402880e860f555c20160f58478880001"];
            var projectRoles = ["402881ee6bb57e18016bb57fdc090001"];

            var roleId=data.data.roles[0].roleId;
            for(var i = 0;i < adminIds.length;i++){
                if(adminIds[i] == roleId){
                    userType = 1;
                    break;
				}
			}
            for(var i = 0;i < projectRoles.length;i++){
                if(projectRoles[i] == roleId){
                    userType = 2;
                    break;
                }
            }
            if(userType == 0){
                //把按钮去掉
				$("#user_content_btn").hide();
			}
			var res = data;
            //部门回显
            if(res.data.sysDept){
                var deptId=res.data.sysDept.deptId;
                var deptName=res.data.sysDept.name;
                $("#sysDeptIds").val(deptId);
            }
            if(res.data.postId){
                $("#postId").val(res.data.postId);
			}


            //单角色回显
            if(res.data.roles && res.data.roles[0]){
                var roleId=res.data.roles[0].roleId;
                var roleName=res.data.roles[0].name;
                $("#roleIds").val(roleId);
            }

            if(res.data.parentProfession){
                var professionId=res.data.parentProfession.professionId;
                var professionName=res.data.parentProfession.name;
                $("#parentProfessionId").val(professionId);
            }
            catchData = data.data;
            var index = layer.open({
                type: 1,
                shade: false,
                title: "<span class='dialog_title base-zb-info'>个人中心&nbsp;(<span style='color: red'>*</span>为可更改项)</span>",
                area: ['400px', '600px'],
                content: $('#user_center_panel')
            });
            layer.full(index);
        })
    });
	$("#editBtn").click(function () {
		var btnState = $(this).data("state");
		if("edit" == btnState){
            //关闭所有 可操作按钮
            $(".admin").attr("readonly","readonly").attr("disabled","disabled");
            if(userType == 1){
                //超级管理员 释放所有
                $(".admin").parent().parent().find("label").find(".x").remove();
                $(".admin").parent().parent().find("label").prepend("<span class='x' style='margin-right: 3px;color: red'>*</span>");
                $(".admin").removeAttr("readonly","readonly").removeAttr("disabled","disabled");
            }else if(userType == 2) {
                //项目负责人
                $(".project").parent().parent().find("label").find(".x").remove();
                $(".project").parent().parent().find("label").prepend("<span class='x' style='margin-right: 3px;color: red'>*</span>");
                $(".project").removeAttr("readonly","readonly").removeAttr("disabled","disabled");
            }else {
                //未知角色 不释放
            }
		    $(this).text("取消编辑")
			$(this).data("state","readonly")
		}else {
            $(".admin").parent().parent().find("label").find(".x").remove();
            $.setValue(catchData);
            $(this).data("state","edit")
            $(this).text("编辑")
            $(".admin").attr("readonly","readonly").attr("disabled","disabled");
		}
    });
	
	$("#saveBtn").click(function () {
		var saveUserUrl = "${ctx}/sysUser/saveUser";

		//统一以管理员的身份提交方式 因disable值不传导致的 数据置为空的情况
        $(".admin").removeAttr("readonly","readonly").removeAttr("disabled","disabled");
        var formData = serializeObject($("#center_form"));
        catchData = formData;
        var my = {
            form : "center_form",
            url : saveUserUrl,
            callback : function(res) {
                layer.msg(res.message);
                $("#editBtn").data("state","edit");
                $("#editBtn").text("编辑");
                $(".admin").attr("readonly","readonly").attr("disabled","disabled");
            }
        }
        $._FormRequest(my);
    });

    function serializeObject(form) {
        var o = {};
        var a = form.serializeArray();
        $.each(a, function () {
            if (o[this.name] !== undefined) {
                if (!o[this.name].push) {
                    o[this.name] = [o[this.name]];
                }
                o[this.name].push(this.value || '');
            } else {
                o[this.name] = this.value || '';
            }
        });
        return o;
    };




    //查找岗位
    function getProdeId() {
        var my = {
            url : "${ctx}/sysProfession/findTopList",
            callback : function(res) {
                for (var i = 0; i < res.data.length; i++) {
                    $("#postId").append(
                        "<option value='"+res.data[i].professionId+"'>"
                        + res.data[i].name + "</option>");
                }
            }
        }
        $._NormalRequest(my);
    }
    //查找角色
    function getRole() {
        var my = {
            url : "${ctx}/sysRole/queryAll",
            callback : function(res) {
                for (var i = 0; i < res.data.length; i++) {
                    $("#roleIds").append(
                        "<option value='"+res.data[i].roleId+"'>"
                        + res.data[i].name + "</option>");
                }
            }
        }
        $._NormalRequest(my);
    }

    //查找部门
    function getDept() {
        var my = {
            url : "${ctx}/sysDept/findTopList",
            callback : function(res) {
                for (var i = 0; i < res.data.length; i++) {
                    $(".sysDeptIds").append(
                        "<option value='"+res.data[i].deptId+"'>"
                        + res.data[i].name + "</option>");
                }
            }
        }
        $._NormalRequest(my);
    }


    $("input[name='password']").on('blur', function() {
		var $_this = $(this);
		if($_this.val()){
			var my = {
					url : "${ctx}/sysUser/getUser",
					para:{userName:$("#user").text().trim(),password:$_this.val()},
					callback : function(res) {
						if(res.success=='2'){
							$_this.val("");
							layer.tips("原密码输入错误", $_this);
						}
					}
			}
			$._NormalRequest(my);
		}
	});
	
	//保存方法
	$('#pass-save').on('click', function() {
		//表单校验
		var isTemp = $("#userForm").validateForm({
			msgPosition : 'right'
		});
		//分类处理
		if (isTemp) {
			var my = {
					form :"userForm",
					url : "sysUser/updatePassword",
					callback : function(res) {
						if(res.success == '1'){
							layer.closeAll();
						}
						layer.msg(res.message);
					}
				}
			$._FormRequest(my);
		}
	});
	
	//退出
	$("body").on("click",'#exit',function(){
		var userId = $(this).data('pkid');
		layer.confirm('你确要退出系统吗？', {
     		  btn: ['确定','取消']//按钮
     		}, function(){
			var my = {
					url : "${ctx}/logout",
					callback : function(res) {
						if(res.success=="1"){
							window.open(window.location.origin+"${ctx}/login","_self");
						}
						layer.msg(res.message);
					}
			}
			$._NormalRequest(my);
     		})
	});
	
	//initMenu(getMenus(""));
});

//判断菜单是否有子节点并添加子节点状态
function checkMenuHasSon(){
	menus.forEach(function(v,i){
		v.hasChild=false;
	})
	menus.forEach(function(v,i){
		if(v.type=='1'){
			menus.forEach(function(val,j){
				if(val.parentMenu && val.parentMenu.menuId == v.menuId && val.type=='1'){
					v.hasChild=true;
				}
			});
		} 
	})
}

//加载顶部一级菜单
function loadTopMenus(menus){
	var menu_subhtml = "";
	//var menu_leftHtml = "";
	var menu_topRightHtml = "";
	menus.forEach(function(v,i){
		if(v.type=='1' && v.parentMenu != null && v.parentMenu.menuId=='0' && v.isIframe=='1'){
			menu_subhtml += '<li class="layui-nav-item" data-id="'+v.menuId+'"><a>'+v.name+'</a></li>';
			/* menus.forEach(function(val,j){
				if(val.parentMenu && val.parentMenu.menuId == v.menuId){
					menu_leftHtml += '<li class="layui-nav-item layui-nav-itemed menu-left"><a href="javascript:;">'+val.name+'</a>';
				}
			}); */
		} else if (v.type=='1' && v.parentMenu != null && v.parentMenu.menuId=='0' && v.isIframe=='0') {
			menu_topRightHtml += '<li class="layui-nav-item" data-id="'+v.menuId+'"><a>'+v.name+'</a></li>';
		}
		
	})
	$("#menuTop").html(menu_subhtml);
	$("#menuTopRight").html(menu_topRightHtml);
	//$("#menuTop li:eq(0)").addClass("layui-this");
}

//获取下级节点
function getMenus(parentMenu) {
    //var menus = [{ menuName: "菜单1", url: "", id: "root1", parentId: "", hasChild: true }, { menuName: "菜单2", url: "", id: "root2", parentId: "" }, { menuName: "菜单11", url: "", id: "child1", parentId: "root1", hasChild: true }, { menuName: "菜单12", url: "", id: "child2", parentId: "root1", hasChild: false }, { menuName: "菜单111", url: "", id: "child1", parentId: "child1", hasChild: false }, ];
    var returnArr = [];
    var pMenu = '';
    for (var i = 0; i < menus.length; i++) {
    	if(menus[i].parentMenu==null){
    		pMenu = ''
    	}else {
    		pMenu = menus[i].parentMenu.menuId;
    	}
        if (pMenu == parentMenu && menus[i].type=='1') {
            returnArr.push(menus[i]);
        }
    }
    return returnArr;
}
function sortMenu(menus){
	var sortArr = [];
	var a;
	var b;
	for(var i=0;i<menus.length-1;i++){//外层循环控制排序趟数
		for(var j=0;j<menus.length-1-i;j++){//内层循环控制每一趟排序多少次
			if(menus[j].priority>menus[j+1].priority){
				var temp=menus[j];
				menus[j]=menus[j+1];
				menus[j+1]=temp;
			}
		}
	}
	return menus;
}


//显示用户头像
/* function showCover(coverUrl){
     $("#userCover").attr("src",coverUrl);
} */


//获得菜单列表
</script>
</body>
</html>
