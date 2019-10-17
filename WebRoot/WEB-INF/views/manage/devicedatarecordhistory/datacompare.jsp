<%@ page language="java" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/views/public/taglib.jspf" %>

<!-- 列表界面 -->
<div id="data-list">
    <div class="banner">
        <span class="base-blue-01 base-search" data-title='监测参数列表'>监测参数列表</span>
    </div>
    <form id="fa-search" class="layui-form-pane" style="margin-top: 15px;">
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label" style="width: 150px;">查询类型</label>
                <div class="layui-input-inline" style="width: 250px;">
                    <select class="base-select" name="searchType" id="searchType">
                        <option value="1">同一时间段</option>
                        <option value="2">不同时间段</option>
                    </select>
                </div>
                <label class="layui-form-label" style="width: 150px;">监测类型</label>
                <div class="layui-input-inline" style="width: 250px;">
                    <select class="base-select" name="typeId" id="typeId">
                        <option value="">请选择监测类型</option>
                    </select>
                </div>
                <label class="layui-form-label" style="width: 150px;">监测项</label>
                <div class="layui-input-inline" style="width: 250px;">
                    <select class="base-select" name="itemId" id="itemId">
                        <option value="">请选择监测项</option>
                    </select>
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label" style="width: 150px;">监测参数</label>
                <div class="layui-input-inline" style="width: 250px;">
                    <select class="base-select" name="paramId" id="paramId">
                        <option value="">请选择监测参数</option>
                    </select>
                </div>
                <label class="layui-form-label">监测点位</label>
                <div class="layui-input-inline" name="monitorSites" id="monitorSites" lay-filter="monitorSites">
                </div>
            </div>
        </div>
        <div class="layui-form-item">

            <div class="layui-inline" style="margin-right: -3px;">
                <label class="layui-form-label" style="width: 150px;">时间段1</label>
                <div class="layui-input-inline" style="width: 250px;">
                    <input type="text" name="searchBeginTimeOne" id="searchBeginTimeOne" autocomplete="off"
                           class="layui-input" onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd HH:00:00'})"/>
                </div>
                <label class="layui-form-label" style="width: 150px;">-</label>
                <div class="layui-input-inline" style="width: 250px;">
                    <input type="text" name="searchEndTimeOne" id="searchEndTimeOne" autocomplete="off"
                           class="layui-input" onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd HH:00:00'})"/>
                </div>
            </div>
            <div id="searchTimeType" style="display: none">
                <label class="layui-form-label" style="width: 150px;">时间段2</label>
                <div class="layui-input-inline" style="width: 250px;">
                    <input type="text" name="searchBeginTimeTwo" id="searchBeginTimeTwo" autocomplete="off"
                           class="layui-input" onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd HH:00:00'})"/>
                </div>
                <label class="layui-form-label" style="width: 150px;">-</label>
                <div class="layui-input-inline" style="width: 250px;">
                    <input type="text" name="searchEndTimeTwo" id="searchEndTimeTwo" autocomplete="off"
                           class="layui-input" onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd HH:00:00'})"/>
                </div>
            </div>
            <div class="layui-inline">
                <button id="search" type="button"
                        class="layui-btn layui-btn-normal" data-toggle="modal">
                    <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                </button>
            </div>
        </div>


    </form>
</div>
<!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
<div id="main" style="width: 100%;height:55vh; background-color: #0A0233; padding-top: 15px; color: #fff9ec"></div>
<div id="mainscatter" style="width: 100%;height:55vh; background-color: #0A0233; padding-top: 15px; color: #fff9ec"></div>

<div class="layui-tab-item">内容2</div>

