<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/public/taglib.jspf"%>
<!-- 列表界面 -->
<div id="data-list">
	<div class="banner layui-hide">
		<span class="base-blue-01 base-search" data-title='参数列表'>参数列表查询</span>
	</div>
	<div class="banner">
		<span class="base-blue-01 base-search">参数列表</span>
	</div>
	<form id="fa-search" class="layui-form-pane" style="margin-top: 15px;">
		<div class="layui-form-item">
		    <div class="layui-inline">
		      <label class="layui-form-label">参数名称</label>
		      <div class="layui-input-inline">
		        <input type="text" name="paramName" id="paramName" autocomplete="off" class="layui-input">
		      </div>
		    </div>
		    <div class="layui-inline">
		      <label class="layui-form-label">参数编码</label>
		      <div class="layui-input-inline">
		        <input type="text" name="paramCode" id="paramCode" autocomplete="off" class="layui-input">
		      </div>
		    </div>
		    <div class="layui-inline">
		    	<button id="btn_search" type="button" class="layui-btn layui-btn-normal" data-toggle="modal"><i class="layui-icon layui-icon-search layuiadmin-button-btn"></i></button>
		    </div>
		    <div class="layui-inline layui-inline-right">
			  	<shiro:hasPermission name="sysParam:saveParam">
					<button id="btn_add" type="button" class="layui-btn" data-toggle="modal">新增</button>
				</shiro:hasPermission>
				<shiro:hasPermission name="sysParam:deleteParam">
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
		      <col width="150">
		      <col width="80">
		      <col width="100">
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
		<shiro:hasPermission name="sysParam:updateParam"><span class="oper-handle iconfont icon-bianji base-yellow update" title='修改参数' data-pkid={{paramId}}></span></shiro:hasPermission>
		<shiro:hasPermission name="sysParam:deleteParam"><span class="oper-handle iconfont icon-shanchu base-red delete" title='删除参数' data-pkid={{paramId}}></span></shiro:hasPermission>
		<shiro:hasPermission name="sysParam:detailParam"><span class="oper-handle iconfont icon-xiangqing base-blue detail" title='参数详情' data-pkid={{paramId}}></span></shiro:hasPermission>
		<shiro:hasPermission name="sysParam:sonParam"><span class="oper-handle iconfont icon-shouquanguanli base-green son-detail" title='查看子级元素' data-pkid={{paramId}}></span></shiro:hasPermission>
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
						<input name="parentParamPname" data-id="paramName" class="layui-input pName validate require">
						<ul id="tree" class="ztree ztree-position"></ul>
						<input name='parentParamPid' class="pParamId" type="hidden"  data-id="paramId">
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
			param:['paramName','paramCode'],
			isPage:true,
			pageList_url:"/sysParam/pageList",
			form_url:'/sysParam/saveParam',
			data_list:'${ctx}/route/manage/sys/sys_paramList',
			del_url:'/sysParam/delParam',
			findBy_url:'/sysParam/findParam',
			add_is_dialog:false
		});
		//getDept();//上级参数
		$(".pName").on('click',function(){
			$("#tree").show();
			$.fn.zTree.init($("#tree"), setting);
		})
		//隐藏tree
	   $('.hidetree').click(function(){
			$(".topul").next().hide();
		}); 
		
		//查看子级参数列表
		$('#datalist').on('click', '.son-detail', function() {
  	        var $_this = $(this);
  	        var paramId = $(this).data('pkid');
  	        $(".data-content").load("${ctx}/sysParam/sonPageMain",{"paramId":paramId});
  	        //$(".data-content").load("${ctx}/route/manage/sys/sys_sonParamList",{"paramId":paramId});
            /* if (true) {
                layer.open({
                    type: 2,
                    shade: false,
                    title: "<span class='dialog_title base-zb-info'>" + $_this.attr("title")+ "</span>",
                    area: ['55%', '80%'],
                    content: '${ctx}/sys/departmentTableList?companyId='+companyId
                });
            } */
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
    	
	});
	
	function getDept() {
		var my = {
				url : "${ctx}/sysParam/findTopList",
				callback : function(res) {
					for (var i = 0; i < res.data.length; i++) {
						$("#pId").append(
								"<option value='"+res.data[i].paramCode+"'>"
								      + res.data[i].paramName + "</option>");
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
                idKey: "param_id",
                pIdKey: "parent_code",
                rootPId: ""
            },
            key: {
                title: "param_name",
                name: "param_name"
            },
        },
        async: { //ztree异步请求数据 
            enable: true,
            dataFilter: ajaxDataFilter, //预处理数据
            url: "${ctx}/sysParam/findAll", //请求action方法 
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
                    var node = treeObj.getNodeByParam("parentCode", v.menuId);
                    treeObj.checkNode(node, true, true);
                    treeObj.updateNode(node);
                })
            }
        }
        $._NormalRequest(my);
    }

    function beforeClick(treeId, treeNode) {
    	var pParamId = $(".pParamId");
    	pParamId.val(treeNode.param_id);
    	$(".pName").val(treeNode.param_name);
    	$("#"+treeId).hide();
    	var paramCode = $("input[name='paramId']").val();
    	if(pParamId.val() && pParamId.val()==param_id){
    		pParamId.val("");
    		$(".pName").val("");
			layer.tips('上级参数和本级参数不能一样,请重新选择上级参数', "input[name='parentParamPname']");
		}
        var zTree = $.fn.zTree.getZTreeObj("tree");
        zTree.checkNode(treeNode, !treeNode.checked, null, true);
        return false;
    }
    /*******************************************************************/
</script>
