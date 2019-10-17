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
<link rel="stylesheet" href="${ctx}/res/ati_monitor/css/iconfont.css">
<link rel="stylesheet" href="${ctx}/res/ati_monitor/css/baseless.css">
<link rel="stylesheet" href="${ctx}/res/ati_monitor/css/home.css">
<link rel="stylesheet"
	href="${ctx}/res/ati_monitor/js/layui/css/layui.css">
<link rel="stylesheet"
	href="${ctx}/res/ati_monitor/js/layui/css/layui.css">
</head>
<style>
li {
	color: seashell;
}
th{
	background-color: #171939;
}
label {
	color: #fff9ec;
	background-color: #01AAED;
}
.right {
	float: left;
	padding: 20px;
	padding-left: 30px;
}

.layui-btn {
	margin-top: 20px;
	!
	important;
}

.left {
	float: left;
	padding: 20px;
}

.item {
	display: flex;
}

.n-contaiter {
	padding-left: 25px;
}

.select-item {
	width: 400px;
}
.layui-table>tbody>tr:hover {
    background-color: #2e3167;
}
</style>
<body class="home">
	<section class="n-contaiter" style="background: #171939;">
		<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">

			<div class="layui-tab-content">
				<div class="layui-tab-item layui-show">
					<form id="search_form">
						<div class="layui-form">

							<div class="item">
								<div class="left">
									<label style="width: 110px;" class="layui-form-label">监测类型：</label>
									<div class="layui-input-block select-item"
										style="width: 400px;padding-left: 10px">
										<select class="mtype" name="monitorTypeName"
											lay-filter="monitorType">
										</select>
									</div>
								</div>
								<div class="right">
									<label style="width: 110px;" class="layui-form-label">监测项目：</label>
									<div class="layui-input-block select-item"
										style="width: 400px;padding-left: 10px">
										<select class="mproject" name="projectName"
											lay-filter="monitorProject">
										</select>
									</div>
								</div>
							</div>
							<div class="item">
								<div class="left">
									<label style="width: 110px;" class="layui-form-label">监测参数：</label>
									<div class="layui-input-block select-item"
										style="width: 400px;padding-left: 10px">
										<select class="mparam" name="monitorParamName"
											lay-filter="monitorParam">
										</select>
									</div>
								</div>
								<div class="right">
									<label style="width: 110px;" class="layui-form-label">监测点位：</label>
									<div class="layui-input-block select-item"
										style="width: 400px;padding-left: 10px">
										<select class="mspot" name="monitorSitesName"
											lay-filter="monitorSpot">
										</select>
									</div>
								</div>
							</div>

							<div class="item">
								<div class="left">
									<label style="width: 110px;" class="layui-form-label">对比时段：</label>
									<div class="layui-input-block select-item"
										style="width: 400px;padding-left: 10px">
										<input type="text" name="searchBeginTimeOne"
											id="searchBeginTimeOne" autocomplete="off"
											class="layui-input"
											onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})" />
									</div>
								</div>
								<a style="color: white;margin-top: 3vh;width: 0vw;">~</a>
								<div class="right">
									<div class="layui-input-block select-item"
										style="width: 400px;padding-left: 10px;margin-left: -0.5vw;">
										<input type="text" name="searchEndTimeOne"
											id="searchEndTimeOne" autocomplete="off" class="layui-input"
											onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})" />
									</div>
								</div>
								<button id="search" type="button"
									class="layui-btn layui-btn-normal" data-toggle="modal">
									<i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
								</button>
								<button id="sjsc" type="button" class="layui-btn layui-btn-warm"
									data-toggle="modal">生成报告</button>
							</div>
						</div>
					</form>

					<div id="list">
						<table class="layui-table" style="background-color: #171939;color: aliceblue">
							<colgroup>
								<col width="50">
								<col width="100">
								<col width="100">
								<col width="100">
								<col width="100">
								<col width="100">
								<col width="120">
							</colgroup>
							<thead>
								<tr>
									<th>序号</th>
									<th>结构类型名称</th>
									<th>监测类型</th>
									<th>监测项目</th>
									<th>监测参数名称</th>
									<th>监测点位名称</th>
									<th>监测时间</th>
								</tr>
							</thead>
							<tbody id="datalist">

							</tbody>
							<script id="tradecent-template" type="text/x-handlebars-template">
                {{#each this}}
                <tr>
                    <td><div class='base-wrap'>{{addOne @index}}</div></td>
			<td><div class='base-wrap left' title="{{structName}}">{{structName}}</div></td>
 				 <td><div class='base-wrap left' title="{{monitorTypeName}}">{{monitorTypeName}}</div></td>
                    <td><div class='base-wrap left' title="{{projectName}}">{{projectName}}</div></td>
                    <td><div class='base-wrap left' title="{{monitorParamName}}">{{monitorParamName}}</div></td>
                    <td><div class='base-wrap left' title="{{monitorSitesName}}">{{monitorSitesName}}</div></td>
                    <td><div class='base-wrap left' title="{{uploadTime}}">{{uploadTime}}</div></td>
                </tr>
                {{/each}}
            </script>
						</table>
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- 引入 ECharts 文件 -->
</body>
<script type="text/javascript">
	$(function() {
		$.baseEvent({
			ctx : '${ctx}',
			param : [ 'projectName', 'monitorTypeName', 'monitorParamName','monitorSitesName'],
			isPage : true,
			pageList_url : '/atiDeviceDataRecordHistory/pageList',
			form_url : '/atiProject/saveProjectInfo',
			data_list : '${ctx}/route/basedata/sjsc',
			del_url : '/atiProject/delProjectInfo',
			findBy_url : '/atiProject/findProjectInfo',
			add_is_dialog : true
		});
		//全选/反选
		$("#checkAll").click(function() {
			$("input[name='userItem']:checkbox").prop("checked", this.checked);
		});
		function sjsc() {
			debugger;
			var ID = $('#configProjectId').val(projectId);
			window.location.href = location.href = "${ctx}/dataReport/dataDownload?projectId=" + ID;
		}



		//绑定项目所属类型的option
		var projectStructureUrl = "${ctx}/projectStructure/findAll";
		$.post(projectStructureUrl, {}, function(data) {
			if (data.success == '1') {
				data = data.data;
				for (var i = 0; i < data.length; i++) {
					var item = $("<option></option>");
					item.val(data[i]["id"]);
					item.text(data[i]["name"]);
					$(".projectStructure").append(item)
				}
			}
		})

	});
</script>

<script type="text/javascript">

	$(function() {

		$("#").click(function() {
			var spot = $(".mspot  option:selected").text(); //监测点位
			var beginTime = $("#searchBeginTimeOne").val();
			var endTime = $("#searchEndTimeOne").val();

			var formData = serializeObject($('#search_form'))
			formData["projectId"] = $("#flagProjectId").val();
			formData["searchType"] = 3;
			var searchUrl = "${ctx}/dataReport/getTableData";
			$.post(searchUrl, formData, function(data) {
				if (data.success == '1') {
					data = data.data;
					var searchType = $("#searchType").val();
					//渲染标题
					data.title = searchType == 1 ? "同一时间段不同监测点" : "不同时间段同一监测点";
					//选择数据标识
					if (searchType == 1) {
						//同一时间不同监测点  名称以监测点命名
						var monOneText = $("#monitorSitesOne").find("option:selected").text();
						var monTwoText = $("#monitorSitesTwo").find("option:selected").text();
						data.legendData = [ monOneText, monTwoText ];
					} else if (searchType == 2) {
						//不同时间段同一监测点 名称以时间段命名
						var monOneText = $("#monitorSitesOne").find("option:selected").text();
						var timeOneText = $("#searchBeginTimeOne").val() + "-" + $("#searchEndTimeOne").val();
						var timeTwoText = $("#searchBeginTimeTwo").val() + "-" + $("#searchEndTimeTwo").val();
						data.legendData = [ timeOneText, timeTwoText ]
					} else {
						var monOneText = $(".mspot1").find("option:selected").text();
						data.legendData = [ monOneText ];
					}
					initEachart(data);
				}
			})
		});
		layui.use('element', function() {
			var element = layui.element;

			element.init(); //更新全部  2.1.6 可用 element.render() 方法替代

		});

		layui.use('form', function() {
			var form = layui.form;
			form.render();
			getMonitorData(form);
			form.render();


		});

		layui.use('laydate', function() {
			var laydate = layui.laydate;

			laydate.render({
				elem : '#test1' //指定元素
			});
			//执行一个laydate实例
			laydate.render({
				elem : '#test2' //指定元素
			});
		});
		// 基于准备好的dom，初始化echarts实例
		function initEachart(data) {
			// 基于准备好的dom，初始化echarts实例
			var myChart = echarts.init(document.getElementById('main'), 'macarons');

			// 指定图表的配置项和数据
			option = {
				title : {
					x : '12px',
					text : data.title
				},
				tooltip : {
					trigger : 'axis'
				},
				legend : {
					data : data.legendData
				},
				toolbox : {
					show : true,
					x : '1000px',
					feature : {
						dataView : {
							show : true,
							readOnly : false
						},
						magicType : {
							show : true,
							type : [ 'line', 'bar' ]
						},
						restore : {
							show : true
						},
						saveAsImage : {
							show : true
						}
					}
				},
				calculable : true,
				xAxis : [ {
					type : 'category',
					data : data.category
				} ],
				yAxis : [ {
					type : 'value'
				} ],
				series : [ {
					name : data.legendData[0],
					type : 'line',
					data : data.lineOneData,
					markPoint : {
						data : [ {
							type : 'max',
							name : '最大值'
						},
							{
								type : 'min',
								name : '最小值'
							}
						]
					},
					markLine : {
						data : [ {
							type : 'average',
							name : '平均值'
						} ]
					}
				}
				]
			};


			// 使用刚指定的配置项和数据显示图表。
			myChart.setOption(option);
		}
	});
	function getMonitorData(form) {
		var structureId = $("#structureId").val();
		var index = layer.load();
		$.ajax({
			type : 'POST',
			url : ctx + '/processing/getMonitorData',
			data : {
				"structureId" : structureId
			},
			dataType : 'json',
			success : function(res) {
				$('.mtype').html('');
				if (res.success == '1') {
					layer.close(index);
					$.each(res.data, function(i, item) {
						str = '<option value="' + item.id + '">' + item.name + '</option>';
						$('.mtype').append(str);
					});
					form.render();
					form.on('select(monitorType)', function(data) {
						var index = layer.load();
						$.ajax({
							type : 'POST',
							url : ctx + '/processing/getMonitorItem',
							data : {
								'typeId' : data.value
							},
							dataType : 'json',
							success : function(res) {
								if (res.success == '1') {
									layer.close(index);
									$('.mproject').html('');
									$.each(res.data, function(i, item) {
										str = '<option value="' + item.id + '">' + item.name + '</option>';
										$('.mproject').append(str);
									});
									form.render();
									form.on('select(monitorProject)', function(data) {
										var index = layer.load();
										$.ajax({
											type : 'POST',
											url : ctx + '/processing/getParam',
											data : {
												'itemId' : data.value
											},
											dataType : 'json',
											success : function(res) {
												if (res.success == '1') {
													layer.close(index);
													$('.mparam').html('');
													$.each(res.data, function(i, item) {
														str = '<option value="' + item.id + '">' + item.name + '</option>';
														$('.mparam').append(str);
													});
													form.render();
													form.on('select(monitorParam)', function(data) {
														var index = layer.load();
														$.ajax({
															type : 'POST',
															url : ctx + '/processing/getSpoy',
															data : {
																'paramId' : data.value
															},
															dataType : 'json',
															success : function(res) {
																if (res.success == '1') {
																	layer.close(index);
																	$('.mspot').html('');
																	$.each(res.data, function(i, item) {
																		str = '<option value="' + item.id + '">' + item.name + '</option>';
																		$('.mspot').append(str);
																	});
																	form.render();
																}
															}
														});
														form.render('select');
													});
												}
											}
										});
										form.render('select');
									});
								}
							}
						});
						form.render('select');
					});
				}
			}
		});
	}
	function serializeObject(form) {
		var o = {};
		var a = form.serializeArray();
		$.each(a, function() {
			if (o[this.name] !== undefined) {
				if (!o[this.name].push) {
					o[this.name] = [ o[this.name] ];
				}
				o[this.name].push(this.value || '');
			} else {
				o[this.name] = this.value || '';
			}
		});
		return o;
	}
	;
	$('#sjsc').click(function() {
		debugger;
		var mtype = $(".mtype  option:selected").val(); //监测类型
		var mproject = $(".mproject  option:selected").val(); //监测项目
		var mparam = $(".mparam  option:selected").val(); //监测参数
		var projectId = $("#flagProjectId").val();
		window.location.href = "${ctx}/dataReport/dataDownload?projectId=" + projectId + '&monitorTypeId=' + mtype + '&monitorParamId=' + mparam;
	});
	
	$("#search").click(function() {
	debugger
		pageData(1);
	});
	
	function pageData(pageIndex) {
	var projectId = $("#flagProjectId").val();
	var mtype = $(".mtype  option:selected").val();
	var mproject = $(".mproject  option:selected").val(); //监测项目
   var mparam = $(".mparam  option:selected").val(); //监测参数
//    var index = layer.load();
	$.ajax({
		type : 'POST',
		url : ctx + '/atiDeviceDataRecordHistory/pageList',
		data : {
			"pageCurrent" : pageIndex,
			"projectId" : projectId,
			"monitorTypeId" : mtype,
			"monitorParamId": mparam
		},
       dataType : 'json',
		success : function(res) {
			if (res.success == '1') {
				layer.close(index); 
				var data = res.data;
				var totalPages = data.totalPages;
				$("#page").Page({
					totalPages : totalPages, //分页总数
					liNums : 10, //分页的数字按钮数(建议取奇数)
					activeClass : 'activP', //active 类样式定义
					indexPage : pageIndex,
					callBack : function(page) {
						pageData(page)
					}
				});
				
			} else if (res.success == '2') {
				layer.close(index); 
				noData();
			}
		}
	});
}

function noData() {
	var html = '<h1 style="width: 85vw;text-align: center;">暂无数据</h1>';
	$(".J_table").html(html);
}
</script>

</html>