<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/public/taglib.jspf"%>
<!-- 列表界面 -->
<style>
/* #btn_back{
	display:none;
} */
</style>
<div id="data-list">
	<div class="banner layui-hide">
		<span class="base-blue-01 base-search" data-title='参数列表'>参数列表查询</span>
	</div>
	<div class="base-form"> 
		<form id="fa-search">
			<input type="hidden" id="paramId" name="paramId" value="${paramId}">
		</form>
	</div>
	<div class="banner">
		<span class="base-blue-01 base-search">参数列表</span>
	</div>
	<form id="fa-search" class="layui-form-pane" style="margin-top: 15px;">
		<div class="layui-form-item">
		    <div class="layui-inline layui-inline-right">
		    	<shiro:hasPermission name="sysParam:deleteParam">
					<button id="btn_del" type="button" class="layui-btn layui-btn-danger" data-toggle="modal">删除</button>
				</shiro:hasPermission>
			  	<shiro:hasPermission name="sysParam:saveParam">
					<button id="btn_add" type="button" class="layui-btn" data-toggle="modal">新增</button>
				</shiro:hasPermission>
				<button id="backToMain" type="button" class="layui-btn layui-btn-warm" data-toggle="modal">返回</button>
			  </div>
		  </div>
	</form>
	<div id="list">
		<input type="hidden" id="pid" value="${pid}">
		<input type="hidden" id="pname" value="${pname}">
		<table class="layui-table">
			<colgroup>
		      <col width="35">
		      <col width="60">
		      <col width="200">
		      <col width="200">
		      <col width="200">
		      <col width="150">
		      <col width="150">
		      <col width="150">
		    </colgroup>
		<thead>
			<tr>
				<th><div class="label"><input id="checkAll"  type="checkbox" class="check_btn"><label class="checkboxLable" for="checkAll"></label></div></th>
				<th>序号</th>
				<th>参数编码</th>
				<th>参数名称</th>
				<th>上级参数名称</th>
				<th>排序</th>
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
			 <input id="{{paramId}}" name="userItem" value="{{paramId}}" type="checkbox" class="check_btn check_item" >
			 <label class="checkboxLable" for="{{paramId}}"></label>
			</div>
		</td>
		<td><div class='base-wrap'>{{addOne @index}}</div></td>
		<td><div class='base-wrap left'>{{isNull paramCode}}</div></td>
		<td><div class='base-wrap left'>{{isNull paramName}}</div></td>
		<td><div class='base-wrap left'>{{isNull parentParam.paramName}}</div></td>
		<td><div class='base-wrap left'>{{orderNum}}</div></td>
		<td><div class='base-wrap'>{{getStatus status}}</div></td>
		<td>
		<shiro:hasPermission name="sysParam:updateParam"><span class="oper-handle iconfont icon-bianji base-yellow update-param" title='修改参数' data-pkid={{paramId}}></span></shiro:hasPermission>
		<shiro:hasPermission name="sysParam:deleteParam"><span class="oper-handle iconfont icon-shanchu base-red delete1" title='删除参数' data-pkid={{paramId}}></span></shiro:hasPermission>
		<shiro:hasPermission name="sysParam:detailParam"><span class="oper-handle iconfont icon-xiangqing base-blue detail-param" title='参数详情' data-pkid={{paramId}}></span></shiro:hasPermission>
		</td>
	</tr>
	{{/each}}		
	</script>
	</table>
	</div>
</div>
<!-- end列表界面 -->

<!-- 新增与详情页面 -->
<div id="data-form" data-title='新增参数'>
	<form id="form" class="layui-form-pane">
		<input type='hidden' name='paramId'>
		<input type='hidden' name='createUser' />
		<input type='hidden' name='createTime' />
		<input type='hidden' name='updateUser' />
		<input type='hidden' name='updateTime' />
		<div class="layui-row">
			<div class="layui-col-md6">
				<div class="layui-form-item">
					<label class="layui-form-label">上级参数</label>
					<div class="layui-input-block">
						<input name="parentParamPname" id="parentParamPname" data-id="paramName" class="layui-input pName validate require layui-disabled"  disabled="disabled">
						<ul id="tree" class="ztree ztree-position"></ul>
						<input name='parentParamPid' id="parentParamPid" class="pParamId" type="hidden"  data-id="paramId">
					</div>
			   	</div>
		    </div>
		    <div class="layui-col-md6">
			   <div class="layui-form-item">
					<label class="layui-form-label">参数编码</label>
					<div class="layui-input-block">
						<input name="paramCode"  class="layui-input validate require" data-exp="w{1-50}">
					</div>
			   </div>
		   </div>
	   </div>
	   <div class="layui-row">
			<div class="layui-col-md6">
				<div class="layui-form-item">
					<label class="layui-form-label">参数名称</label>
					<div class="layui-input-block">
						<input name="paramName" class="layui-input validate" data-exp="w{1-50}">
					</div>
			   	</div>
		    </div>
		    <div class="layui-col-md6">
			   <div class="layui-form-item">
					<label class="layui-form-label">状态</label>
					<div class="layui-input-block">
						<select class="base-select validate require"  name="status">
							<option value="1">可用</option>
							<option value="0">不可用</option>
						</select>
					</div>
			   </div>
		   </div>
	   </div>
	   <div class="layui-row">
			<div class="layui-col-md6">
				<div class="layui-form-item">
					<label class="layui-form-label">排序序号</label>
					<div class="layui-input-block">
						<input name="orderNum" class="layui-input validate" data-exp="w{1-50}">
					</div>
			   	</div>
		    </div>
	   </div>
	</form>
	<div id="toolbar" class="toolbar buttom-btn">
		<button id="btn_back1" type="button" class="layui-btn layui-btn-warm" data-toggle="modal">返回</button>
		<button id="btn_save1" type="button" class="layui-btn layui-btn-normal" data-toggle="modal">保存</button>	
	</div>
