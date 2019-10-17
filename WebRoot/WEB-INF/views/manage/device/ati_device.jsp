<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/public/taglib.jspf"%>
<!-- 列表界面 -->
<div id="data-list">
    <div class="banner layui-hide">
        <span class="base-blue-01 base-search" data-title='项目管理'>设备管理</span>
    </div>
    <div class="banner">
        <span class="base-blue-01 base-search">设备列表</span>
    </div>
    <form id="fa-search" class="layui-form-pane" style="margin-top: 15px;">
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">设备名称</label>
                <div class="layui-input-inline">
                    <input type="text" name="deviceName" id="deviceName" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">设备编号</label>
                <div class="layui-input-inline">
                    <input type="text" name="deviceCode" id="deviceCode" autocomplete="off" class="layui-input"/>
                </div>
            </div>
            <div class="layui-inline">
                <button id="btn_search" type="button" class="layui-btn layui-btn-normal" data-toggle="modal"><i class="layui-icon layui-icon-search layuiadmin-button-btn"></i></button>
            </div>
            <div class="layui-inline layui-inline-right">
                <shiro:hasPermission name="device:saveDevice">
                    <button id="btn_add" type="button" class="layui-btn" data-toggle="modal">新增</button>
                </shiro:hasPermission>
                <shiro:hasPermission name="device:delDeviceBatch">
                    <button id="btn_del" type="button" class="layui-btn layui-btn-danger" data-toggle="modal">删除</button>
                </shiro:hasPermission>
            </div>
        </div>
    </form>
    <div id="list">
        <table class="layui-table">
            <colgroup>
                <col width="50">
                <col width="150">
                <col width="160">
                <col width="130">
                <col width="150">
                <col width="180">
                <col width="180">
            </colgroup>
            <thead>
            <tr>
                <th><div class="label"><input id="checkAll"  type="checkbox" class="check_btn"><label class="checkboxLable" for="checkAll"></label></div></th>
                <th>序号</th>
                <th>设备编号</th>
                <th>设备名称</th>
                <th>别名</th>
                <th>开启标志</th>
                <th>厂商</th>
                <th>创建时间</th>
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
                    <td><div class='base-wrap left' title="{{deviceCode}}">{{deviceCode}}</div></td>
                    <td><div class='base-wrap left' title="{{deviceName}}">{{deviceName}}</div></td>
                    <td><div class='base-wrap left' title="{{anotherName}}">{{anotherName}}</div></td>
                    <td><div class='base-wrap left' title="{{openFlag}}">{{openFlag}}</div></td>
                    <td><div class='base-wrap left' title="{{manufacturer}}">{{manufacturer}}</div></td>
                    <td><div class='base-wrap'>{{createTime}}</div></td>
                    <td>
                        <shiro:hasPermission name="device:update"><span class="oper-handle iconfont icon-bianji base-yellow update" title='修改设备' data-pkid={{id}}></span></shiro:hasPermission>
                        <shiro:hasPermission name="device:delete"><span class="oper-handle iconfont icon-shanchu base-red delete" title='删除设备' data-pkid={{id}}></span></shiro:hasPermission>
                        <shiro:hasPermission name="device:detail"><span class="oper-handle iconfont icon-xiangqing base-blue detail" title='设备详情' data-pkid={{id}}></span></shiro:hasPermission>
                        <shiro:hasPermission name="device:paramSet"><span class="oper-handle iconfont icon-shezhi base-blue deviceParam" title='设备参数设置' data-pkid={{id}}></span></shiro:hasPermission>
                    </td>
                </tr>
                {{/each}}
            </script>
        </table>
    </div>
</div>
<!-- end列表界面 -->

<!-- 新增与详情页面 -->
<div id="data-form" data-title='新增设备'>
    <form id="form" class="layui-form-pane">
        <div class="layui-row">
            <div class="layui-col-md6">
                <div class="layui-form-item">
                    <label class="layui-form-label">设备名称</label>
                    <div class="layui-input-block">
                        <input name="deviceName"  data-id="deviceName" class="layui-input pName validate require">
                        <input name='id' class="id" type="hidden"  data-id="id">
                        <input name='createTime' class="createTime" type="hidden"  data-id="createTime">
                    </div>
                </div>
            </div>
            <div class="layui-col-md6">
                <div class="layui-form-item">
                    <label class="layui-form-label">设备别名</label>
                    <div class="layui-input-block">
                        <input name="anotherName"  class="layui-input validate require" data-exp="w{2-20}">
                    </div>
                </div>
            </div>
        </div>
        <div class="layui-row">
            <div class="layui-col-md6">
                <div class="layui-form-item">
                    <label class="layui-form-label">是否开启</label>
                    <div class="layui-input-block">
                        <select class="base-select validate require"  name="openFlag">
                            <option value="1">开启</option>
                            <option value="0">未开启</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="layui-col-md6">
                <div class="layui-form-item">
                    <label class="layui-form-label">设备编号</label>
                    <div class="layui-input-block">
                        <input name="deviceCode" class="layui-input validate" data-exp="w{1-50}">
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
            <div class="layui-col-md6">
                <div class="layui-form-item">
                    <label class="layui-form-label">厂商</label>
                    <div class="layui-input-block">
                        <input name="manufacturer" class="layui-input validate" data-exp="w{1-50}">
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

