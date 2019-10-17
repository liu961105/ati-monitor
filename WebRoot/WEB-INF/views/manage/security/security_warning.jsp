<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/public/taglib.jspf"%>
<!DOCTYPE html>
<html>
<script type="text/javascript">
	var ctx = "${ctx}";
</script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="renderer" content="webkit">
<meta name="viewport" content="width=device-width">
<title></title>
<link rel="stylesheet" href="${ctx}/res/ati_monitor/css/base.css">
<link rel="stylesheet" href="${ctx}/res/css/manage/iconfont.css">
<link rel="stylesheet" href="${ctx}/res/ati_monitor/css/jquery.page.css">
<link rel="stylesheet" href="${ctx}/res/ati_monitor/css/baseless.css">
<style>
#page {
	color: #333 !important;
	margin-top: 1.388888888888889vh;
}

.n-contaiter .top {
	height: 24.037037037037038vh;
	background-color: #1E2448;
}
.n-contaiter .top .one {
    color: #406B9C;
    font-size: 1.851851851851852vh;
    padding: 1.7592592592592595vh 0.9895833333333334vw;
}
.n-contaiter .top .two {
    padding: 1.7592592592592595vh 0.9895833333333334vw;
    color: #406B9C;
    overflow: hidden;
} 
.n-contaiter .top .two li {
    float: left;
    width: 50%;
    margin-bottom: 3.055555555555556vh;
    font-size: 1.851851851851852vh;
}
.n-contaiter .top .two li label,
.n-contaiter .top .two li span {
    display: inline-block;
    color: white;
    letter-spacing: 1px;
}
.n-contaiter .top .two li label {
    width: 6.770833333333334vw;
    text-align: right;
    color: white;
}
.n-contaiter .top .two li span {
    padding: 0.462962962962963vh 0.78125vw;
    border-radius: 0.462962962962963vh;
    cursor: pointer;
}
.n-contaiter .top .two li .on {
    background-color: #02C1AC;
}
.n-contaiter .btn-export {
    width: 7.395833333333334vw;
    background-color: white;
    border-radius: 1.388888888888889vh;
    color: #33C9B7;
    margin: 1.2037037037037037vh 1.5625vw;
}
.n-contaiter .center {
    margin: 1.2037037037037037vh 1.5625vw 0;
}
.n-contaiter .center .m-table {
    border-color: transparent;
    border: 0;
    color: white;
}
.n-contaiter .center .m-table thead th {
    background-color: #0A0233;
    border-color: transparent;
 }
 .n-contaiter .center .m-table td {
    border-right: 1px solid #414A81;
    border-bottom: 0;
 }

 .btn-yellow { 
  color: #ffffff; 
  background-color: #D1D108; 
  border-color: #D1D108; 
} 
 
.btn-yellow:hover, 
.btn-yellow:focus, 
.btn-yellow:active, 
.btn-yellow.active, 
.open .dropdown-toggle.btn-yellow { 
  color: #ffffff; 
  background-color: #D1D108; 
  border-color: #D1D108; 
} 
 
.btn-yellow:active, 
.btn-yellow.active, 
.open .dropdown-toggle.btn-yellow { 
  background-image: none; 
} 
 
.btn-yellow.disabled, 
.btn-yellow[disabled], 
fieldset[disabled] .btn-yellow, 
.btn-yellow.disabled:hover, 
.btn-yellow[disabled]:hover, 
fieldset[disabled] .btn-yellow:hover, 
.btn-yellow.disabled:focus, 
.btn-yellow[disabled]:focus, 
fieldset[disabled] .btn-yellow:focus, 
.btn-yellow.disabled:active, 
.btn-yellow[disabled]:active, 
fieldset[disabled] .btn-yellow:active, 
.btn-yellow.disabled.active, 
.btn-yellow[disabled].active, 
fieldset[disabled] .btn-yellow.active { 
  background-color: #D1D108; 
  border-color: #D1D108; 
} 
.btn-yellow .badge { 
  color: #D1D108; 
  background-color: #ffffff; 
}

