<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/public/taglib.jspf"%>
<!-- 列表界面 -->
<div id="data-list">
	<div class="banner layui-hide">
		<span class="base-blue-01 base-search" data-title='项目管理'>项目管理</span>
	</div>
	<div class="banner">
		<span class="base-blue-01 base-search">项目列表</span>
	</div>
	<form id="fa-search" class="layui-form-pane" style="margin-top: 15px;">
		<div class="layui-form-item">
			<div class="layui-inline">
				<label class="layui-form-label">项目名称</label>
				<div class="layui-input-inline">
					<input type="text" name="projectName" id="projectName"
						autocomplete="off" class="layui-input">
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">项目地址</label>
				<div class="layui-input-inline">
					<input type="text" name="address" id="address" autocomplete="off"
						class="layui-input" />
				</div>
			</div>
			<div class="layui-inline">
				<label class="layui-form-label">项目状态</label>
				<div class="layui-input-inline">
					<select class="base-select validate require" id="projectStatus"
						name="projectStatus">
						<option value="">全部</option>
						<option value="0">正常</option>
						<option value="1">警告</option>
					</select>
				</div>
			</div>
			<div class="layui-inline">
				<button id="btn_search" type="button"
					class="layui-btn layui-btn-normal" data-toggle="modal">
					<i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
				</button>
			</div>
			<div class="layui-inline layui-inline-right">
				<shiro:hasPermission name="project:saveProject">
					<button id="btn_add" type="button" class="layui-btn"
						data-toggle="modal">新增</button>
				</shiro:hasPermission>
				<shiro:hasPermission name="project:delProjectBatch">
					<button id="btn_del" type="button"
						class="layui-btn layui-btn-danger" data-toggle="modal">删除</button>
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
				<col width="80">
				<col width="90">
				<col width="250">
			</colgroup>
			<thead>
				<tr>
					<th><div class="label">
							<input id="checkAll" type="checkbox" class="check_btn"><label
								class="checkboxLable" for="checkAll"></label>
						</div></th>
					<th>序号</th>
					<th>项目名称</th>
					<th>地址</th>
					<th>项目状态</th>
					<th>项目负责人</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody id="datalist">

			</tbody>
			<script id="tradecent-template" type="text/x-handlebars-template">
                {{#each this}}
                <tr>
                    <td><div class="label">
                        <input id="{{id}}" name="userItem" value="{{id}}" type="checkbox" class="check_btn check_item" >
                        <label class="checkboxLable" for="{{id}}"></label>
                    </div>
                    </td>
                    <td><div class='base-wrap'>{{addOne @index}}</div></td>
                    <td><div class='base-wrap left' title="{{projectName}}">{{projectName}}</div></td>
                    <td><div class='base-wrap left' title="{{address}}">{{address}}</div></td>
                    <td><div class='base-wrap left' title="{{stateStr}}">{{stateStr}}</div></td>
                    <td><div class='base-wrap left' title="{{structureName}}">{{structureName}}</div></td>
                    <td>
                        <shiro:hasPermission name="projectinfo:update"><span class="oper-handle iconfont icon-bianji base-yellow update" title='修改项目' data-pkid={{id}}></span></shiro:hasPermission>
                        <shiro:hasPermission name="projectinfo:delete"><span class="oper-handle iconfont icon-shanchu base-red delete" title='删除项目' data-pkid={{id}}></span></shiro:hasPermission>
                        <shiro:hasPermission name="projectinfo:detail"><span class="oper-handle iconfont icon-xiangqing base-blue detail" title='项目详情' data-pkid={{id}}></span></shiro:hasPermission>
						<shiro:hasPermission name="projectinfo:paramConfig"><button type="button" class="layui-btn layui-btn-xs layui-btn-normal config-param" data-toggle="modal" data-pkid={{id}}>配置监测参数</button></shiro:hasPermission>
						<shiro:hasPermission name="projectinfo:deviceConfig"><button type="button" class="layui-btn layui-btn-xs layui-btn-warm config-device" data-toggle="modal" data-pkid={{id}}>关联设备</button></shiro:hasPermission>
						<shiro:hasPermission name="projectinfo:siteConfig"><button type="button" class="layui-btn layui-btn-xs layui-btn-warm config-monitorSites" data-toggle="modal" data-pkid={{id}}>配置监测点位</button></shiro:hasPermission>
                    </td>
                </tr>
                {{/each}}
            </script>
		</table>
	</div>
</div>
<!-- end列表界面 -->

<!-- 新增与详情页面 -->
<div id="data-form" data-title='新增项目'>
	<form id="form" class="layui-form-pane">
		<div class="layui-row">
			<div class="layui-col-md6">
				<div class="layui-form-item">
					<label class="layui-form-label">项目名称</label>
					<input type="hidden" id="projectStructureId" name="projectStructureId"/>
					<div class="layui-input-block">
						<input name="projectName" data-id="projectName"
							class="layui-input pName validate require"> <input
							name='id' class="id" type="hidden" data-id="id">
					</div>
				</div>
			</div>
			<div class="layui-col-md6">
				<div class="layui-form-item">
					<label class="layui-form-label">项目地址</label>
					<div class="layui-input-block">
						<input name="address" class="layui-input validate require"
							data-exp="w{2-20}">
					</div>
				</div>
			</div>
		</div>
		<div class="layui-row">
			<div class="layui-col-md6">
				<div class="layui-form-item">
					<label class="layui-form-label">经度</label>
					<div class="layui-input-block">
						<input name="longitude" class="layui-input validate"
							data-exp="w{1-50}">
					</div>
				</div>
			</div>
			<div class="layui-col-md6">
				<div class="layui-form-item">
					<label class="layui-form-label">纬度</label>
					<div class="layui-input-block">
						<input name="latitude" class="layui-input validate"
							   data-exp="w{1-50}">
					</div>
				</div>
			</div>
		</div>
		<div class="layui-row">
			<div class="layui-col-md6">
				<div class="layui-form-item">
					<label class="layui-form-label">项目状态</label>
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

<!-- start监测参数树  -->
<div id="configParams" style="position: relative;height: 100%;display:none;">
	<div style="position: absolute;top: 0;">
		<ul id="tree" class="ztree"
			style="position: relative;bottom: 60px;margin-top:60px;height:250px"></ul>
	</div>
	<form id="paramForm">
		<input type="hidden" name="configProjectId" id="configProjectId">
		<input type="hidden" name="paramIds" />
	</form>
	<div class="toolbar buttom-btn">
		<button id="btn_cancel" type="button" class="layui-btn layui-btn-warm"
			data-toggle="modal">取消</button>
		<button id="param_save" type="button"
			class="layui-btn layui-btn-normal" data-toggle="modal">保存</button>
	</div>
</div>
<!-- end监测参数树 -->

<!-- start 关联设备树  -->
<div id="configDevices" style="position: relative;height: 100%;display:none;">
	<div style="position: absolute;top: 0;">
		<ul id="devicetree" class="ztree"
			style="position: relative;bottom: 60px;margin-top:60px;height:250px"></ul>
	</div>
	<form id="deviceForm">
		<input type="hidden" name="configProjectId" id="configProjectId1">
		<input type="hidden" name="paramDeviceIds" />
	</form>
	<div class="toolbar buttom-btn">
		<button id="btn_cancel1" type="button" class="layui-btn layui-btn-warm"
			data-toggle="modal">取消</button>
		<button id="device_save" type="button"
			class="layui-btn layui-btn-normal" data-toggle="modal">保存</button>
	</div>
</div>
<!-- end 关联设备树 -->
<script src="${ctx}/res/js/main.js"></script>
<script type="text/javascript">
	$(function() {
		$.baseEvent({
			ctx : '${ctx}',
			param : [ 'projectName', 'address', 'projectStatus'],
			isPage : true,
			pageList_url : "/atiProject/projectPageInfo"+"?projectStructureId="+$("#structureId").val(),
			form_url : '/atiProject/saveProjectInfo',
			data_list : '${ctx}/route/project/atiproject',
			del_url : '/atiProject/delProjectInfo',
			findBy_url : '/atiProject/findProjectInfo',
			add_is_dialog : true
		});



		//全选/反选
		$("#checkAll").click(function() {
			$("input[name='userItem']:checkbox").prop("checked", this.checked);
		});

		$('#btn_del').on('click', function() {
			var ids = [];
			$("input[name='userItem']:checked").each(function() {
				ids.push($(this).attr("id"));
			});

			var projectId = "";
			if (ids.length > 0) {
				projectId = ids.join(",");
				layer.confirm('你确要删除该数据吗？', {
					btn : [ '确定', '取消' ] //按钮
				}, function() {
					$.ajax({
						url : '${ctx}/atiProject/delProjectInfo',
						data : {
							ID : projectId
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
		});


		//绑定项目所属类型的option
		var projectStructureUrl = "${ctx}/projectStructure/findAll";
		$.post(projectStructureUrl, {}, function(data) {
			if (data.success == '1') {
				data = data.data;
				for (var i = 0; i < data.length; i++) {
					var item = $("<option></option>");
					item.val(data[i]["id"]);
					item.text(data[i]["name"]);
					$(".projectStructure").append(item)
				}
			}
		})

	});
</script>
<script type="text/javascript">
var structId = $("#structureId").val();
$(function(){

    $("#projectStructureId").val($("#structureId").val());
	//权限赋值
    $('#datalist').on('click', '.config-param', function() {
        var $_this = $(this);
        var projectId = $_this.data("pkid");
        $('#configProjectId').val(projectId);
        var roleName = $_this.parents("tr").find("#roleName").text();
        $_this.show();
        $("#configParams").data("title",$_this.attr("title"));
        $("input[name='roleId']").val($_this.data("pkid"));
        if (true) {
            layer.open({
                type: 1,
                shade: false,
                title: "<span class='dialog_title base-zb-info'>参数配置</span>",
                area: ['40%', '70%'],
                content: $('#configParams')
            });
        }
        $.fn.zTree.init($("#tree"), setting);
    });
    //保存方法
    $('#param_save').on('click', function() {

        var my = {
            form: "paramForm",
            url: "${ctx}/projectConfigParam/saveMonitorParam",
            callback: function(res) {
                if (res.success == '1') {
                    layer.closeAll();
                }
                layer.msg(res.message);
            }
        }
        $._FormRequest(my);
    });
    
    
    /**************************ztree************************************/
    var setting = {
        view: {
            dblClickExpand: false,
            showLine: true,
            selectedMulti: false
        },
        check: {
            enable: true,
            chkStyle: "checkbox", //复选框
        	chkboxType: { "Y": "ps", "N": "ps" }
        	//chkboxType: { "Y" : "p", "N" : "ps" }
        },
        data: {
            simpleData: {
                enable: true,
                idKey: "tld",
                pIdKey: "pId",
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
            url: "${ctx}/projectConfigParam/getTree?pid="+structId, //请求action方法 
            autoparam: ["data"]
        },
        callback: {
            //onClick : zTreeOnClick,
            //beforeClick: beforeClick,
            onCheck: onCheck,
            onAsyncSuccess: zTreeOnAsyncSuccess
            //异步加载完成调用
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
        treeObj.checkNode(treeId, !treeId.checked, null, true);
        //详情界面
        var my = {
            url: "${ctx}/projectConfigParam/getConfigParam",
            para: {
                "projectId": $("#configProjectId").val()
            },
            callback: function(res) {
                if (res.success == '1') {
                	res.data.map(function(v, i) {
                        var node = treeObj.getNodeByParam("tld", v.monitorParamId);
                        treeObj.checkNode(node, true, true);
                        treeObj.updateNode(node);
                    })
                }
            }
        }
        $._MultAjax(my);
    }

    function beforeClick(treeId, treeNode) {
        var zTree = $.fn.zTree.getZTreeObj("tree");
        zTree.checkNode(treeNode, !treeNode.checked, null, true);
        return false;
    }

    function onCheck(e, treeId, treeNode) {
    	var checkedItems = '';
    	var zTree = $.fn.zTree.getZTreeObj("tree");
        zTree.getChangeCheckedNodes().map(function(i, v) {
        	if (i.isLast == 'true') {
        		checkedItems += i.id + ',';
            }
        });
        if (checkedItems) checkedItems = checkedItems.substr(0,checkedItems.length-1);
        $("input[name='paramIds']").val(checkedItems);
    }
    /*******************************end ztree************************************/
})
</script>
<script type="text/javascript">
var structId = $("#structureId").val();
$(function(){
	//权限赋值
    $('#datalist').on('click', '.config-device', function() {
        var $_this = $(this);
        var projectId = $_this.data("pkid");
        $('#configProjectId1').val(projectId);
        var roleName = $_this.parents("tr").find("#roleName").text();
        $_this.show();
        $("#configDevices").data("title",$_this.attr("title"));
        $("input[name='roleId']").val($_this.data("pkid"));
        if (true) {
            layer.open({
                type: 1,
                shade: false,
                title: "<span class='dialog_title base-zb-info'>关联设备</span>",
                area: ['40%', '70%'],
                content: $('#configDevices')
            });
        }
        $.fn.zTree.init($("#devicetree"), setting1);
    });

    //查看配置设备
    $('#datalist').on('click', '.config-monitorSites', function(){
        $(".data-content").gotoNewLink({
            url: "${ctx}/route/project/projectdevice?projectId="+$(this).attr("data-pkid"),
			data:{projectId:$(this).attr("data-pkid")}
        });
    })
    //保存方法
    $('#device_save').on('click', function() {
        var my = {
            form: "deviceForm",
            url: "${ctx}/projectConfigDevice/saveProjectDevice",
            callback: function(res) {
                if (res.success == '1') {
                    layer.closeAll();
                }
                layer.msg(res.message);
            }
        }
        $._FormRequest(my);
    });
    
    
    /**************************deviceztree************************************/
    var setting1 = {
        view: {
            dblClickExpand: false,
            showLine: true,
            selectedMulti: false
        },
        check: {
            enable: true,
            chkStyle: "checkbox", //复选框
        	chkboxType: { "Y": "ps", "N": "ps" }
        	//chkboxType: { "Y" : "p", "N" : "ps" }
        },
        data: {
            simpleData: {
                enable: true,
                idKey: "id",
                pIdKey: "pId",
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
            url: "${ctx}/projectConfigDevice/getTree?pid="+structId, //请求action方法 
            autoparam: ["data"]
        },
        callback: {
            //onClick : zTreeOnClick,
            //beforeClick: beforeClick,
            onCheck: onCheck,
            onAsyncSuccess: zTreeOnAsyncSuccess1
            //异步加载完成调用
        }
    };
    /* 获取返回的数据，进行预操作 */
    function ajaxDataFilter(treeId, parentNode, responseData) {
        responseData = responseData.data;
        return responseData;
    };
    //异步加载完成时运行，此方法将所有的节点打开
   function zTreeOnAsyncSuccess1(event, treeId, msg) {
    	var treeObj = $.fn.zTree.getZTreeObj("devicetree");
        treeObj.checkNode(treeId, !treeId.checked, null, true);
        //详情界面
        var my = {
            url: "${ctx}/projectConfigDevice/getConfigDevice",
            para: {
                "projectId": $("#configProjectId1").val()
            },
            callback: function(res) {
                if (res.success == '1') {
                	res.data.map(function(v, i) {
                        var node = treeObj.getNodeByParam("id", v.paramDeviceId);
                        treeObj.checkNode(node, true, true);
                        treeObj.updateNode(node);
                    })
                }
            }
        }
        $._MultAjax(my);
    }

    function beforeClick(treeId, treeNode) {
        var zTree = $.fn.zTree.getZTreeObj("devicetree");
        zTree.checkNode(treeNode, !treeNode.checked, null, true);
        return false;
    }

    function onCheck(e, treeId, treeNode) {
    	var checkedItems = '';
    	var zTree = $.fn.zTree.getZTreeObj("devicetree");
        zTree.getChangeCheckedNodes().map(function(i, v) {
        	if (i.isLast == 'true') {
        		checkedItems += i.id + ',';
            }
        });
        if (checkedItems) checkedItems = checkedItems.substr(0,checkedItems.length-1);
        $("input[name='paramDeviceIds']").val(checkedItems);
    }
    /*******************************end deviceztree************************************/
})
</script>
