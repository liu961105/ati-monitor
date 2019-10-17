<%@ page language="java" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/views/public/taglib.jspf" %>
<!-- 列表界面 -->
<div id="data-list">
    <div class="banner layui-hide">
        <span class="base-blue-01 base-search" data-title='项目管理'>项目配置设备</span>
    </div>
    <div class="banner">
        <span class="base-blue-01 base-search">项目配置设备列表</span>
    </div>

    <div id="list">
        <table class="layui-table">
            <colgroup>
                <col width="60">
                <col width="300">
                <col width="300">
                <col width="300">
                <col width="300">
            </colgroup>
            <thead>
            <tr>
                <th>序号</th>
                <th>项目名称</th>
                <th>参数名称</th>
                <th>设备名称</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody id="datalist">

            </tbody>
            <script id="tradecent-template" type="text/x-handlebars-template">
                {{#each this}}
                <tr>

                    <td>
                        <div class='base-wrap'>{{addOne @index}}</div>
                    </td>
                    <td>
                        <div class='base-wrap left' title="{{projectName}}">{{projectName}}</div>
                    </td>
                    <td>
                        <div class='base-wrap left' title="{{name}}">{{name}}</div>
                    </td>
                    <td>
                        <div class='base-wrap left' title="{{deviceName}}">{{deviceName}}</div>
                    </td>
                    <td>
                        <button type="button" class="layui-btn layui-btn-xs layui-btn-warm config-monitorSites"
                                data-toggle="modal" data-pkid="{{id}},{{deviceId}},{{paramId}}">查看监测点
                        </button>
                        <button type="button" class="layui-btn layui-btn-xs layui-btn-warm save_sites"
                                data-toggle="modal" data-pkid="{{id}},{{deviceId}},{{paramId}}">新增监测点
                        </button>
                    </td>
                </tr>
                {{/each}}
            </script>
        </table>
    </div>
</div>
<!-- end列表界面 -->

<!-- 新增与详情页面 -->
<div id="data-form" data-title='新增监测点位'>
    <form id="form" class="layui-form-pane">
        <div class="layui-row">
            <div class="layui-col-md6">
                <div class="layui-form-item">
                    <label class="layui-form-label">监测点名称</label>
                    <div class="layui-input-block">
                        <input name="name" data-id="projectName"
                               class="layui-input pName validate require">
                        <input name='projectId' id="projectId" class="projectId" type="hidden" data-id="id">
                        <input name="deviceId" id="deviceId" type="hidden"/>
                        <input name="monitorParamId" id="paramId" type="hidden"/>
                        <input name="id" type="hidden">
                        <input name="createUser" type="hidden"/>
                        <input name="createTime" type="hidden"/>
                    </div>
                </div>
            </div>
            <div class="layui-col-md6">
                <div class="layui-form-item">
                    <label class="layui-form-label">监测点编号</label>
                    <div class="layui-input-block">
                        <input name="code" class="layui-input validate require"
                               data-exp="w{2-20}">
                    </div>
                </div>
            </div>
        </div>
        <div class="layui-row">
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
                    <label class="layui-form-label">黄色预警值</label>
                    <div class="layui-input-block">
                        <input name="oneWarnLevel" class="layui-input validate"
                               data-exp="n{0-20}">
                    </div>
                </div>
            </div>
        </div>
        <div class="layui-row">
            <div class="layui-col-md6">
                <div class="layui-form-item">
                    <label class="layui-form-label">橙色预警值</label>
                    <div class="layui-input-block">
                        <input name="twoWarnLevel" class="layui-input validate"
                               data-exp="n{0-20}">
                    </div>
                </div>
            </div>
            <div class="layui-col-md6">
                <div class="layui-form-item">
                    <label class="layui-form-label">红色预警值</label>
                    <div class="layui-input-block">
                        <input name="treeWarnLevel" class="layui-input validate"
                               data-exp="n{0-20}">
                    </div>
                </div>
            </div>
        </div>
    </form>
    <div id="toolbar" class="toolbar buttom-btn">
        <button id="btn_back" type="button" class="layui-btn layui-btn-warm"
                data-toggle="modal">返回
        </button>
        <button id="btn_save" type="button" class="layui-btn layui-btn-normal"
                data-toggle="modal">保存</button>
    </div>
</div>
<!--end新增与详情页面-->

<div id="sitesTablePanel" style="display: none;">
    <table id="sitesTable" lay-filter="demo">
        <thead>
        <tr>
            <th lay-data="{field:'name', width:200}">监测点名称</th>
            <th lay-data="{field:'code', width:170}">监测点编号</th>
            <th lay-data="{field:'oneWarnLevel', width:100}">黄色预警值</th>
            <th lay-data="{field:'twoWarnLevel', width:100}">橙色预警值</th>
            <th lay-data="{field:'treeWarnLevel', width:100}">红色预警值</th>
            <th lay-data="{ width:200,templet:'#doCol'}">操作</th>
        </tr>
        </thead>
        <tbody>
        </tbody>
    </table>
</div>

<script type="text/html" id="doCol">
    <button type="button" class="layui-btn layui-btn-xs layui-btn-warm config-del-sites"
            data-toggle="modal" data-pkid="{{d.id}}">删除
    </button>
    <button type="button" class="layui-btn layui-btn-xs layui-btn-warm config-update-sites"
            data-toggle="modal" data-allId="{{d.projectId}},{{d.deviceId}},{{d.monitorParamId}}" data-pkid="{{d.id}}">修改
    </button>
</script>
<script src="${ctx}/res/js/main.js"></script>
<script type="text/javascript">
    $(function () {
        $.baseEvent({
            ctx: '${ctx}',
            param: [ 'monitorParamId', 'deviceId', 'name', 'code'],
            isPage: true,
            pageList_url: "/atiProject/getProjectDevice?projectId=${projectId}",
            form_url: '/atiProjectMonitorSites/saveMonitorSites',
            data_list: '${ctx}/route/project/projectdevice?projectId=${projectId}',
            del_url: '/atiProject/delProjectInfo',
            findBy_url: '/atiProject/findProjectInfo',
            add_is_dialog: true
        });

        //全选/反选
        $("#checkAll").click(function () {
            $("input[name='userItem']:checkbox").prop("checked", this.checked);
        });

        $('#btn_del').on('click', function () {
            var ids = [];
            $("input[name='userItem']:checked").each(function () {
                ids.push($(this).attr("id"));
            });

            var projectId = "";
            if (ids.length > 0) {
                projectId = ids.join(",");
                layer.confirm('你确要删除该数据吗？', {
                    btn: ['确定', '取消'] //按钮
                }, function () {
                    $.ajax({
                        url: '${ctx}/atiProject/delProjectInfo',
                        data: {
                            ID: projectId
                        },
                        dataType: 'json',
                        success: function (res) {
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

        $("#data-list").on("click",".save_sites",function () {
            //{{id}},{{deviceId}},{{paramId}}
            document.getElementById("form").reset();
            var id = $(this).data("pkid");
            var idstr = id.split(",");
            $("#projectId").val(idstr[0]);
            $("#deviceId").val(idstr[1]);
            $("#paramId").val(idstr[2]);

            layer.open({
                type: 1,
                shade: false,
                title: "<span class='dialog_title base-zb-info'>新增监测点</span>",
                area: ['60%', '58%'],
                content: $('#data-form'),
            });
        });

        $("#data-list").on("click", ".config-monitorSites", function () {
            var pkid = $(this).data('pkid');
            var idstr = pkid.split(",");
            $("#projectId").val(idstr[0]);
            $("#deviceId").val(idstr[1]);
            $("#paramId").val(idstr[2]);
            //url
            var url = "${ctx}/atiProjectMonitorSites/sitesPageInfo";
            $.post(url, {projectId: idstr[0], deviceId: idstr[1], monitorParamId: idstr[2]}, function (data) {
                if(data.success == '1'){
                    var table = layui.table;
                    var limitNum = data.data.length * 1 + 1;
                    table.init("demo",{
                        //height: 500 ,//设置高度
                        data:data.data,
                        limit:limitNum
                    })
                    $(".config-del-sites").on("click",function () {
                        var delId = $(this).data("pkid");
                        //你确定要删除吗
                        layer.confirm('你确要删除该数据吗？', {
                            btn: ['确定', '取消'] //按钮
                        }, function () {
                            $.post("${ctx}/atiProjectMonitorSites/deleteMonitorSites",{id:delId},function (data) {
                                if(data.success){
                                    alertYes("处理成功！");
                                    layer.close(index);
                                }else {
                                    alertError("处理失败！")
                                }
                            })
                        });

                    });
                    $(".config-update-sites").on("click",function () {
                        var id = $(this).data("pkid");
                        var allId = $(this).attr("data-allid");
                        $.post("${ctx}/atiProjectMonitorSites/findSitesById",{id:id},function (data) {
                            $.setValue(data.data);
                            var idstr = allId.split(",");
                            $("#projectId").val(idstr[0]);
                            $("#deviceId").val(idstr[1]);
                            $("#paramId").val(idstr[2]);
                            layer.open({
                                type: 1,
                                shade: false,
                                title: "<span class='dialog_title base-zb-info'>新增监测点</span>",
                                area: ['60%', '58%'],
                                content: $('#data-form'),
                            });
                        })
                    });
                    var index = layer.open({
                        type: 1,
                        shade: false,
                        title: "<span class='dialog_title base-zb-info'>监测点列表</span>",
                        area: ['870', '50%'],
                        content: $('#sitesTablePanel')
                    });

                }else{
                    alertWarn("暂无数据！")
                }
            })
        })

    });
</script>