.layui-form-select dl{
	position: relative;
}
.lay-ext-mulitsel .layui-input.multiple a{
	font-size: 12px;
	height: 35px;
}
.lay-ext-mulitsel .layui-input.multiple{
	padding: 0px;
}
.layui-form-select dl{
	top:3px;
}
</style>
</head>

<body class="home">
	<section class="n-contaiter" style="background: #171939;">
		<div class="top">
			<div class="one">
				告警等级由高到低依次为：红 > 橙 > 黄 
			</div>
			<ul class="two J_checkout">
				<li><label for="">安全等级：</label> (单选) <span class="on">全部</span>
					<span>黄色</span> <span>橙色</span> <span>红色</span></li>
				<li class="monitorType"></li>
				<li><label for="">处理结果：</label> (单选) <span class="on">全部</span>
					<span>已处理</span> <span>未处理</span></li>
				<li><label for="">排序方式：</label> (单选) <span class="on">全部</span>
					<span>告警源</span> <span>等级</span> <span>告警生产时间</span></li>
				<li><label for="">数据状态：</label> (单选) <span class="on">全部</span>
					<span>正常</span> <span>异常</span></li>
				<li><label style="float: left;line-height: 5vh;" for="">监测点位：</label>
					<div class="layui-input-inline" name="monitorSites" id="monitorSites" style="float: left" lay-filter="monitorSites">
					</div>
					<button id="btn_search" type="button" class="layui-btn layui-btn-normal layui-btn-radius" style="float:left;margin-left: 1vw;">开始搜索</button>
				</li>
				<li></li>
			</ul>
		</div>
		<div class="center">
			<table class="m-table" style="margin-top: 13px" cellspacing="0" cellpadding="0">
				<thead>
					<tr>
						<th style="width: 4vw;text-align: center;">序号</th>
						<th style="text-align: center;">告警源</th>
						<th style="width: 5vw;text-align: center">等级</th>
						<th style="width: 7vw;text-align: center">监测值1/X值</th>
						<th style="width: 7vw;text-align: center">监测值2/Y值</th>
						<th style="text-align: center;">产生时间</th>
						<th style="width: 25vw;text-align: center">预警参考值</th>
						<th style="text-align: center;">处理时间</th>
						<th style="width: 5vw;text-align: center">状态</th>
						<th style="text-align: center;">确认信息</th>
						<th style="text-align: center;">确认人</th>
					</tr>
				</thead>
				<tbody class="J_table">

				</tbody>
			</table>
			<ul id="page">
				<div class="next fr">»</div>
				<div class="last fr">末页</div>
				<ul class="pagingUl">
					
				</ul>
				<div class="first fr">首页</div>
				<div class="prv fr">«</div>
			</ul>
		</div>
	</section>
	<script src="${ctx}/res/ati_monitor/js/jquery.page.js"></script>
	<script src="${ctx}/res/js/main.js"></script>
	<script src="${ctx}/res/js/selectPluus.js"/>
	<script src="${ctx}/res/ati_monitor/js/home.js"></script>
	<script type="text/javascript">
        $(function() {
            var selectPlus = layui.selectM;
            $.post("${ctx}/atiProjectMonitorSites/findAllByProjectId",{projectId:$("#flagProjectId").val()},function (data) {
                data = data.data;
                var tagData = [];
                for (var i = 0; i < data.length; i++) {
                    var item = {id:data[i].id,name:data[i].name};
                    tagData.push(item);
                }
                var selectplus = selectPlus({
                    //元素容器【必填】
                    elem: '#monitorSites'
                    //候选数据【必填】
                    ,data: tagData
                    ,max:1000
                    ,width:350
                    //添加验证
                    ,verify:'required'
					,flag:'security'
					,height:200
                });
            })


        })
	</script>
</body>

</html>