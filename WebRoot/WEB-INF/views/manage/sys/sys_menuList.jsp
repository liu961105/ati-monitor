<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/public/taglib.jspf"%>
<!-- 列表界面 -->
<div id="data-list">
	<div class="banner layui-hide">
		<span class="base-blue-01 base-search" data-title='菜单管理'>菜单列表查询</span>
	</div>
	<div class="banner">
		<span class="base-blue-01 base-search">菜单列表</span>
	</div>
	<form id="fa-search" class="layui-form-pane" style="margin-top: 15px;">
		<div class="layui-form-item">
		    <div class="layui-inline">
		      <label class="layui-form-label">菜单名称</label>
		      <div class="layui-input-inline">
		        <input type="text" name="name" id="name" autocomplete="off" class="layui-input">
		      </div>
		    </div>
		    <div class="layui-inline">
		      <label class="layui-form-label">上级菜单名称</label>
		      <div class="layui-input-inline">
		        <input type="text" name="pName" id="pName" autocomplete="off" class="layui-input"/>
		      </div>
		    </div>
		    <div class="layui-inline">
		    	<button id="btn_search" type="button" class="layui-btn layui-btn-normal" data-toggle="modal"><i class="layui-icon layui-icon-search layuiadmin-button-btn"></i></button>
		    </div>
		    <div class="layui-inline layui-inline-right">
			  	<shiro:hasPermission name="sysMenu:saveMenu">
					<button id="btn_add" type="button" class="layui-btn" data-toggle="modal">新增</button>
				</shiro:hasPermission>
				<shiro:hasPermission name="sysMenu:delMenu">
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
		      <col width="160">
		      <col width="130">
		      <col width="250">
		      <col width="60">
		      <col width="70">
		      <col width="200">
		      <col width="70">
		      <col width="110">
		    </colgroup>
		<thead>
			<tr>
				<th><div class="label"><input id="checkAll"  type="checkbox" class="check_btn"><label class="checkboxLable" for="checkAll"></label></div></th>
				<th>序号</th>
				<th>菜单名称</th>
				<th>上级菜单名称</th>
				<th>URL地址</th>
				<th>排序</th>
				<th>菜单类型</th>
				<th>权限字符串</th>
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
			 <input id="{{menuId}}" name="userItem" value="{{menuId}}" type="checkbox" class="check_btn check_item" >
			 <label class="checkboxLable" for="{{menuId}}"></label>
			</div>
		</td>
		<td><div class='base-wrap'>{{addOne @index}}</div></td>
		<td><div class='base-wrap left' title="{{name}}">{{name}}</div></td>
		<td><div class='base-wrap left' title="{{isNull parentMenu.name}}">{{isNull parentMenu.name}}</div></td>
		<td><div class='base-wrap left' title="{{isNull url}}">{{isNull url}}</div></td>
		<td><div class='base-wrap left' title="{{isNull priority}}">{{isNull priority}}</div></td>
		<td><div class='base-wrap'>{{getType type}}</div></td>
		<td><div class='base-wrap left' title="{{permission}}">{{permission}}</div></td>
		<td><div class='base-wrap'>{{getStatus status}}</div></td>
		<td>
		<shiro:hasPermission name="sysMenu:updateMenu"><span class="oper-handle iconfont icon-bianji base-yellow update" title='修改菜单' data-pkid={{menuId}}></span></shiro:hasPermission>
		<shiro:hasPermission name="sysMenu:deleteMenu"><span class="oper-handle iconfont icon-shanchu base-red delete" title='删除菜单' data-pkid={{menuId}}></span></shiro:hasPermission>
		<shiro:hasPermission name="sysMenu:detailMenu"><span class="oper-handle iconfont icon-xiangqing base-blue detail" title='详情菜单' data-pkid={{menuId}}></span></shiro:hasPermission>
		</td>
	</tr>
	{{/each}}		
	</script>
	</table>
	</div>
</div>
<!-- end列表界面 -->