<div id="deviceParamPanel" style="display: none">
    <div>
        <ul id="tree" class="ztree" style="position: relative;bottom: 60px;margin-top:60px;height:250px"></ul>
    </div>
    <form id="menuForm">
        <input type="hidden" name="roleId">
        <input type='hidden' name='menuIds'> </form>
    <div class="toolbar buttom-btn">
        <button id="btn_cancel" type="button" class="layui-btn layui-btn-warm" data-toggle="modal">取消</button>
        <button id="deviceParamSave" type="button" class="layui-btn layui-btn-normal" data-toggle="modal">确定</button>
    </div>
</div>
<script src="${ctx}/res/js/main.js"></script>
<script type="text/javascript">
    $(function() {
       // getStrucAndType();

        $.baseEvent({
            ctx:'${ctx}',
            param:['deviceName','deviceCode','projectStatus'],
            isPage:true,
            pageList_url:"/device/devicePageInfo",
            form_url:'/device/saveAtiDevice',
            data_list:'${ctx}/route/manage/device/ati_device',
            del_url:'/device/delAtiDevice',
            findBy_url:'/device/findAtiDevice',
            add_is_dialog:true
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

            var projectId = "";
            if (ids.length > 0) {
                projectId = ids.join(",");
                layer.confirm('你确要删除该数据吗？', {
                    btn: ['确定','取消']//按钮
                }, function(){
                    $.ajax({
                        url:'${ctx}/device/delAtiDevice',
                        data:{ID:projectId},
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
        var treeObject = null;
        var deviceId = "";
        var openDeviceParamPanel = null;
        var structureId = $("#structureId").val()
        //绑定事件 点击按钮 弹出设备参数设置
        $('#datalist').on('click', '.deviceParam', function()  {
            openDeviceParamPanel = layer.open({
                type: 1,
                shade: false,
                title: "<span class='dialog_title base-zb-info'>设备参数设置</span>",
                area: ['40%', '70%'],
                content: $('#deviceParamPanel')
            });
            treeObject = $.fn.zTree.init($("#tree"), setting);
            deviceId = $(this).attr("data-pkid");
        })

        //------------------ztree-----------------
        //初始化ztree
        var setting = {
            view: {
                dblClickExpand: false,
                showLine: true,
                selectedMulti: false
            },
            check: {
                enable: true,
                chkStyle: "checkbox", //复选框
                chkboxType: { "Y" : "ps", "N" : "ps" }
                // chkboxType: { "Y" : "p", "N" : "ps" }
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
                url: "${ctx}/projectConfigParam/getTree?pid="+structureId, //请求action方法
                autoparam: ["data"]
            },
            callback: {
                //onClick : zTreeOnClick,
                // beforeClick: beforeClick,
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

        //数据加载完成以后 获取当前设备所有已选择的参数 进行反选
        function zTreeOnAsyncSuccess(event, treeId, msg) {

            treeObject.checkNode(treeId, !treeId.checked, null, true);
            //详情界面
            var my = {
                url: "${ctx}/device/findActiveDeviceParamByDeviceId",
                para: {
                    "deviceId": deviceId
                },
                callback: function(res) {
                    res.data.map(function(v, i) {
                        console.log(v)
                        var node = treeObject.getNodeByParam("id",v.paramId);
                        treeObject.checkNode(node, true, true);
                        treeObject.updateNode(node);
                    })
                }
            }
            $._NormalRequest(my);
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

        $("#deviceParamSave").on("click",function(){
           var checkedNodes = treeObject.getCheckedNodes(true);
           var updateNodes = [];
           //只拿到第三个节点
            var paramIds = "";
           for(var i = 0;i < checkedNodes.length;i++){
               if(checkedNodes[i].isLast == 'true'){
                   updateNodes.push(checkedNodes[i]);
                   paramIds+=checkedNodes[i].id;
                   if(i <= checkedNodes.length -1){
                       paramIds+=",";
                   }
               }
           }
           if(updateNodes.length <= 0){
               //提示用户要选择节点
               alertError("请选择对应的参数节点");
           }else {
               //准备参数
               //发送请求
               var updateNodesUrl = "${ctx}/device/saveAtiDeviceParam";
               $.post(updateNodesUrl,{deviceId:deviceId,paramIds:paramIds},function (data) {
                   if(data.success == 1){
                       alertOk("更新成功")
                   }else {
                       alertError("更新失败")
                   }
                   //关闭窗口
                   layer.close(openDeviceParamPanel);
               })

           }
        })
    });




</script>