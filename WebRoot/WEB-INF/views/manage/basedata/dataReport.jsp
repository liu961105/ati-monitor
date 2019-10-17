<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/public/taglib.jspf"%>
<!-- 列表界面 -->
<div id="data-list">
	<div class="banner">
		<span class="base-blue-01 base-search" data-title='数据生成列表'>数据生成列表</span>
	</div>
	<form id="fa-search" class="layui-form-pane" style="margin-top: 15px;">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">监测类型</label>
				<div class="layui-input-inline">
					<select class="base-select" name="monitorTypeId" id="monitorTypeId"
						style="width: 273px">
						<option value="">请选择监测类型</option>
					</select>
				</div>

				<div class="layui-inline" style="margin-left: 85px">
					<label class="layui-form-label">监测项</label>
					<div class="layui-input-inline">
						<select class="base-select" name="project" id="project"
							style="width: 273px">
							<option value="">请选择监测项</option>
						</select>
					</div>
				</div>
			</div>
			<div class="layui-form-item">
				<div class="layui-inline">
					<label class="layui-form-label">监测参数</label>
					<div class="layui-input-inline">
						<select class="base-select" name="monitorParamId"
							style="width: 274px" id="monitorParamId">
							<option value="">请选择监测参数</option>
						</select>
					</div>
				</div>
				<input type="hidden" name="projectId" id="projectId" />
				<div class="layui-inline" style="margin-left: 72px">
					<label class="layui-form-label">监测点位</label>
					<div class="layui-input-inline">
						<select class="base-select" name="monitorSitesId"
							id="monitorSitesId" style="width: 274px">
							<option value="">请选择监测点位</option>
						</select>
					</div>
				</div>
				<div class="layui-form-item">
					<div class="layui-inline" style="margin-right: -3px;">
						<label class="layui-form-label" style="width: 150px;">时间段</label>
						<div class="layui-input-inline" style="width: 250px;">
							<input type="text" name="uploadTimeBegin" id="uploadTimeBegin"
								autocomplete="off" class="layui-input"
								onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})" />
						</div>
						<label class="layui-form-label" style="width: 150px;">-</label>
						<div class="layui-input-inline" style="width: 250px;">
							<input type="text" name="uploadTimeEnd" id="uploadTimeEnd"
								autocomplete="off" class="layui-input"
								onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})" />
						</div>
						<div class="layui-inline" >
							<button id="btn_search" type="button"
								class="layui-btn layui-btn-normal" data-toggle="modal">
								<i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
							</button>
							<button id="sjsc" type="button" class="layui-btn layui-btn-warm"
								data-toggle="modal">生成报告</button>
						</div>
					</div>
				</div>
			</div>
	</form>
	<div id="list">
		<table class="layui-table">
			<colgroup>
				<col width="60">
				<col width="200">
				<!--<col width="150">
		      <col width="100">
		      <col width="100">
		      <col width="200">
		      <col width="200">
		      <col width="80">
		      <col width="150"> -->
			</colgroup>
			<thead>
				<tr>
					<th>序号</th>
					<th>监测类型</th>
					<th>监测设备</th>
					<th>监测参数名称</th>
					<th>监测点位</th>
					<th>监测值</th>
					<th>监测时间</th>
				</tr>
			</thead>
			<tbody id="datalist">

			</tbody>
			<script id="tradecent-template" type="text/x-handlebars-template">
			 {{#each this}}
                <tr>
                   <td><div class='base-wrap'>{{addOne @index}}</div></td>
 				 <td><div class='base-wrap left' title="{{monitorTypeName}}">{{monitorTypeName}}</div></td>
                    <td><div class='base-wrap left' title="{{deviceName}}">{{deviceName}}</div></td>
                    <td><div class='base-wrap left' title="{{monitorParamName}}">{{monitorParamName}}</div></td>
                    <td><div class='base-wrap left' title="{{monitorSitesName}}">{{monitorSitesName}}</div></td>
 					<td><div class='base-wrap left' title="{{deviceUploadData}}">{{deviceUploadData}}</div></td>
                    <td><div class='base-wrap left' title="{{uploadTime}}">{{uploadTime}}</div></td>
                </tr>
                {{/each}}
		</script>
		</table>
	</div>
</div>
<!-- end列表界面 -->
<script src="${ctx}/res/js/main.js"></script>
<script type="text/javascript">
	$(function() {
	$("#projectId").val($("#flagProjectId").val());
		getTypeAndItem();
		$.baseEvent({
			ctx : '${ctx}',
			param : [ 'monitorTypeId', 'monitorParamId','monitorSitesId','uploadTimeBegin','uploadTimeEnd','projectId'],
			isPage : true,
			pageList_url : '/dataReport/getableData',
			form_url : '/monitorParam/save',
			data_list : '${ctx}/route/manage/basedata/monitor_param_list',
			del_url : '/monitorParam/delete',
			findBy_url : '/monitorParam/findById',
			add_is_dialog : true
		});
	});

	$('#sjsc').click(function() {
	debugger
		var projectId = $("#flagProjectId").val();
		var mtype = $("#monitorTypeId  option:selected").val(); //监测类型
		var mproject = $("#projectId  option:selected").val(); //监测项
		var mparam = $("#monitorParamId  option:selected").val(); //监测参数
		var monitorSitesId = $("#monitorSitesId  option:selected").val(); //监测点位
		var uploadTimeBegin = $("#uploadTimeBegin").val();
		var uploadTimeEnd = $("#uploadTimeEnd").val();
	//	var uploadTimeBegin = $("#")
	//
		window.location.href = "${ctx}/dataReport/dataDownload?projectId=" + projectId + '&monitorTypeId=' + mtype + '&monitorParamId=' + mparam+'&monitorSitesId='+monitorSitesId+'&uploadTimeBegin='+uploadTimeBegin+'&uploadTimeEnd='+uploadTimeEnd;
	});

	//加载监测参数和监测项
	function getTypeAndItem() {
		var my1 = {
			url : "${ctx}/monitorParam/getTypeAndItem",
			para : {
				'structId' : $("#structureId").val()
			},
			callback : function(res) {
				if (res.data) {
					var html = '<option value="">请选择监测类型</option>';
					var v = res.data.typeList;
					for (var i = 0; i < v.length; i++) {
						html += '<option value="' + v[i].id + '">' + v[i].name + '</option>';
					}
					//$("#typeId").html(html);
					$("#monitorTypeId").html(html);

					//加载查询条件监测项
					$(document).off("change", "#monitorTypeId").on("change", "#monitorTypeId", function() {
						$("#project").html('<option value="">请选择监测项</option>');
						var html = '<option value="">请选择监测项</option>';
						var typeId = $(this).find("option:selected").val().trim();
						for (var i = 0; i < res.data.itemList.length; i++) {
							if (res.data.itemList[i].atiMonitorType && typeId == res.data.itemList[i].atiMonitorType.id) {
								html += "<option value='" + res.data.itemList[i].id + "'>" + res.data.itemList[i].name + "</option>";
								$("#project").append("<option value='" + res.data.itemList[i].id + "'>" + res.data.itemList[i].name + "</option>");
							}
						}
					});
					
					$(document).off("change", "#project").on("change", "#project", function() {
						var url = "${ctx}/monitorParam/getParamListByItem";
						var itemId = $(this).find("option:selected").val().trim();
						var index = layer.load();
						$.post(url, {
							monitorItemId : itemId
						}, function(data) {
							data = data.data;
							$("#monitorParamId").html('<option value="">请选择监测参数</option>');
							for (var i = 0; i < data.length; i++) {
								$("#monitorParamId").append("<option value='" + data[i].id + "'>" + data[i].name + "</option>");
							}
							layer.close(index);
						})
					});
					
					$(document).off("change", "#monitorParamId").on("change", "#monitorParamId", function() {
						var url = "${ctx}/processing/getSpoy";
						var monitorParamId = $(this).find("option:selected").val().trim();
						var projectId = $("#flagProjectId").val();
						var index = layer.load();
						$.post(url, {
							paramId : monitorParamId,
							projectId:projectId
						}, function(data) {
							data = data.data;
							$("#monitorSitesId").html('<option value="">请选择监测点位</option>');
							for (var i = 0; i < data.length; i++) {
								$("#monitorSitesId").append("<option value='" + data[i].id + "'>" + data[i].name + "</option>");
							}
							layer.close(index);
						})
					});
				}
			}
		}
		$._MultAjax(my1);
	}

</script>