<!-- 新增与详情页面 -->
<div id="data-form" data-title='新增菜单'>
	<form id="form" class="layui-form-pane" >
		<input type='hidden' name='menuId'>
		<div class="layui-row">
			<div class="layui-col-md6">
				<div class="layui-form-item">
					<label class="layui-form-label">上级菜单</label>
					<div class="layui-input-block">
						<input name="parentMenuPname"  data-id="name" class="layui-input pName validate require">
						<ul id="tree" class="ztree ztree-position"></ul>
						<input name='parentMenuPid' class="pMenuId" type="hidden"  data-id="menuId">
					</div>
			   	</div>
		    </div>
		    <div class="layui-col-md6">
			   <div class="layui-form-item">
					<label class="layui-form-label">菜单名称</label>
					<div class="layui-input-block">
						<input name="name"  class="layui-input validate require" data-exp="w{2-20}">
					</div>
			   </div>
		   </div>
	   </div>
	   <div class="layui-row">
			<div class="layui-col-md6">
				<div class="layui-form-item">
					<label class="layui-form-label">URL地址</label>
					<div class="layui-input-block">
						<input name="url" class="layui-input validate" data-exp="w{2-50}">
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
					<label class="layui-form-label">权限字符串</label>
					<div class="layui-input-block">
						<input name="permission" class="layui-input validate" data-exp="w{1-50}">
					</div>
			   	</div>
		    </div>
		    <div class="layui-col-md6">
			   <div class="layui-form-item">
					<label class="layui-form-label">菜单类型</label>
					<div class="layui-input-block">
						<select class="base-select validate require"  name="type">
							<option value="1">菜单</option>
							<option value="0">按钮</option>
						</select>
					</div>
			   </div>
		   </div>
	   </div>
	   <div class="layui-row">
			<div class="layui-col-md6">
				<div class="layui-form-item">
					<label class="layui-form-label">一级菜单图标</label>
					<div class="layui-input-block">
						<input name="icon" class="layui-input validate require" data-exp="w{1-50}">
					</div>
			   	</div>
		    </div>
		    <div class="layui-col-md6">
			   <div class="layui-form-item">
					<label class="layui-form-label">是否动态菜单</label>
					<div class="layui-input-block">
						<select class="base-select validate require"  name="isIframe">
							<option value="1">是</option>
							<option value="0">否</option>
						</select>
					</div>
			   </div>
		   </div>
	   </div>
	   <div class="layui-form-item">
			<label class="layui-form-label">排序序号</label>
			<div class="layui-input-block">
				<input name="priority" class="layui-input validate require" data-exp="w{1-50}">
			</div>
	   </div>
	   <div class="layui-form-item layui-form-text">
	   		<label class="layui-form-label">菜单描述</label>
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
	$(function() {
		$.baseEvent({
			ctx:'${ctx}',
			param:['name','pName'],
			isPage:true,
			pageList_url:"/sysMenu/pageList",
			form_url:'/sysMenu/saveMenu',
			data_list:'${ctx}/route/manage/sys/sys_menuList',
			del_url:'/sysMenu/delMenu',
			findBy_url:'/sysMenu/findMenu',
			add_is_dialog:true
		});
		//getDept();//上级菜单
		$(".pName").on('click',function(){
			$("#tree").show();
			$.fn.zTree.init($("#tree"), setting);
		})
		//隐藏tree
	   $('.hidetree').click(function(){
			$(".topul").next().hide();
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
			
			var menuId = "";
			if (ids.length > 0) {
				menuId = ids.join(",");
				layer.confirm('你确要删除该数据吗？', {
	      		  btn: ['确定','取消']//按钮
	      		}, function(){					
					$.ajax({
				 		url:'${ctx}/sysMenu/delMenu',
				 		data:{ID:menuId},
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
		});
		
	});
	
	function getDept() {
		var my = {
				url : "${ctx}/sysMenu/findTopList",
				callback : function(res) {
					for (var i = 0; i < res.data.length; i++) {
						$("#pId").append(
								"<option value='"+res.data[i].menuId+"'>"
								      + res.data[i].name + "</option>");
					}
				}
		}
		$._NormalRequest(my);
	}
	
	/**************************ztree************************************/
    var setting = {
        view: {
            dblClickExpand: false,
            showLine: true,
            selectedMulti: false
        },
        data: {
            simpleData: {
                enable: true,
                idKey: "menuId",
                pIdKey: "pid",
                rootPId: ""
            },
            key: {
                title: "name",
                name: "name"
            },
        },
        async: { //ztree异步请求数据 
            enable: true,
            dataFilter: ajaxDataFilter, //预处理数据
            url: "${ctx}/sysMenu/findAll", //请求action方法 
            autoparam: ["data"]
        },
        callback: {
            beforeClick: beforeClick
        }
    };
    /* 获取返回的数据，进行预操作 */
    function ajaxDataFilter(treeId, parentNode, responseData) {
        responseData = responseData.data;
        return responseData;
    };
    //异步加载完成时运行，此方法将所有的节点打开
    function zTreeOnAsyncSuccess(event, treeId, msg) {
        var treeObj = $.fn.zTree.getZTreeObj("tree");
        treeObj.expandAll(true);
        treeObj.checkNode(treeId, !treeId.checked, null, true);
        //详情界面
        var my = {
            url: "${ctx}/sysRole/findAuthority",
            para: {
                "roleId": $("input[name='roleId']").val()
            },
            callback: function(res) {
                res.data.memus.map(function(v, i) {
                    var node = treeObj.getNodeByParam("menuId", v.menuId);
                    treeObj.checkNode(node, true, true);
                    treeObj.updateNode(node);
                })
            }
        }
        $._NormalRequest(my);
    }

    function beforeClick(treeId, treeNode) {
    	var pMenuId = $(".pMenuId");
    	pMenuId.val(treeNode.menuId);
    	$(".pName").val(treeNode.name);
    	$("#"+treeId).hide();
    	var menuId = $("input[name='menuId']").val();
    	if(pMenuId.val() && pMenuId.val()==menuId){
    		pMenuId.val("");
    		$(".pName").val("");
			layer.tips('上级菜单和本级菜单不能一样,请重新选择上级菜单', "input[name='parentMenuPname']");
		}
        var zTree = $.fn.zTree.getZTreeObj("tree");
        zTree.checkNode(treeNode, !treeNode.checked, null, true);
        return false;
    }
    /*******************************************************************/
</script>
