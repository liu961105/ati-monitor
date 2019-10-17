<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/public/taglib.jspf"%>
<style>
@font-face {
  font-family: 'iconfont';  /* project id 875017 */
  src: url('//at.alicdn.com/t/font_875017_dcl9rtqdzp6.eot');
  src: url('//at.alicdn.com/t/font_875017_dcl9rtqdzp6.eot?#iefix') format('embedded-opentype'),
  url('//at.alicdn.com/t/font_875017_dcl9rtqdzp6.woff') format('woff'),
  url('//at.alicdn.com/t/font_875017_dcl9rtqdzp6.ttf') format('truetype'),
  url('//at.alicdn.com/t/font_875017_dcl9rtqdzp6.svg#iconfont') format('svg');
}
.icon-device {
	color: #333333;
	cursor:pointer;
}
.icon-personcfg {
	color: #5ac733;
	cursor:pointer;
}
.oper-no {
    cursor: not-allowed;
}
</style>
<!-- 列表界面 -->
<div id="data-list">
	<div class="banner">
		<span class="base-blue-01 base-search" data-title='班组信息'>班组信息列表查询</span>
	</div>
	<div class="base-form"> 
		<form id="fa-search" action="${ctx}/sysGroup/pageList" method="POST">
			<input type="hidden" id="wkspId" value="${wkspId}"/>
			<table class="base-table form search">
				<tr>
					<td class="td-bg" width="150">班组名称</td>
					<td class="left padding-l">
						<input	class="base-input" name="groupName" id="groupName" value="${groupName}">
					</td>
					<td class="td-bg" width="150">班组班长</td>
					<td class="left padding-l">
						<input	class="base-input" name="groupLeader" id="groupLeader" value="${groupLeader}">
					</td>
					<td class="center" rowspan="1" width="150">
						<button id="btn_search" type="button" class="layui-btn layui-btn-normal" data-toggle="modal"><i class="layui-icon layui-icon-search layuiadmin-button-btn"></i></button>
					</td>
				</tr>
			</table>
		</form>
	</div>
	<div class="banner">
		<span class="base-blue-01 base-search">班组信息列表</span>
		
		<div id="toolbar" class="toolbar">
		<shiro:hasPermission name="sysGroup:saveGroup">
			<button id="btn_add" type="button" class="base-btn base-bg-blue" data-toggle="modal">新增</button>
		</shiro:hasPermission>
		<shiro:hasPermission name="sysGroup:saveGroup">
			<button id="btn_del" type="button" class="base-btn base-bg-red" data-toggle="modal">删除</button>
		</shiro:hasPermission>
		</div>

	</div>
	<div id="list">
	<table class="list-table base-table">
		<thead>
			<tr>
				<th style="width:30px;"><div class="label"><input id="checkAll"  type="checkbox" class="check_btn"></div></th>
				<th width="60">序号</th>
				<th width="150">班组名称</th>
				<th width="150">班长名称</th>
				<th width="150">所属车间</th>
				<th width="100">操作</th>
			</tr>
		</thead>
		<tbody id="datalist">
		<c:forEach items="${page.content}" var ="groupE" varStatus="status">
			<tr>
				<td><div class="label">
						<input id="${groupE.groupId}" name="userItem" value="${groupE.groupId}" type="checkbox" class="check_btn check_item" >
					</div>
				</td>
				<td><div title="${status.count}" class='base-wrap'>${status.count}</div></td>
				<td><div title="${groupE.groupName}" class='base-wrap'>${groupE.groupName}</div></td>
				<td><div title="${groupE.groupLeader}" class='base-wrap'>${groupE.groupLeader}</div></td>
				<td><div title="${groupE.sysWorkshop.name}" class='base-wrap'>${groupE.sysWorkshop.name}</div></td>
				<td>
				<shiro:hasPermission name="sysGroup:updateGroup"><span class="oper-handle iconfont icon-bianji base-yellow update" title="修改班组信息" data-pkid="${groupE.groupId}"></span></shiro:hasPermission>
				<shiro:hasPermission name="sysGroup:deleteGroup"><span class="oper-handle iconfont icon-shanchu base-red delete" title="删除班组信息" data-pkid="${groupE.groupId}"></span></shiro:hasPermission>
				<shiro:hasPermission name="sysGroup:detailGroup"><span class="oper-handle iconfont icon-xiangqing base-blue detail" title="详情班组信息" data-pkid="${groupE.groupId}"></span></shiro:hasPermission>
				<shiro:hasPermission name="sysGroup:cfgUser"><span class="iconfont icon-personcfg usercfg" title="配置人员" data-pkid="${groupE.groupId}">&#xe62c;</span></shiro:hasPermission>
				</td>
			</tr>
		</c:forEach>	
		</tbody>
	</table>
	</div>
