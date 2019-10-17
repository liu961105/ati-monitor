<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/public/taglib.jspf"%>
<!-- 列表界面 -->
<div id="data-list">
	<div class="banner" style="display:none;">
		<span class="base-blue-01 base-search" data-title='日志列表'>日志列表查询</span>
	</div>
	<div class="banner">
		<span class="base-blue-01 base-search">日志列表</span>
	</div>
	<form id="fa-search" class="layui-form-pane" style="margin-top: 15px;">
		<div class="layui-form-item">
		    <div class="layui-inline">
		      <label class="layui-form-label">操作用户</label>
		      <div class="layui-input-inline">
		        <input type="text" name="createuser" id="createuser" autocomplete="off" class="layui-input">
		      </div>
		    </div>
		    <div class="layui-inline">
		      <label class="layui-form-label">操作方式</label>
		      <div class="layui-input-inline">
		        <input type="text" name="businssName" id="businssName" autocomplete="off" class="layui-input"/>
		      </div>
		    </div>
		    <div class="layui-inline">
		    	<button id="btn_search" type="button" class="layui-btn layui-btn-normal" data-toggle="modal"><i class="layui-icon layui-icon-search layuiadmin-button-btn"></i></button>
		    </div>
		  </div>
	</form>
	<div id="list">
	<table class="layui-table">
			<colgroup>
		      <col width="60">
		      <col>
		      <col>
		      <col>
		      <col>
		    </colgroup>
		<thead>
			<tr>
				<th>序号</th>
				<th>操作用户</th>
				<th>操作时间</th>
				<th>操作方式</th>
				<th>是否成功</th>
			</tr>
		</thead>
		<tbody id="datalist">
			
		</tbody>
	<script id="tradecent-template" type="text/x-handlebars-template">
	{{#each this}}
	<tr>
		<td><div class='base-wrap'>{{addOne @index}}</div></td>
		<td><div class='base-wrap left'>{{isNull createuser}}</div></td>
		<td><div class='base-wrap left'>{{isNull createtime}}</div></td>
		<td><div class='base-wrap left'>{{isNull businssName}}</div></td>
		<td><div class='base-wrap'>{{isSuccess}}</div></td>
	</tr>
	{{/each}}		
	</script>
	</table>
	</div>
</div>
<!-- end列表界面 -->

<!--end新增与详情页面-->
<script type="text/javascript">
	$(function() {
		$.baseEvent({
			ctx:'${ctx}',
			param:['createuser','businssName'],
			isPage:true,
			pageList_url:"/sysLog/pageList",
			data_list:'${ctx}/route/manage/sys/sys_paramList',
			add_is_dialog:true
		})
	});
</script>