<!--end新增与详情页面-->
<script src="${ctx}/res/ati_monitor/js/macarons.js"></script>
<script src="${ctx}/res/ati_monitor/js/vintage.js"></script>>
<script src="${ctx}/res/js/selectPluus.js"/>
<script type="text/javascript">
    $(function () {
        getStrucAndType()
        //默认为同一时间段 不同监测点
        var selectPlus = layui.selectM;
        //无限级分类-所有配置
        var selectplus = selectPlus({
            //元素容器【必填】
            elem: '#monitorSites'
            //候选数据【必填】
            , data: []
            , max: 1000
            , width: 400
            //添加验证
            , verify: 'required'
        });

        //绑定选择选择类型事件
        $("#searchType").on("change", function () {
            var value = $(this).val();
            if (value == 1) {//同一时间段
                $("#searchTimeType").hide();
                $(".searchMonitorSitesType").show();
            } else {//不同时间段
                $("#searchTimeType").show();
                $(".searchMonitorSitesType").hide();
            }
            $("#paramId").trigger("change");
        });

        //绑定查询事件
        $("#search").on("click", function () {
            var formData = serializeObject($("#fa-search"));
            formData["projectId"] = $("#flagProjectId").val();
            var searchUrl = "${ctx}/atiDeviceDataRecordHistory/getCompareDateHistory";
            var seachType = $("#searchType").val();
            var sitesId = formData["monitorSites"].split(",");
            if (formData["monitorSites"].length <= 0) {
                layer.msg("请至少选择一个监测点！");
                return;
            }
            if (seachType == 2) {
                if (sitesId.length >= 2) {
                    layer.msg("不同时间段只可选择一个监测点！");
                    return;
                }
                if (formData["searchBeginTimeOne"].length == 0 || formData["searchEndTimeOne"].length == 0) {
                    layer.msg("请填写完整时间段！");
                    return;
                } else {
                    if (formData["searchBeginTimeOne"] > formData["searchEndTimeOne"]) {
                        layer.msg("请填写正确时间段！");
                        return;
                    }
                }
                if (formData["searchBeginTimeTwo"].length == 0 || formData["searchEndTimeTwo"].length == 0) {
                    layer.msg("请填写完整时间段！");
                    return;
                } else {
                    if (formData["searchBeginTimeTwo"] > formData["searchEndTimeTwo"]) {
                        layer.msg("请填写正确时间段！");
                        return;
                    }
                }
            } else {
                if (formData["searchBeginTimeOne"].length == 0 || formData["searchEndTimeOne"].length == 0) {
                    layer.msg("请填写完整时间段！");
                    return;
                } else {
                    if (formData["searchBeginTimeOne"] > formData["searchEndTimeOne"]) {
                        layer.msg("请填写正确时间段！");
                        return;
                    }
                }
            }
            $.post(searchUrl, formData, function (data) {
                if (data.success == '1') {
                    data = data.data;
                    var searchType = $("#searchType").val();
                    //渲染标题
                    data.title = searchType == 1 ? "同一时间段不同监测点" : "不同时间段同一监测点";
                    //重新渲染数据
                    var service = [];
                    for (var i = 0; i < data.services.length; i++) {
                        var itemData = data.services[i];
                        var model = {
                            name: itemData.name,
                            type: 'line',
                            data: itemData.data,
                            markPoint: {
                                data: [{
                                    type: 'max',
                                    name: '最大值'
                                },
                                    {
                                        type: 'min',
                                        name: '最小值'
                                    }
                                ]
                            },
                            markLine: {
                                data: [{
                                    type: 'average',
                                    name: '平均值'
                                }]
                            }
                        };
                        service.push(model)
                    }
                    data.series = service;
                    initEachart(data);
                    scatterInit(data);
                }
            })
        })

        //全选/反选
        $("#checkAll").click(function () {
            $("input[name='monitorParamItem']:checkbox").prop("checked", this.checked);
        });

        $('#btn_del').on('click', function () {
            var ids = [];
            $("input[name='monitorParamItem']:checked").each(function () {
                ids.push($(this).attr("id"));
            });
            var deptId = "";
            if (ids.length > 0) {
                brigeTypeIds = ids.join(",");
                layer.confirm('你确要删除该数据吗？', {
                    btn: ['确定', '取消']//按钮
                }, function () {
                    $.ajax({
                        url: '${ctx}/monitorParam/delete',
                        data: {ID: brigeTypeIds},
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
        })


        function initEachart(data) {
            // 基于准备好的dom，初始化echarts实例
            var myChart = echarts.init(document.getElementById('main'), 'macarons');

            // 指定图表的配置项和数据
            option = {
                backgroundColor:"#383c58",
                title: {
                    x: '12px',
                    text: data.title
                },
                tooltip: {
                    trigger: 'axis'
                },
                grid: {
                    bottom: 50,
                    containLabel: true
                },
                legend: {
                    data: data.legendData,
                    textStyle: {
                        color: "#fff"
                    },
                    left: "20%"
                },
                dataZoom: [{
                    type: 'slider',
                    show: true, //flase直接隐藏图形
                    xAxisIndex: [0],
                    left: '13%', //滚动条靠左侧的百分比
                    bottom: 5,
                    start: 0,//滚动条的起始位置
                    end: 100,//滚动条的截止位置（按比例分割你的柱状图x轴长度）
                    textStyle: false
                }],
                toolbox: {
                    show: true,
                    x: '80%',
                    feature: {
                        dataView: {
                            show: true,
                            readOnly: false
                        },
                        magicType: {
                            show: true,
                            type: ['line', 'bar']
                        },
                        restore: {
                            show: true
                        },
                        saveAsImage: {
                            show: true
                        }
                    }
                },
                calculable: true,
                xAxis: [{
                    type: 'category',
                    data: data.category
                }],
                yAxis: [{
                    type: 'value'
                }],
                series: data.series
            };


            // 使用刚指定的配置项和数据显示图表
            myChart.clear();
            myChart.setOption(option);
        }

        //查找模板
        function getStrucAndType() {
            var structId = $("#structureId").val();
            var my = {
                url: "${ctx}/monitorParam/getTypeAndItem",
                para: {'structId': structId},
                callback: function (res) {
                    $("#typeId").html('<option value="">请选择监测类型</option>');
                    for (var i = 0; i < res.data.typeList.length; i++) {
                        if (res.data.typeList[i].atiProjectStructure && structId == res.data.typeList[i].atiProjectStructure.id) {
                            $("#typeId").append("<option value='" + res.data.typeList[i].id + "'>" + res.data.typeList[i].name + "</option>");
                        }
                    }

                    $(document).off("change", "#typeId").on("change", "#typeId", function () {
                        $("#itemId").html('<option value="">请选择监测项</option>');
                        var typeId = $(this).find("option:selected").val().trim();
                        for (var i = 0; i < res.data.itemList.length; i++) {
                            if (res.data.itemList[i].atiMonitorType && typeId == res.data.itemList[i].atiMonitorType.id) {
                                $("#itemId").append("<option value='" + res.data.itemList[i].id + "'>" + res.data.itemList[i].name + "</option>");
                            }
                        }
                    });

                    $(document).off("change", "#itemId").on("change", "#itemId", function () {
                        var url = "${ctx}/monitorParam/getParamListByItem";
                        var itemId = $(this).find("option:selected").val().trim();
                        var index = layer.load();
                        $.post(url, {monitorItemId: itemId}, function (data) {
                            data = data.data;
                            $("#paramId").html('<option value="">请选择监测参数</option>');
                            for (var i = 0; i < data.length; i++) {
                                $("#paramId").append("<option value='" + data[i].id + "'>" + data[i].name + "</option>");
                            }
                            layer.close(index);
                        })
                    });

                    $(document).off("change", "#paramId").on("change", "#paramId", function () {
                        var url = "${ctx}/processing/getSpoy";
                        var paramId = $(this).find("option:selected").val().trim();
                        var projectId = $("#flagProjectId").val();
                        if (paramId != null && paramId != '') {
                            var index = layer.load();
                            $.post(url, {paramId: paramId, projectId: projectId}, function (data) {
                                data = data.data;
                                var tagData = [];
                                for (var i = 0; i < data.length; i++) {
                                    var item = {id: data[i].id, name: data[i].name};
                                    tagData.push(item);
                                }

                                var tagIns1 = selectPlus({
                                    //元素容器【必填】
                                    elem: '#monitorSites'
                                    //候选数据【必填】
                                    , data: tagData
                                    , max: 1000
                                    , width: 400
                                    //添加验证
                                    , verify: 'required'
                                });
                                tagIns1.render();
                                layer.close(index);
                            })
                        }
                    });
                }
            }
            $._NormalRequest(my);
        }
    });

    
    function scatterInit(data) {
        console.log(data)
        //散点图初始化
        var category = data.category;
        var dataInit = [];
        for(var j = 0;j < data.legendData.length;j++){
            for(var i = 0;i< category.length;i++){
                var dataItem = [category[i]];
                dataItem.push(data.series[j].data[i]);
                dataItem.push(data.series[j].name)
                dataInit.push(dataItem)
            }
        }

        var myChart = echarts.init(document.getElementById('mainscatter'), 'macarons');
        option = {
            backgroundColor:"#383c58",
            xAxis: {
                data:category
            },
            yAxis: {},
            series: [{
                label: {
                    emphasis: {
                        show: true,
                        formatter: function (param) {
                            return param.data[3];
                        },
                        position: 'top'
                    }
                },
                symbolSize: 10,
                data:dataInit,
                type: 'scatter'
            }]
        };

        myChart.clear();
        myChart.setOption(option);
    }

    function serializeObject(form) {
        var o = {};
        var a = form.serializeArray();
        $.each(a, function () {
            if (o[this.name] !== undefined) {
                if (!o[this.name].push) {
                    o[this.name] = [o[this.name]];
                }
                o[this.name].push(this.value || '');
            } else {
                o[this.name] = this.value || '';
            }
        });
        return o;
    };

</script>