</div>
<!-- end列表界面 -->

<!-- 新增与详情页面 -->
<div id="data-form" data-title='新增班组信息'>
	<form id="form">
		<input type='hidden' name='groupId'>
		<input type='hidden' name='createUser' />
		<input type='hidden' name='createTime' />
		<table class="base-table form">
			<tr>
				<td class="td-bg hidetree" width="150">班组名称</td>
				<td class="left"><input name="groupName" class="base-input validate require hidetree" data-exp="w{2-20}"></td>
				<td class="td-bg hidetree" width="150">班长名称</td>
				<td class="left"><input name="groupLeader" class="base-input validate require hidetree" data-exp="w{1-20}"></td>
			</tr>
			<tr>
				<td class="td-bg hidetree" width="150">所属车间</td>
				<td class="left">
					<input name="workShopId" class="base-input validate require hidetree" type="text" id="workShopId">
					<!-- <input name=workShopName id="workShopName" class="base-input validate hidetree" data-exp="w{2-50}" readonly>
					<input name='workShopId' type="hidden" id="workShopId">
					<ul id="wkspTree" class="ztree ztree-position"></ul> -->
				</td>
			</tr>
		</table>
	</form>
	<div id="toolbar" class="toolbar buttom-btn">
			<button id="btn_save" type="button" class="base-btn base-bg-blue">保存</button>
		</div>
