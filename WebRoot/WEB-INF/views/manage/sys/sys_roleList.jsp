<%@ page language="java" pageEncoding="UTF-8"%>
    <%@include file="/WEB-INF/views/public/taglib.jspf"%>
        <!-- 列表界面 -->
        <div id="data-list">
            <div class="banner layui-hide"> <span class="base-blue-01 base-search" data-title='角色列表'>角色列表查询</span> </div>
            <div class="banner"> <span class="base-blue-01 base-search">角色列表</span></div>
            <form id="fa-search" class="layui-form-pane" style="margin-top: 15px;">
				<div class="layui-form-item">
				    <div class="layui-inline">
				      <label class="layui-form-label">角色名</label>
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
					  	<shiro:hasPermission name="sysRole:saveRole">
							<button id="btn_add" type="button" class="layui-btn" data-toggle="modal">新增</button>
						</shiro:hasPermission>
						<shiro:hasPermission name="sysRole:delRole">
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
				      <col width="400">
				      <col width="200">
				      <col width="150">
				      <col width="150">
				    </colgroup>
                    <thead>
                        <tr>
                        	<th><div class="label">
                        		<input id="checkAll"  type="checkbox" class="check_btn">
                        		<label class="checkboxLable" for="checkAll"></label >
                        	</div></th>
                            <th>序号</th>
                            <th>角色名</th>
                            <th>描述</th>
                            <th>创建时间</th>
							<th>修改时间</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody id="datalist"> </tbody>
                    <script id="tradecent-template" type="text/x-handlebars-template"> 
					{{#each this}}
                        <tr>
		                   <td><div class="label">
			                    <input id="{{roleId}}" name="userItem" value="{{roleId}}" type="checkbox" class="check_btn check_item" >
								<label class="checkboxLable" for="{{roleId}}"></label>
			                   </div>
		                   </td>
                            <td>
                                <div class='base-wrap'>{{addOne @index}}</div>
                            </td>
                            <td>
                                <div class='base-wrap left' id="roleName" title='{{name}}'>{{name}}</div>
                            </td>
                            <td>
                                <div class='base-wrap left'>{{remark}}</div>
                            </td>
							<td><div class='base-wrap'>{{createTime}}</div></td>
							<td><div class='base-wrap'>{{updateTime}}</div></td>		
                            <td>
								<shiro:hasPermission name="sysRole:updateRole"><span class="oper-handle iconfont icon-bianji base-yellow update" title='修改角色' data-pkid={{roleId}}></span></shiro:hasPermission>
								<shiro:hasPermission name="sysRole:deleteRole"><span class="oper-handle iconfont icon-shanchu base-red delete" title='删除角色' data-pkid={{roleId}}></span></shiro:hasPermission>
								<shiro:hasPermission name="sysRole:detailRole"><span class="oper-handle iconfont icon-xiangqing base-blue detail" title='详情角色' data-pkid={{roleId}}></span></shiro:hasPermission>
								<shiro:hasPermission name="sysRole:powerRole"><span class="oper-handle iconfont icon-shouquanguanli base-green authority" title='权限设置' data-pkid={{roleId}} data-name={{name}}></span></shiro:hasPermission>
							</td>
                        </tr> 
					{{/each}} 
					</script>
                </table>
            </div>
        </div>
        <!-- end列表界面 -->
        <!-- 新增与详情页面 -->
        <div id="data-form" data-title='新增角色'>
        	<form id="form" class="layui-form-pane">
				<input type='hidden' name='roleId'>
				<div class="layui-form-item">
						<label class="layui-form-label">角色名</label>
						<div class="layui-input-block">
							<input name="name" class="layui-input validate require" data-exp="w{2-20}">
						</div>
			   </div>
			   <div class="layui-form-item layui-form-text">
		   		<label class="layui-form-label">角色描述</label>
		    	<div class="layui-input-block">
		      		<textarea placeholder="请输入描述内容" class="layui-textarea" name="remark"></textarea>
		    	</div>
		   		</div>
			</form>
            <!-- <form id="form">
                <table class="base-table form">
                    <input type='hidden' name='roleId'>
                    <tr>
                        <td class="td-bg" width="150">角色名</td>
                        <td class="left">
                            <input name="name" class="base-input validate require" data-exp="w{2-20}">
                        </td>
                        <td width="150">描述</td>
                        <td>
                            <input name="remark" class="base-input">
                        </td>
                    </tr>
                </table>
            </form> -->
            <div class="toolbar buttom-btn">
                <button id="btn_back" type="button" class="layui-btn layui-btn-warm" data-toggle="modal">返回</button>
				<button id="btn_save" type="button" class="layui-btn layui-btn-normal" data-toggle="modal">保存</button>	
            </div>
        </div>
        <div id="authority">
            <div style="display: block;height: 88%;overflow: auto;">
                <ul id="tree" class="ztree" style="position: relative;bottom: 60px;margin-top:60px;height:250px"></ul>
            </div>
            <form id="menuForm">
                <input type="hidden" name="roleId">
                <input type='hidden' name='menuIds'> </form>
            <div class="toolbar buttom-btn">
            	<button id="btn_cancel" type="button" class="layui-btn layui-btn-warm" data-toggle="modal">取消</button>
				<button id="menu_save" type="button" class="layui-btn layui-btn-normal" data-toggle="modal">授权</button>	
            </div>
        </div>
        <!--end新增与详情页面-->
        <script src="${ctx}/res/js/main.js"></script>
        <script type="text/javascript">
        $(function() {
            $.baseEvent({
                ctx: '${ctx}',
                param: ['name','createTime'],
                isPage: true,
                pageList_url: "/sysRole/pageList",
                form_url: '/sysRole/saveRole',
                data_list: '${ctx}/route/manage/sys/sys_roleList',
                del_url: '/sysRole/delRole',
                findBy_url: '/sysRole/findRole',
                add_is_dialog: true
            });
            //权限赋值
            $('#datalist').on('click', '.authority', function() {
                var $_this = $(this);
                var roleName = $_this.parents("tr").find("#roleName").text();
                $_this.show();
                $("#authority").data("title",$_this.attr("title"));
                $("input[name='roleId']").val($_this.data("pkid"));
                if (true) {
                    layer.open({
                        type: 1,
                        shade: false,
                        title: "<span class='dialog_title base-zb-info'>" + $_this.attr("title")+"-"+$_this.data("name")+ "</span>",
                        area: ['40%', '70%'],
                        content: $('#authority')
                    });
                }
                $.fn.zTree.init($("#tree"), setting);
            });
            //保存方法
            $('#menu_save').on('click', function() {
                var my = {
                    form: "menuForm",
                    url: "${ctx}/sysRole/saveMenu",
                    callback: function(res) {
                        if (res.success == '1') {
                            layer.closeAll();
                        }
                        layer.msg(res.message);
                    }
                }
                $._FormRequest(my);
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
			
			var roleId = "";
			if (ids.length > 0) {
				roleId = ids.join(",");
				layer.confirm('你确要删除该数据吗？', {
	      		  btn: ['确定','取消']//按钮
	      		}, function(){					
					$.ajax({
				 		url:'${ctx}/sysRole/delRole',
				 		data:{ID:roleId},
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
            	chkboxType: { "Y" : "p", "N" : "ps" }
            	//chkboxType: { "Y" : "ps", "N" : "ps" }
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
                //onClick : zTreeOnClick,
                beforeClick: beforeClick,
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
            var zTree = $.fn.zTree.getZTreeObj("tree");
            zTree.checkNode(treeNode, !treeNode.checked, null, true);
            return false;
        }

        function onCheck(e, treeId, treeNode) {
            var zTree = $.fn.zTree.getZTreeObj("tree");
            var checkeds = zTree.getChangeCheckedNodes().map(function(i, v) {
                return i.menuId;
            });
            $("input[name='menuIds']").val(checkeds);
        }
        /*******************************************************************/
        </script>