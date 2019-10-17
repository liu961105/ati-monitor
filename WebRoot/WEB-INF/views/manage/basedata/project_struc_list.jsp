<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/public/taglib.jspf"%>
<!-- 列表界面 -->
<div id="data-list">
	<div class="banner">
		<span class="base-blue-01 base-search" data-title='结构类型列表'>结构类型列表</span>
	</div>
	<form id="fa-search" class="layui-form-pane" style="margin-top: 15px;">
		<div class="layui-form-item">
		    <div class="layui-inline">
		      <label class="layui-form-label">结构类型名称</label>
		      <div class="layui-input-inline">
		        <input type="text" name="name" id="name" autocomplete="off" class="layui-input">
		      </div>
		    </div>
		    <div class="layui-inline">
		    	<button id="btn_search" type="button" class="layui-btn layui-btn-normal" data-toggle="modal"><i class="layui-icon layui-icon-search layuiadmin-button-btn"></i></button>
		    </div>
		    <div class="layui-inline layui-inline-right">
			  	<shiro:hasPermission name="projectStruc:save">
					<button id="btn_add" type="button" class="layui-btn" data-toggle="modal">新增</button>
				</shiro:hasPermission>
				<shiro:hasPermission name="projectStruc:delete">
					<button id="btn_del" type="button" class="layui-btn layui-btn-danger" data-toggle="modal">删除</button>
				</shiro:hasPermission>
			  </div>
		  </div>
	</form>
	<div id="list">
		<table class="layui-table"> 
			<colgroup>
		       <col width="60">
		       <col width="60">
		      <!--<col width="60">
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
						<input id="checkAll" lay-skin="primary" type="checkbox" class="check_btn">
						<label class="checkboxLable" for="checkAll"></label>
					</div></th>
					<th>序号</th>
					<th>结构类型名称</th>
					<th>结构类型编号</th>
					<th>状态</th>
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
				<td><div class='base-wrap left' title='{{name}}'>{{name}}</div></td>
				<td><div class='base-wrap left' title='{{code}}'>{{code}}</div></td>
				<td><div class='base-wrap left' title='{{getStatus state}}'>{{getStatus state}}</div></td>
				<td>
				<shiro:hasPermission name="projectStruc:update"><span class="oper-handle iconfont icon-bianji base-yellow update" title='修改结构类型' data-pkid={{id}}></span></shiro:hasPermission>
				<shiro:hasPermission name="projectStruc:delete"><span class="oper-handle iconfont icon-shanchu base-red delete" title='删除结构类型' data-pkid={{id}}></span></shiro:hasPermission>
				<shiro:hasPermission name="projectStruc:detail"><span class="oper-handle iconfont icon-xiangqing base-blue detail" title='详情结构类型' data-pkid={{id}}></span></shiro:hasPermission>
			</td>
			</tr>
			{{/each}}
		</script>
		</table>
	</div>
</div>
<!-- end列表界面 -->

<!-- 新增与详情页面 -->
<div id="data-form" data-title='结构类型新增'>
	<form id="form" class="layui-form-pane">
		<input type='hidden' name='id'>
		<div class="layui-row">
			<div class="layui-col-md6">
				<div class="layui-form-item">
					<label class="layui-form-label">结构类型名称</label>
					<div class="layui-input-block">
						<input name="name"  class="layui-input validate require" data-exp="w{2-20}">
					</div>
			   	</div>
		    </div>
		    <div class="layui-col-md6">
			   <div class="layui-form-item">
					<label class="layui-form-label">结构类型编号</label>
					<div class="layui-input-block">
						<input name="code"  class="layui-input validate require" data-exp="w{2-20}">
					</div>
			   </div>
		   </div>
		</div>
	   <div class="layui-row">
		   <div class="layui-col-md6">
			   <div class="layui-form-item">
					<label class="layui-form-label">有效状态</label>
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
		<button id="btn_back" type="button" class="layui-btn layui-btn-warm" data-toggle="modal">返回</button>
		<button id="btn_save" type="button" class="layui-btn layui-btn-normal" data-toggle="modal">保存</button>	
	</div>
</div>
<!--end新增与详情页面-->
<script src="${ctx}/res/js/main.js"></script>
<script type="text/javascript">
$(function() {
	$.baseEvent({
		ctx:'${ctx}',
		param:['name'],
		isPage:true,
		pageList_url:"/projectStructure/pageList",
		form_url:'/projectStructure/save',
		data_list:'${ctx}/route/manage/basedata/project_struc_list',
		del_url:'/projectStructure/delete',
		findBy_url:'/projectStructure/findById',
		add_is_dialog:true
	});
	
	//全选/反选
	$("#checkAll").click(function() { 
	    $("input[name='radioItems']:checkbox").prop("checked", this.checked); 
	});
	
	$('#btn_del').on('click',function(){
		var ids = [];
		$("input[name='radioItems']:checked").each(function() {
			ids.push($(this).attr("id"));
		});
		var deptId = "";
		if (ids.length > 0) {
			brigeTypeIds = ids.join(",");
			layer.confirm('你确要删除该数据吗？', {
      		  btn: ['确定','取消']//按钮
      		}, function(){					
				$.ajax({
			 		url:'${ctx}/projectStruc/delete',
			 		data:{ID:brigeTypeIds},
			 		dataType:'json',
			 		success:function(res){
			 			if(res.success=='1'){
			 				showOkTip(res.message);
			 				$('#btn_search').click();
			 			}
			 		},
		  		});
      		});
		}else{
			alertWarn("请选择要删除的数据！");
		}
	})
});
	
</script>