</div>
<!--end新增与详情页面-->
<script src="${ctx}/res/js/main.js"></script>
<script type="text/javascript">
$(function() {

	  	//全选/反选
		$("#checkAll").click(function() { 
		    $("input[name='userItem']:checkbox").prop("checked", this.checked); 
		});
		
		$('#btn_del').on('click',function(){
			var ids = [];
			$("input[name='userItem']:checked").each(function() {
				ids.push($(this).attr("id"));
			});
			
			var pkid = "";
			if (ids.length > 0) {
				pkid = ids.join(",");
				layer.confirm('你确要删除该数据吗？', {
	      		  btn: ['确定','取消']//按钮
	      		}, function(){					
					$.ajax({
				 		url:'${ctx}/sysGroup/deleteGroup',
				 		data:{"id":pkid},
				 		dataType:'json',
				 		success:function(res){
				 			if(res.success=='1'){
				 				showOkTip(res.message);
				 				$('#btn_search').click();
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


	$("#btn_search").click(function(){
		var wkspId = $("#wkspId").val();
		var groupName = $("#groupName").val();
		var groupLeader = $("#groupLeader").val();
		parent.$(".device-list-wrap").load("${ctx}/sysGroup/pageList",{"wkspId":wkspId,"groupName":groupName,"groupLeader":groupLeader});
	});
	//新增页面
	$("#btn_add").click(function(){
		$("#data-form").find('input,select,textarea').removeClass('oper-no');
		$("#data-form").find('input,select,textarea').removeAttr('readonly');
		$("#btn_save").show();
		$("#data-form").find("input,select,textarea").val("");
		layer.open({
		  type: 1,
		  area: ['900px', '300px'], //宽高
		  shade:false,
		  content: $("#data-form")
		});
	});
	
	//编辑页面
	$(".update").click(function(){
		var pkid = $(this).data("pkid");
		$('input,select,textarea').removeClass('oper-no');
		$('input,select,textarea').removeAttr('readonly');
		$("#btn_save").show();
		initData(pkid);
	});
	//详情页面
	$(".detail").click(function(){
		var pkid = $(this).data("pkid");
		$("#btn_save").hide();
		$('input,select,textarea').addClass('oper-no');
		$('input,select,textarea').attr('readonly','readonly');
		initData(pkid);
	})
	
	//班组删除
	$(".delete").click(function(){
		var wkspId = $("#wkspId").val();
		var pkid = $(this).data("pkid");
		layer.confirm('确定刪除吗？', {
			btn: ['确定','取消'] //按钮
		}, function(){
			$.ajax({
				url:"${ctx}/sysGroup/deleteGroup",
				type:"post",
				data:{"id":pkid},
				dataType:"json",
				success:function(data){
					if(data.success=="1"){
						parent.$(".device-list-wrap").load("${ctx}/sysGroup/pageList",{"wkspId":wkspId});
		 				layer.msg(data.message, {icon: 6});
					}else{
						layer.msg(data.message, {icon: 5});
					}
				},
				error:function(){
					layer.msg('网络异常，请稍后再试', {icon: 7});
				}
			})
		});
	})
	
	//表单保存
	$("#btn_save").click(function(){
		var wkspId = $("#wkspId").val();
		$.ajax({
			url:"${ctx}/sysGroup/saveGroup",
			type:"post",
			data:$("#form").serialize(),
			dataType:"json",
			success : function(res){
	 			if(res.success=='1'){
	 				parent.$(".device-list-wrap").load("${ctx}/sysGroup/pageList",{"wkspId":wkspId});
	 				layer.msg(res.message, {icon: 6},function(){
	 					parent.layer.closeAll();
	 				});
	 			}else{
	 				layer.msg(res.message, {icon: 5});
	 			}
	 		},
	 		error:function(){
	 			layer.msg('网络异常，请稍后再试', {icon: 7});
	 		}
		});
		
		
	});
	//人员配置
	$('.usercfg').on('click',function(){
		var groupId = $(this).data("pkid");
		layer.open({
			type: 2,
	        shade: false,
	        resize:true,
	        title: "<span class='dialog_title base-zb-info'>操作员分配</span>",
	        area: ['700px', '550px'],
	        content: "${ctx}/sysGroup/getUsercfgPage?groupId="+groupId,
	        /* cancel: function(index, layero){ 
			    $('#userOpen').hide();
			} */   
		});
	});
	
	//设备配置
	$('.devicecfg').on('click',function(){
		var groupId = $(this).data("pkid");
		layer.open({
			type: 2,
	        shade: false,
	        resize:true,
	        title: "<span class='dialog_title base-zb-info'>操作员分配</span>",
	        area: ['700px', '550px'],
	        content: "${ctx}/sysGroup/getDevicecfgPage?groupId="+groupId,
	        /* cancel: function(index, layero){ 
			    $('#userOpen').hide();
			} */   
		});
	});
});
	
	
function initData(id){
	$.ajax({
		url:"${ctx}/sysGroup/findGroup",
		type:"post",
		data:{"id":id},
		dataType:"json",
		success : function(res){
 			if(res.success=='1'){
 				if(res.data.sysWorkshop){
               		var workShopId=res.data.sysWorkshop.id;
                   	var workShopName=res.data.sysWorkshop.name;
                   	$("#workShopId").val(workShopId);
                   	$("#workShopName").val(workShopName);
               	}
               	$("#data-form").find("input[name='groupId']").val(res.data.groupId);
               	$("#data-form").find("input[name='groupName']").val(res.data.groupName);
               	$("#data-form").find("input[name='groupLeader']").val(res.data.groupLeader);
               	$("#data-form").find("input[name='createUser']").val(res.data.createUser);
               	$("#data-form").find("input[name='createTime']").val(res.data.createTime);
               	layer.open({
               		type: 1,
               		area: ['900px', '300px'], //宽高
               		shade:false,
               		content: $("#data-form")
				});
 			}else{
 				layer.msg(res.message, {icon: 5});
 			}
 		},
 		error:function(){
 			layer.msg('网络异常，请稍后再试', {icon: 7});
 		}
	});
}


//生成车间列表树
function createWkspTree(znode) {
	var setting = {
		check:{
              enable:false
        },
        data:    {
            simpleData:{
                enable:true
            }
        },
	  	view:{
	    	//showIcon: false,
	    	showLine: true,
	  	},
	  	callback:{    //第一步
	  		onClick:zTreeOnClick   
        }
	};
	var zNodes =[
		{
			name:"制造部", open:true,
			children: znode
		}
	];
	$.fn.zTree.init($("#wkspTree"), setting, zNodes);
				
}	

function zTreeOnClick(event, treeId, treeNode) {
	var wkspId=treeNode.id;
	var wkspName=treeNode.name;
	if(wkspId != null){
		$("#workShopId").val(wkspId);
		$("#workShopName").val(wkspName);
		$(".ztree-position").hide();
	}
};
</script>
