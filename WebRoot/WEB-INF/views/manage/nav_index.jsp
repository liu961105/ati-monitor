<%@ page language="java" pageEncoding="utf-8"%>
<%@include file="/WEB-INF/views/public/taglib.jspf"%>

<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<meta name="renderer" content="webkit">
		<meta name="viewport" content="width=device-width">
		<title></title>
		<link rel="stylesheet" href="${ctx}/res/ati_monitor/css/base.css">
		<link rel="stylesheet" href="${ctx}/res/css/nav.css">
	</head>
	<body>
		<header class="header">
			<div class="title">贵州顺康路桥大数据信息平台</div>
		</header>
		<section class="box-main">
			<ul class="box-item">
				<li data-code="bridge">
					<i></i>
					<span>桥梁</span>
				</li>
				<li data-code="tunnel">
					<i></i>
					<span>隧道</span>
				</li>
				<li data-code="road">
					<i></i>
					<span>道路</span>
				</li>
				<li data-code="slope">
					<i></i>
					<span>边坡基坑</span>
				</li>
				<li data-code="geologic">
					<i></i>
					<span>地质灾害</span>
				</li>
			</ul>
		</section>
		<form id="pageControl" action="${ctx}/sysIndex" method="post">
			<input id="strucType" type="hidden" name="strucType"/>
			<input id="strucTypeName" type="hidden" name="strucTypeName"/>
		</form>
		<script type="text/javascript" src="${ctx}/res/js/lib/jquery/jquery-1.8.3.min.js"></script>
		<script>
			$(function(){
				$(".box-item li").click(function(){
					var code = $(this).data("code");
					var name = $(this).find("span").text();
					$("#strucType").val(code);
					$("#strucTypeName").val(name);
					$("#pageControl").submit();
				})
			})
		</script>
	</body>
</html>
