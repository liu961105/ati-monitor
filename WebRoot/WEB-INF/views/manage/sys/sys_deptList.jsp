<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/public/taglib.jspf"%>
<!-- 列表界面 -->
<div id="data-list">
	<div class="banner layui-hide">
		<span class="base-blue-01 base-search" data-title='部门列表'>部门列表查询</span>
	</div>
	<div class="banner">
		<span class="base-blue-01 base-search">部门列表</span>
	</div>
	<form id="fa-search" class="layui-form-pane" style="margin-top: 15px;">
		<div class="layui-form-item">
		    <div class="layui-inline">
		      <label class="layui-form-label">部门名称</label>
		      <div class="layui-input-inline">
		        <input type="text" name="name" id="name" autocomplete="off" class="layui-input">
		      </div>
		    </div>
		    <div class="layui-inline">
		      <label class="layui-form-label">创建日期</label>
		      <div class="layui-input-inline">
		        <input type="text" name="createTime" id="createTime" autocomplete="off" class="layui-input"  onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})"/>
		      </div>
		    </div>
		    <div class="layui-inline">
		    	<button id="btn_search" type="button" class="layui-btn layui-btn-normal" data-toggle="modal"><i class="layui-icon layui-icon-search layuiadmin-button-btn"></i></button>
		    </div>
		    <div class="layui-inline layui-inline-right">
			  	<shiro:hasPermission name="sysDept:saveDept">
					<button id="btn_add" type="button" class="layui-btn" data-toggle="modal">新增</button>
				</shiro:hasPermission>
				<shiro:hasPermission name="sysDept:delDept">
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
		      <col width="200">
		      <col width="200">
		      <col width="200">
		      <col width="150">
		      <col width="150">
		      <col width="110">
		    </colgroup>
			<thead>
				<tr>
					<th><div class="label">
						<input id="checkAll" lay-skin="primary" type="checkbox" class="check_btn">
						<label class="checkboxLable" for="checkAll"></label >
					</div></th>
					<th>序号</th>
					<th>部门名称</th>
					<th>上级部门名称</th>
					<th>描述</th>
					<th>创建时间</th>
					<th>修改时间</th>
					<th>部门操作</th>
				</tr>
			</thead>
			<tbody id="datalist">
				
			</tbody>
			<script id="tradecent-template" type="text/x-handlebars-template">
			{{#each this}}
			<tr>
				<td><div class="label">
			 			<input id="{{deptId}}" name="userItem" value="{{deptId}}" type="checkbox" class="check_btn check_item" >
						<label class="checkboxLable" for="{{deptId}}"></label>
					</div>
				</td>
				<td><div class='base-wrap'>{{addOne @index}}</div></td>
				<td><div class='base-wrap left' title='{{name}}'>{{name}}</div></td>
				<td><div class='base-wrap left' title='{{isNull parentDept.name}}'>{{isNull parentDept.name}}</div></td>
				<td><div class='base-wrap left'>{{remark}}</div></td>
				<td><div class='base-wrap'>{{createTime}}</div></td>
				<td><div class='base-wrap'>{{updateTime}}</div></td>		
				<td>
				<shiro:hasPermission name="sysDept:updateDept"><span class="oper-handle iconfont icon-bianji base-yellow update" title='修改部门' data-pkid={{deptId}}></span></shiro:hasPermission>
				<shiro:hasPermission name="sysDept:deleteDept"><span class="oper-handle iconfont icon-shanchu base-red delete" title='删除部门' data-pkid={{deptId}}></span></shiro:hasPermission>
				<shiro:hasPermission name="sysDept:detailDept"><span class="oper-handle iconfont icon-xiangqing base-blue detail" title='详情部门' data-pkid={{deptId}}></span></shiro:hasPermission>
			</td>
			</tr>
			{{/each}}		
		</script>
		</table>
	</div>
</div>
<!-- end列表界面 -->

<!-- 新增与详情页面 -->
<div id="data-form" data-title='部门新增'>
	<form id="form" class="layui-form-pane">
		<input type='hidden' name='deptId'>
		<div class="layui-form-item">
				<label class="layui-form-label">上级部门</label>
				<div class="layui-input-block">
					<select class="base-select base-select-fa"  name="parentDeptIds" id="deptIds" data-id="deptId"><option value="">请选择</option></select>
				</div>
	   </div>
	   <div class="layui-form-item">
			<label class="layui-form-label">部门名称</label>
			<div class="layui-input-block">
				<input name="name"  class="layui-input validate require" data-exp="w{2-20}">
			</div>
	   </div>
	   <div class="layui-form-item">
			<label class="layui-form-label">部门编码</label>
			<div class="layui-input-block">
				<input name="deptCode" class="layui-input validate require" data-exp="w{2-20}">
			</div>
	   </div>
	   <div class="layui-form-item layui-form-text">
	   		<label class="layui-form-label">部门描述</label>
	    	<div class="layui-input-block">
	      		<textarea placeholder="请输入描述内容" class="layui-textarea" name="remark"></textarea>
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
/*   var form = layui.form
  ,layer = layui.layer; */
   
	$(function() {
		getDept();
		$.baseEvent({
			ctx:'${ctx}',
			param:['name','createTime'],
			isPage:true,
			pageList_url:"/sysDept/pageList",
			form_url:'/sysDept/saveDept',
			data_list:'${ctx}/route/manage/sys/sys_deptList',
			del_url:'/sysDept/delDept',
			findBy_url:'/sysDept/findDept',
			add_is_dialog:true
		});
		
		//防止选择重复部门
		$("#deptIds").on('change',function(){
			
			var deptId = $("input[name='deptId']").val();
			var selectedVal = $(this).val();
			if(selectedVal && selectedVal==deptId){
				$(this).val("");
				layer.tips('上级部门和本级部门不能一样', '#deptIds');
			}
		})
						

		$('#img_view').on('click',function(){
			layer.open({
			  type: 1,
			  skin: 'layui-layer-demo', //样式类名
			  closeBtn: 0, //不显示关闭按钮
			  anim: 2,
			  shadeClose: true, //开启遮罩关闭
			  area: ['80%', '90%'],
			  content: '<img src="${ctx}/res/img/dept/zhjg.png">'
			});
		});
		
		//全选/反选
		$("#checkAll").click(function() { 
		    $("input[name='userItem']:checkbox").prop("checked", this.checked); 
		});
		
		$('#btn_del').on('click',function(){
			var ids = [];
			$("input[name='userItem']:checked").each(function() {
				ids.push($(this).attr("id"));
			});
			var deptId = "";
			if (ids.length > 0) {
				professionId = ids.join(",");
				layer.confirm('你确要删除该数据吗？', {
	      		  btn: ['确定','取消']//按钮
	      		}, function(){					
					$.ajax({
				 		url:'${ctx}/sysDept/delDept',
				 		data:{ID:professionId},
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
	
	//查找部门
	function getDept() {
		var my = {
				url : "${ctx}/sysDept/findTopList",
				callback : function(res) {
					for (var i = 0; i < res.data.length; i++) {
						$("#deptIds").append(
								"<option value='"+res.data[i].deptId+"'>"
								      + res.data[i].name + "</option>");
					}
				}
		}
		$._NormalRequest(my);
	}
	
</script>
