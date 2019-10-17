<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/public/taglib.jspf"%>
<!-- 列表界面 -->
<div id="data-list">
	<div class="banner">
		<span class="base-blue-01 base-search" data-title='监测项列表'>监测项列表</span>
	</div>
	<form id="fa-search" class="layui-form-pane">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">监测类型</label>
				<div class="layui-input-inline">
					<select class="base-select" name="typeId" id="typeId">
						<option value="">请选择监测类型</option>
					</select>
				</div>
				<label title="监测项名称" class="layui-form-label">监测项名称</label>
				<div class="layui-input-inline">
					<input type="text" name="name" id="name" autocomplete="off"
						class="layui-input">
				</div>
			</div>
			<div class="layui-inline">
				<button id="btn_search" type="button"
					class="layui-btn layui-btn-normal" data-toggle="modal">
					<i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
				</button>
			</div>
			<div class="layui-inline layui-inline-right">
				<shiro:hasPermission name="monitorItem:save">
					<button id="btn_add" type="button" class="layui-btn"
						data-toggle="modal">新增</button>
				</shiro:hasPermission>
				<shiro:hasPermission name="monitorItem:delete">
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
					<th><div class="label">
							<input id="checkAll" lay-skin="primary" type="checkbox"
								class="check_btn"> <label class="checkboxLable"
								for="checkAll"></label>
						</div></th>
					<th>序号</th>
					<th>结构类型</th>
					<th>监测类型</th>
					<th>监测项名称</th>
					<th>监测项编码</th>
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
			 			<input id="{{id}}" name="monitorItemItem" value="{{id}}" type="checkbox" class="check_btn check_item" >
						<label class="checkboxLable" for="{{id}}"></label>
					</div>
				</td>
				<td><div class='base-wrap'>{{addOne @index}}</div></td>
				<td><div class='base-wrap left' title='{{isNull atiMonitorType.atiProjectStructure.name}}'>{{isNull atiMonitorType.atiProjectStructure.name}}</div></td>
				<td><div class='base-wrap left' title='{{isNull atiMonitorType.name}}'>{{isNull atiMonitorType.name}}</div></td>
				<td><div class='base-wrap left' title='{{name}}'>{{name}}</div></td>
				<td><div class='base-wrap left' title='{{code}}'>{{code}}</div></td>
				<td><div class='base-wrap left' title='{{getStatus state}}'>{{getStatus state}}</div></td>
				<td>
				<shiro:hasPermission name="monitorItem:update"><span class="oper-handle iconfont icon-bianji base-yellow update" title='修改监测项' data-pkid={{id}}></span></shiro:hasPermission>
				<shiro:hasPermission name="monitorItem:delete"><span class="oper-handle iconfont icon-shanchu base-red delete" title='删除监测项' data-pkid={{id}}></span></shiro:hasPermission>
				<shiro:hasPermission name="monitorItem:detail"><span class="oper-handle iconfont icon-xiangqing base-blue detail" title='详情监测项' data-pkid={{id}}></span></shiro:hasPermission>
			</td>
			</tr>
			{{/each}}
		</script>
		</table>
	</div>
</div>
<!-- end列表界面 -->

<!-- 新增与详情页面 -->
<div id="data-form" data-title='监测项新增'>
	<form id="form" class="layui-form-pane">
		<input type='hidden' name='id'>
		<div class="layui-row">
			<div class="layui-col-md6">
				<div class="layui-form-item">
					<label title="监测项名称" class="layui-form-label">监测项名称</label>
					<div class="layui-input-block">
						<input name="name" id="itemName" onkeyup="pinyin();"
							class="layui-input validate require" data-exp="w{2-20}">
					</div>
				</div>
			</div>
			<div class="layui-col-md6">
				<div class="layui-form-item">
					<label title="监测项编号" class="layui-form-label">监测项编号</label>
					<div class="layui-input-block">
						<input name="code" id="partCode"
							class="layui-input validate" data-exp="w{2-20}">
					</div>
				</div>
			</div>
		</div>
		<div class="layui-row">
			<div class="layui-col-md6">
				<div class="layui-form-item">
					<label class="layui-form-label">监测类型</label>
					<div class="layui-input-block">
						<select class="base-select" name="atiMonitorType.id"
							id="monitorTypeId">
							<option value="">请选择监测类型</option>
						</select>
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
	getMonitorType();
	$.baseEvent({
		ctx:'${ctx}',
		param:['name','typeId'],
		isPage:true,
		pageList_url:"/monitorItem/pageList",
		form_url:'/monitorItem/save',
		data_list:'${ctx}/route/manage/basedata/monitor_item_list',
		del_url:'/monitorItem/delete',
		findBy_url:'/monitorItem/findById',
		add_is_dialog:true
	});
	
	//全选/反选
	$("#checkAll").click(function() { 
	    $("input[name='monitorItemItem']:checkbox").prop("checked", this.checked); 
	});
	
	$('#btn_del').on('click',function(){
		var ids = [];
		$("input[name='monitorItemItem']:checked").each(function() {
			ids.push($(this).attr("id"));
		});
		var deptId = "";
		if (ids.length > 0) {
			brigeTypeIds = ids.join(",");
			layer.confirm('你确要删除该数据吗？', {
      		  btn: ['确定','取消']//按钮
      		}, function(){					
				$.ajax({
			 		url:'${ctx}/monitorItem/delete',
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

	function getMonitorType() {
		var my = {
				url : "${ctx}/monitorType/getTypeList",
				para : {'structId':$("#structureId").val()},
				callback : function(res) {
					if (res.data) {
						var html = '<option value="">请选择监测类型</option>';
						var v = res.data;
						for (var i=0; i<v.length; i++) {
							html += '<option value="'+v[i].id+'">'+v[i].name + '</option>';
						}
						$("#typeId").html(html);
						$("#monitorTypeId").html(html);
					}
				}
			}
			$._MultAjax(my);
	}
	
function pinyin(){
    var nameDish = document.getElementById("itemName").value;
    var str = "";
    for(var i=0; i< nameDish.length; i++) {
        var nameDish2 = codefans_net_CC2PY(nameDish.charAt(i));
        nameDish2 = nameDish2.substring(0,1);
        str += nameDish2;
        
    }
   //$("#partCode").val(str.toLocaleLowerCase());
    $("#partCode").val(str);
}

	
</script>