</div>
<!--end新增与详情页面-->
<script src="${ctx}/res/js/main.js"></script>
<script type="text/javascript">
	$(function() {
		$.baseEvent({
			ctx:'${ctx}',
			param:['paramName','pName','paramId'],
			isPage:true,
			pageList_url:"/sysParam/sonPageList",
			form_url:'/sysParam/saveParam',
			data_list:'${ctx}/route/manage/sys/sys_sonParamList',
			del_url:'/sysParam/delParam',
			findBy_url:'/sysParam/findParam',
			add_is_dialog:true
		});
		
/* 		
		//getDept();//上级参数
		$(".pName").on('click',function(){
			$("#tree").show();
			$.fn.zTree.init($("#tree"), setting);
		})
		//隐藏tree
	   $('.hidetree').click(function(){
			$(".topul").next().hide();
		});  */
		
		//全选/反选
		$("#checkAll").click(function() { 
		    $("input[name='userItem']:checkbox").prop("checked", this.checked); 
		});
		
		//单个删除
		$(document).on("click",".delete1",function(){
			var paramId = $(this).data("pkid");
			if (paramId != null && paramId != "") {
				layer.confirm('你确要删除该数据吗？', {
	      		  btn: ['确定','取消']//按钮
	      		}, function(){					
					$.ajax({
				 		url:'${ctx}/sysParam/delParam',
				 		data:{'ID':paramId},
				 		dataType:'json',
				 		success:function(res){
				 			if(res.success=='1'){
				 				showOkTip(res.message);
				 				$('#btn_back1').click();
				 			}else{
				 				showOkTip(res.message);
				 			}
				 		},
			  		});
	      		});
			}else{
				alertWarn("请选择要删除的数据！");
			}
		});
		
		//批量删除
		$('#btn_del').on('click',function(){
			var ids = [];
			$("input[name='userItem']:checked").each(function() {
				ids.push($(this).attr("id"));
			});
			
			var paramId = "";
			if (ids.length > 0) {
				paramId = ids.join(",");
				layer.confirm('你确要删除该数据吗？', {
	      		  btn: ['确定','取消']//按钮
	      		}, function(){					
					$.ajax({
				 		url:'${ctx}/sysParam/delParam',
				 		data:{'ID':paramId},
				 		dataType:'json',
				 		success:function(res){
				 			if(res.success=='1'){
				 				showOkTip(res.message);
				 				$('#btn_back1').click();
				 			}else{
				 				showOkTip(res.message);
				 			}
				 		},
			  		});
	      		});
			}else{
				alertWarn("请选择要删除的数据！");
			}
		});
		
		$('#datalist').on('click', '.detail-param,.update-param', function() {
			var paramId = '${paramId}';
			var $_this = $(this);
            var my = {
                url: "${ctx}/sysParam/findParam",
                para: {
                    "ID": $(this).data('pkid'),
                },
                callback: function(res) {
               		layer.open({
               			type: 1,
               			shade: false,
               			title: "<span class='dialog_title base-zb-info'>"+$_this.attr("title")+"</span>",
               			area: ['60%', '58%'],
               			content: $('#data-form'),
               			/* end : function() {
               				$(".data-content").gotoNewLink({
               					url: "${ctx}/sysParam/sonPageMain",
               					data:{"paramId":paramId}
               				})
               			} */
               		});
               		$.setValue(res.data);
               		if($_this.is(".detail-param")){
                    	$("#btn_save").hide();
                    	$("#btn_save1").hide();
                    	$('input,select,textarea').addClass('oper-no');
            			$('input,select,textarea').attr('readonly','readonly');
            			$('select').attr('disabled',"true");
                    }
                	if($_this.is(".update-param")){
                    	$("#btn_save").show();
                    	$("#btn_save1").show();
                    	$('input,select,textarea').removeClass('oper-no');
            			$('input,select,textarea').removeAttr('readonly');
            			$('select').removeAttr('disabled');
                    }
                }
            }
            $._NormalRequest(my);
        })
		
	});
	
	$("#backToMain").click(function(){
		 $(".data-content").load("${ctx}/route/manage/sys/sys_paramList");
	})
	
	$("#btn_back1").click(function(){
		var paramId = '${paramId}';
		$(".data-content").load("${ctx}/sysParam/sonPageMain",{"paramId":paramId});
	})
	
	$("#btn_save1").click(function(){
		var paramId = '${paramId}';
		$.ajax({
                url: "${ctx}/sysParam/saveParam",
                type:"post",
                data: $("#form").serialize(),
                dataType: "json",
                success: function(res) {
                    layer.msg(res.message);
					if(res.success == '1'){
						$(".data-content").load("${ctx}/sysParam/sonPageMain",{"paramId":paramId});
					}
                },
                error: function(XMLHttpRequest, textStatus, errorThrown) {
                    layer.msg(res.message);
                }
            });
	})
	
	
	$('#btn_add').click(function(){
		var pname = '${pname}';
		var pid =  '${paramId}';
		$('input[name="parentParamPname"]').val(pname);
		$('input[name="parentParamPid"]').val(pid);
	});
</script>
