<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/public/taglib.jspf"%>
<!-- 列表界面 -->
<div id="data-list">
	<div class="banner layui-hide">
		<span class="base-blue-01 base-search" data-title='岗位列表'>岗位列表</span>
	</div>
	<div class="banner">
		<span class="base-blue-01 base-search">岗位列表</span>
	</div>
	<form id="fa-search" class="layui-form-pane" style="margin-top: 15px;">
		<div class="layui-form-item">
		    <div class="layui-inline">
		      <label class="layui-form-label">岗位名</label>
		      <div class="layui-input-inline">
		        <input type="text" name="name" id="name" autocomplete="off" class="layui-input">
		      </div>
		    </div>
		    <div class="layui-inline">
		    	<button id="btn_search" type="button" class="layui-btn layui-btn-normal" data-toggle="modal"><i class="layui-icon layui-icon-search layuiadmin-button-btn"></i></button>
		    </div>
		    <div class="layui-inline layui-inline-right">
			  	<shiro:hasPermission name="sysProfession:saveProfession">
					<button id="btn_add" type="button" class="layui-btn" data-toggle="modal">新增</button>
				</shiro:hasPermission>
				<shiro:hasPermission name="sysProfession:deleteProfession">
					<button id="btn_del" type="button" class="layui-btn layui-btn-danger" data-toggle="modal">删除</button>
				</shiro:hasPermission>
			  </div>
		  </div>
	</form>
	<div id="list">
		<table class="layui-table">
			<colgroup>
		      <col width="50">
		      <col width="60">
		      <col width="150">
		      <col width="100">
		      <col width="200">
		      <col width="150">
		      <col width="300">
		      <col width="150">
		      <col width="110">
		    </colgroup>

		<thead>
			<tr>
				<th><div class="label"><input id="checkAll"  type="checkbox" class="check_btn"><label class="checkboxLable" for="checkAll"></label></div></th>
				<th>序号</th>
				<th>岗位名</th>
				<th>岗位编号</th>
				<th>上级组织</th>
				<th>所属部门</th>
				<th>描述</th>
				<th>创建时间</th>
				<th>操作</th>
			</tr>
		</thead>
		<tbody id="datalist">
			
		</tbody>
		<script id="tradecent-template" type="text/x-handlebars-template">
	{{#each this}}
	<tr data-id="{{professionId}}">
		<td><div class="label">
			 <input id="{{professionId}}" name="userItem" value="{{professionId}}" type="checkbox" class="check_btn check_item" >
			 <label class="checkboxLable" for="{{professionId}}"></label>
			</div>
		</td>
		<td><div class='base-wrap'>{{addOne @index}}</div></td>
		<td><div class='base-wrap left' title='{{name}}'>{{name}}</div></td>
		<td><div class='base-wrap'>{{code}}</div></td>
        <td><div class='base-wrap'>{{isNull parentProfession.name}}</div></td>
        <td><div class='base-wrap'>{{isNull dept_name}}</div></td>
		<td><div class='base-wrap'>{{remark}}</div></td>
		<td><div class='base-wrap'>{{createTime}}</div></td>
		<td>
		<shiro:hasPermission name="sysProfession:updateProfession"><span class="oper-handle iconfont icon-bianji base-yellow update" title='修改岗位' data-pkid={{professionId}}></span></shiro:hasPermission>
		<shiro:hasPermission name="sysProfession:deleteProfession"><span class="oper-handle iconfont icon-shanchu base-red delete" title='删除岗位' data-pkid={{professionId}}></span></shiro:hasPermission>
		<shiro:hasPermission name="sysProfession:detailProfession"><span class="oper-handle iconfont icon-xiangqing base-blue detail" title='详情' data-pkid={{professionId}}></span></shiro:hasPermission>
		</td>
	</tr>
	{{/each}}		
	</script>
	</table>
	</div>
</div>
<!-- end列表界面 -->

<!-- 新增与详情页面 -->
<div id="data-form" class="data-form"  data-title='新增岗位'>
	<form id="form" class="layui-form-pane">
		<input type='hidden' name='professionId'>
		<div class="layui-row">
			<div class="layui-col-md6">
				<div class="layui-form-item">
					<label class="layui-form-label">岗位名</label>
					<div class="layui-input-block">
						<input name="name" id="checkProfession" class="layui-input validate require" data-exp="w{2-20}">
					</div>
			   	</div>
		    </div>
		    <div class="layui-col-md6">
			   <div class="layui-form-item">
					<label class="layui-form-label">岗位编号</label>
					<div class="layui-input-block">
						<input name="code"  class="layui-input validate" data-exp="w{2-20}">
					</div>
			   </div>
		   </div>
	   </div>
	   <div class="layui-row">
			<div class="layui-col-md6">
				<div class="layui-form-item">
					<label class="layui-form-label">上级组织名</label>
					<div class="layui-input-block">
						<select class="base-select"  name="parentDeptIds" id="parentProfessionId">
							<option value="">请选择</option>
						</select>
					</div>
			   	</div>
		    </div>
		    <div class="layui-col-md6">
			   <div class="layui-form-item">
					<label class="layui-form-label">所属部门</label>
					<div class="layui-input-block">
						<select class="base-select" name="deptId" id="sysDeptIds">
							<option value="">请选择</option>
						</select>
					</div>
			   </div>
		   </div>
		   <div class="layui-col-md6">
			   <div class="layui-form-item">
					<label class="layui-form-label">是否可用</label>
					<div class="layui-input-block">
						<select class="base-select"  name="status">
						    <option value="1">是</option>
							<option value="0">否</option>
						</select>
					</div>
			   </div>
			</div>
			<div class="layui-col-md12">
				<div class="layui-form-item layui-form-text">
					<label class="layui-form-label">备注</label>
					<div class="layui-input-block">
			      		<textarea placeholder="请输入内容" class="layui-textarea" name="remark"></textarea>
			    	</div>
			   </div>
			</div>
	   </div>
	</form>
	<!-- <form id="form">
		<table class="base-table form">
			<input type='hidden' name='professionId'>
			<tr>
				<td class="td-bg" width="150">岗位名</td>
				<td class="left"><input  name="name"
					class="base-input validate require" id="checkProfession" data-exp="w{2-20}"></td>
				<td width="150">岗位编号</td>
				<td><input type="text" name="code"
					class="base-input validate"></td>
			</tr>
			<tr>
				<td class="td-bg" width="150">上级组织名</td>
				<td class="padding-l">
				<select class="base-select"  name="parentDeptIds" id="parentProfessionId">
				<option value="">请选择</option></select></td>
			</tr>
			<tr>
				<td class="td-bg" width="150">所属部门</td>
				<td class="padding-l"><select class="base-select"  name="deptId" id="sysDeptIds">
				<option value="">请选择</option>
				</select></td>
				<td width="150">是否可用</td>
				<td>
					<select class="base-select"  name="status">
					    <option value="是">是</option>
						<option value="否">否</option>
					</select>
				</td>
			</tr>
			<tr>
				<td width="150">备注</td>
				<td colspan="3">
					<textarea rows="" cols="" class="base-textarea" name="remark"></textarea> 
				</td>
				
			</tr>
		</table>
	</form> -->
	<div class="toolbar buttom-btn">
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
			param:['name','createTime'],
			isPage:true,
			pageList_url:"/sysProfession/pageList",
			form_url:'/sysProfession/saveProfession',
			data_list:'${ctx}/route/manage/sys/sys_professionList',
			del_url:'/sysProfession/delProfession',
			findBy_url:'/sysProfession/findProfession',
			add_is_dialog:true
		});
		getDept();
		getParentId();
		
		
		//全选/反选
		$("#checkAll").click(function() { 
		    $("input[name='userItem']:checkbox").prop("checked", this.checked); 
		});
		
		$('#btn_del').on('click',function(){
			var ids = [];
			$("input[name='userItem']:checked").each(function() {
				ids.push($(this).attr("id"));
			});
			
			var professionId = "";
			if (ids.length > 0) {
				professionId = ids.join(",");
				layer.confirm('你确要删除该数据吗？', {
	      		  btn: ['确定','取消']//按钮
	      		}, function(){					
					$.ajax({
				 		url:'${ctx}/sysProfession/delProfession',
				 		data:{ID:professionId},
				 		dataType:'json',
				 		success:function(res){
				 			if(res.success=='1'){
				 				showOkTip("删除成功");
				 				$('#btn_search').click();
				 			}
				 		},
			  		});
	      		});
			}else{
				alertWarn("请选择要删除的数据！");
			}
		});
		
	});	
		
	//查找部门
	function getDept() {
		var my = {
				url : "${ctx}/sysDept/findTopList",
				callback : function(res) {
					for (var i = 0; i < res.data.length; i++) {
						$("#sysDeptIds").append(
								"<option value='"+res.data[i].deptId+"'>"
								      + res.data[i].name + "</option>");
					}
				}
		}
		$._NormalRequest(my);
	}
	
	//查找岗位
	function getParentId() {
		var my = {
				url : "${ctx}/sysProfession/findTopList",
				callback : function(res) {
					for (var i = 0; i < res.data.length; i++) {
						$("#parentProfessionId").append(
								"<option value='"+res.data[i].professionId+"'>"
								      + res.data[i].name + "</option>");
					}
				}
		}
		$._NormalRequest(my);
	}

</script>