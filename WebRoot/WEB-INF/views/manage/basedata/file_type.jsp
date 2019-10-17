<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/public/taglib.jspf"%>
<!-- 列表界面 -->
<div id="data-list">
	<div class="banner">
		<span class="base-blue-01 base-search" data-title='文档分类列表'>文档分类列表</span>
	</div>
	<form id="fa-search" class="layui-form-pane" style="margin-top: 15px;">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">文档编码</label>
				<div class="layui-input-inline">
					<input type="text" name="code" id="code" autocomplete="off"
						class="layui-input">
				</div>
				<input type="hidden" name="strucId" id="strucId" /> <input
					type="hidden" name="projectId" id="projectId" />
			</div>
			<div class="layui-inline">
				<button id="btn_search" type="button"
					class="layui-btn layui-btn-normal" data-toggle="modal">
					<i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
				</button>
			</div>
			<div class="layui-inline layui-inline-right">
				<shiro:hasPermission name="monitorType:save">
					<button id="btn_add" type="button" class="layui-btn"
						data-toggle="modal">新增分类</button>
				</shiro:hasPermission>
				<shiro:hasPermission name="monitorType:delete">
					<button id="btn_del" type="button"
						class="layui-btn layui-btn-danger" data-toggle="modal">删除</button>
				</shiro:hasPermission>
			</div>
		</div>
	</form>
	<div id="list">
		<table class="layui-table">
			<colgroup>
				<col width="60">
				<col width="60">
				<!-- <col width="60">
		      <col width="150">
		      <col width="100">
		      <col width="100">
		      <col width="200">
		      <col width="200">
		      <col width="80">
		      <col width="150"> -->
			</colgroup>
			<thead>
				<tr>
					<th><div class="label">
							<input id="checkAll" lay-skin="primary" type="checkbox"
								class="check_btn"> <label class="checkboxLable"
								for="checkAll"></label>
						</div></th>
					<th>序号</th>
					<th>文档类型编码</th>
					<th>文档类型名称</th>
					<th>排序序号</th>
					<th>数据状态</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody id="datalist">

			</tbody>
			<script id="tradecent-template" type="text/x-handlebars-template">
			{{#each this}}
			<tr>
				<td><div class="label">
			 			<input id="{{id}}" name="radioItems" value="{{id}}" type="checkbox" class="check_btn check_item" >
						<label class="checkboxLable" for="{{id}}"></label>
					</div>
				</td>
				<td><div class='base-wrap'>{{addOne @index}}</div></td>
				<td><div class='base-wrap left' title='{{isNull code}}'>{{isNull code}}</div></td>
				<td><div class='base-wrap left' title='{{typeName}}'>{{typeName}}</div></td>
				<td><div class='base-wrap left'>{{orderNum}}</div></td>
				<td><div class='base-wrap left'>{{getStatus state}}</div></td>
				<td>
					<shiro:hasPermission name="monitorType:update"><span class="oper-handle iconfont icon-bianji base-yellow update" title='修改文档类型' data-pkid={{id}}></span></shiro:hasPermission>
					<shiro:hasPermission name="monitorType:delete"><span class="oper-handle iconfont icon-shanchu base-red delete" title='删除文档类型' data-pkid={{id}}></span></shiro:hasPermission>
					<shiro:hasPermission name="monitorType:detail"><span class="oper-handle iconfont icon-xiangqing base-blue detail" title='文档详情' data-pkid={{id}}></span></shiro:hasPermission>
					<shiro:hasPermission name="sysParam:sonParam"><span class="oper-handle iconfont icon-shouquanguanli base-green son-detail" title='查看所属文件' data-pkid={{id}}></span></shiro:hasPermission>
				</td>
			</tr>
			{{/each}}
		</script>
		</table>
	</div>
</div>
<!-- end列表界面 -->

<!-- 新增与详情页面 -->
<div id="data-form" data-title='文档类型新增'>
	<form id="form" class="layui-form-pane">
		<input type="hidden" name="id"> <input type="hidden"
			name="atiProjectStructure.id" id="atiProjectStructureId" />
		<div class="layui-row">
			<div class="layui-col-md6">
				<div class="layui-form-item">
					<label class="layui-form-label">文档类型</label>
					<div class="layui-input-block">
						<input name="typeName" class="layui-input validate require">
						<input name="projectId" id="project" class="layui-input validate "
							type="hidden">
					</div>
				</div>
			</div>
			<div class="layui-col-md6">
				<div class="layui-form-item">
					<label class="layui-form-label">文档编号</label>
					<div class="layui-input-block">
						<input name="code" class="layui-input validate require"
							data-exp="w{1-20}">
					</div>
				</div>
			</div>
			<div class="layui-col-md6">
				<div class="layui-form-item">
					<label class="layui-form-label">排序序号</label>
					<div class="layui-input-block">
						<input name="orderNum" class="layui-input validate require"
							data-exp="w{1-20}">
					</div>
				</div>
			</div>
		</div>
		<div class="layui-row">
			<div class="layui-col-md6">
				<div class="layui-form-item">
					<label class="layui-form-label">状态</label>
					<div class="layui-input-block">
						<select class="base-select validate require" name="state">
							<option value="1">有效</option>
							<option value="0">无效</option>
						</select>
					</div>
				</div>
			</div>
		</div>
	</form>
	<div id="toolbar" class="toolbar buttom-btn">
		<button id="btn_back" type="button" class="layui-btn layui-btn-warm"
			data-toggle="modal">返回</button>
		<button id="btn_save" type="button" class="layui-btn layui-btn-normal"
			data-toggle="modal">保存</button>
	</div>
</div>
<!--end新增与详情页面-->
<script type="text/javascript">
	$(function() {
		$("#strucId").val($("#structureId").val());
		$("#atiProjectStructureId").val($("#structureId").val());
		//getProjectStructure();
		$("#projectId").val($("#flagProjectId").val());
		$("#project").val($("#flagProjectId").val());
		$.baseEvent({
			ctx : '${ctx}',
			param : [ 'code', 'strucId', 'projectId' ],
			isPage : true,
			pageList_url : "/fileType/pageList",
			form_url : '/fileType/save',
			data_list : '${ctx}/route/manage/basedata/file_type',
			del_url : '/fileType/delete',
			findBy_url : '/fileType/findById',
			add_is_dialog : true
		});

		//全选/反选
		$("#checkAll").click(function() {
			$("input[name='radioItems']:checkbox").prop("checked", this.checked);
		});

		$('#btn_del').on('click', function() {
			var ids = [];
			$("input[name='radioItems']:checked").each(function() {
				ids.push($(this).attr("id"));
			});
			var deptId = "";
			if (ids.length > 0) {
				brigeTypeIds = ids.join(",");
				layer.confirm('你确要删除该数据吗？', {
					btn : [ '确定', '取消' ] //按钮
				}, function() {
					$.ajax({
						url : '${ctx}/photoType/delete',
						data : {
							ID : brigeTypeIds
						},
						dataType : 'json',
						success : function(res) {
							if (res.success == '1') {
								showOkTip(res.message);
								$('#btn_search').click();
							}
						},
					});
				});
			} else {
				alertWarn("请选择要删除的数据！");
			}
		})
	});
	//查看所属文件列表
	$('#datalist').on('click', '.son-detail', function() {
		var $_this = $(this);
		var id = $(this).data('pkid');
		$(".data-content").load("${ctx}/fileType/sonPageMain", {
			"id" : id
		});
	});
	function getProjectStructure() {
		var my = {
			url : "${ctx}/monitorType/getStrucList",
			callback : function(res) {
				for (var i = 0; i < res.data.length; i++) {
					$("#atiProjectStructureId").append("<option value='"+res.data[i].id+"'>"+res.data[i].name + "</option>");
				}
			}
		}
		$._NormalRequest(my);
	}
</script>
