<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/public/taglib.jspf"%>
<!-- 列表界面 -->
<div id="data-list">
	<div class="banner">
		<span class="base-blue-01 base-search" data-title='邮件服务列表'>邮件服务列表</span>
	</div>
	<form id="fa-search" class="layui-form-pane" style="margin-top: 15px;">
		<input type="hidden" name="id" id="">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">服务账号</label>
				<div class="layui-input-inline">
					<input type="text" name="serviceNum" id="serviceNum"
						autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-inline">
				<button id="btn_search" type="button"
					class="layui-btn layui-btn-normal" data-toggle="modal">
					<i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
				</button>
			</div>
			<div class="layui-inline layui-inline-right">
				<shiro:hasPermission name="emailService:save">
					<button id="btn_add" type="button" class="layui-btn"
						data-toggle="modal">新增</button>
				</shiro:hasPermission>
				<shiro:hasPermission name="emailService:delete">
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
				<col width="150">
				<col width="120">
				<col width="150">
				<col width="220">
				<col width="80">
				<col width="80">
			</colgroup>
			<thead>
				<tr>
					<th><div class="label">
							<input id="checkAll" lay-skin="primary" type="checkbox"
								class="check_btn"> <label class="checkboxLable"
								for="checkAll"></label>
						</div></th>
					<th>序号</th>
					<th>服务账号</th>
					<th>授权码</th>
					<th>主题</th>
					<th>模板内容</th>
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
				<td><div class='base-wrap left' title='{{isNull serviceNum}}'>{{isNull serviceNum}}</div></td>
				<td><div class='base-wrap left' title='{{authorizationCode}}'>{{authorizationCode}}</div></td>
				<td><div class='base-wrap left' title='{{subject}}'>{{subject}}</div></td>
				<td><div class='base-wrap left' title='{{content}}'>{{content}}</div></td>
				<td><div class='base-wrap left'>{{getStatus state}}</div></td>
				<td>
					<shiro:hasPermission name="emailService:update"><span class="oper-handle iconfont icon-bianji base-yellow update" title='修改邮件' data-pkid={{id}}></span></shiro:hasPermission>
					<shiro:hasPermission name="emailService:delete"><span class="oper-handle iconfont icon-shanchu base-red delete" title='删除邮件' data-pkid={{id}}></span></shiro:hasPermission>
					<shiro:hasPermission name="emailService:detail"><span class="oper-handle iconfont icon-xiangqing base-blue detail" title='详情' data-pkid={{id}}></span></shiro:hasPermission>
				</td>
			</tr>
			{{/each}}
		</script>
		</table>
	</div>
</div>
<!-- end列表界面 -->

<!-- 新增与详情页面 -->
<div id="data-form" data-title='邮件服务新增'>
	<form id="form" class="layui-form-pane">
		<input type="hidden" name="id">
		<div class="layui-row">
			<div class="layui-col-md6">
				<div class="layui-form-item">
					<label class="layui-form-label">服务账号</label>
					<div class="layui-input-block">
						<input name="serviceNum" class="layui-input validate require">
					</div>
				</div>
			</div>
			<div class="layui-col-md6">
				<div class="layui-form-item">
					<label class="layui-form-label">授权码</label>
					<div class="layui-input-block">
						<input name="authorizationCode"
							class="layui-input validate require" data-exp="w{2-20}">
					</div>
				</div>
			</div>
		</div>
		<div class="layui-row">
			<div class="layui-col-md6">
				<div class="layui-form-item">
					<label class="layui-form-label">主题</label>
					<div class="layui-input-block">
						<input name="subject" class="layui-input validate require"
							data-exp="w{2-20}">
					</div>
				</div>
			</div>
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
		<div class="layui-row">
			<div class="layui-col-md6">
				<div class="layui-form-item">
					<label class="layui-form-label">内容模板</label>
					<div class="layui-input-block">
						<textarea rows="" cols="" name="content" style="height: 250px; width: 600px;"></textarea>
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
<script src="${ctx}/res/js/main.js"></script>
<script type="text/javascript">
	$(function() {
		$.baseEvent({
			ctx : '${ctx}',
			param : [ 'serviceNum' ],
			isPage : true,
			pageList_url : "/emailService/pageList",
			form_url : '/emailService/save',
			data_list : '${ctx}/route/manage/basedata/email_list',
			del_url : '/emailService/delete',
			findBy_url : '/emailService/findById',
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
						url : '${ctx}/emailService/delete',
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
</script>
