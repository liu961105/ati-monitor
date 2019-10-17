<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/views/public/taglib.jspf" %>
<script type="text/javascript">
    var ctx = "${ctx}";
</script>
<link rel="stylesheet" href="${ctx}/res/ati_monitor/css/base.css">
<link rel="stylesheet" href="${ctx}/res/ati_monitor/css/baseless.css">
<style>
    li {
        color: seashell;
    }

    .left label {
        color: #fff9ec;
        background-color: #01AAED;
    }

    .right label {
        color: #fff9ec;
        background-color: #01AAED;
    }

    .right {
        float: left;
        padding: 20px;
        padding-left: 30px;
    }

    .layui-btn {
        margin-top: 20px;
    !
    important;
    }

    /*
       宽：vw
       高：vh
       m|b-->: rem
       报告管理---数据对比
       同一时段
       关联对象
        */
    .left {
        float: left;
        padding: 20px;
    }

    .item {
        display: flex;
    }

    .n-contaiter {
        padding-left: 25px;
    }

    .select-item {
        width: 400px;
    }
</style>
<section class="n-contaiter" style="background: #171939;">
    <div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">

        <div class="layui-tab-content">
            <div class="layui-tab-item layui-show">
                <form id="search_form">
                    <div class="layui-form">

                        <div class="item">
                            <div class="left">
                                <label style="width: 110px;" class="layui-form-label">监测类型：</label>
                                <div class="layui-input-block select-item"
                                     style="width: 400px;padding-left: 10px">
                                    <select class="mtype" name="monitorType"
                                            lay-filter="monitorType">

                                    </select>
                                </div>
                            </div>
                            <div class="right">
                                <label style="width: 110px;" class="layui-form-label">监测项目：</label>
                                <div class="layui-input-block select-item"
                                     style="width: 400px;padding-left: 10px">
                                    <select class="mproject" name="monitorPorject"
                                            lay-filter="monitorProject">

                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="item">
                            <div class="left">
                                <label style="width: 110px;" class="layui-form-label">监测参数：</label>
                                <div class="layui-input-block select-item"
                                     style="width: 400px;padding-left: 10px">
                                    <select class="mparam" name="monitorParam"
                                            lay-filter="monitorParam">

                                    </select>
                                    <input type="hidden" id="monitorParamText"/>
                                </div>
                            </div>
                            <div class="right">
                                <label style="width: 110px;" class="layui-form-label">监测点位：</label>
                                <div class="layui-input-block select-item"
                                     style="width: 400px;padding-left: 10px">
                                    <select class="mspot" name="monitorSitesOne"
                                            lay-filter="monitorSpot">
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="item">
                            <div class="left">
                                <div class="layui-input-block select-item"
                                     style="width: 300px;padding-left: 6px;margin-left: -0.5vw; float:left;">
                                    <label style="width: 110px;" class="layui-form-label">对比时段：</label>
                                    <div class="layui-input-block select-item"
                                         style="width: 300px;padding-left: 10px">
                                        <input type="text" name="searchBeginTimeOne"
                                               id="searchBeginTimeOne" autocomplete="off"
                                               class="layui-input"
                                               onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})"/>

                                    </div>
                                </div>
                                <div class="layui-input-block select-item"
                                     style="width: 100px;padding-left: 10px;margin-left: 7.1vw; float: left">
                                    <input type="text" name="searchBeginTimeNode"
                                           id="searchBeginTimeNode" autocomplete="off" class="layui-input"
                                           onclick="WdatePicker({skin:'whyGreen',dateFmt:'HH:mm'})"/>

                                </div>
                            </div>
                            <a style="color: white;margin-top: 3vh;width: 0vw;margin-left: 0vw">~</a>
                            <div class="right">
                                <div class="layui-input-block select-item"
                                     style="width: 300px;padding-left: 20px;margin-left: -0.5vw; float:left;">
                                    <input type="text" name="searchEndTimeOne"
                                           id="searchEndTimeOne" autocomplete="off" class="layui-input"
                                           onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})"/>

                                </div>
                                <div class="layui-input-block select-item"
                                     style="width: 100px;padding-left: 10px;margin-left: -0.5vw; float: left">
                                    <input type="text" name="searchEndTimeNode"
                                           id="searchEndTimeNode" autocomplete="off" class="layui-input"
                                           onclick="WdatePicker({skin:'whyGreen',dateFmt:'HH:mm'})"/>

                                </div>
                            </div>
                            <button id="search" type="button"
                                    class="layui-btn layui-btn-normal" data-toggle="modal">
                                <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                            </button>
                        </div>
                    </div>
                </form>

                <!-- 为 ECharts 准备一个具备大小（宽高）的 DOM -->
                <div id="main" style="width: 100%;height:500px; padding-top: 15px; color: #fff9ec">
                    <div id="echartLeft" style="float: left; width: 50%;height: 100%;"></div>
                    <div id="echartRight" style="float: left; width: 50%;height: 100%;"></div>
                    <div id="echartFFT" style="top:20vh; width: 50%;height: 100%;"></div>
                </div>

            </div>
        </div>
    </div>
    <div>
        <div class="sjcl-table" style="float: left; width: 50%;height: 100%;"></div>
        <div id="statistics" style="float: left; width: 50%;height: 100%;"></div>
    </div>
</section>

<script src="${ctx}/res/ati_monitor/js/home.js"></script>
<!-- 引入 ECharts 文件 -->
<script src="${ctx}/res/ati_monitor/js/macarons.js"></script>
<script src="${ctx}/res/ati_monitor/js/vintage.js"></script>

<script type="text/javascript">

    $(function () {
        $('#search').click(function () {
            var index = layer.load();
            var spot = $(".mspot  option:selected").text();
            var beginTime = $("#searchBeginTimeOne").val();
            var endTime = $("#searchEndTimeOne").val();
            var formData = serializeObject($('#search_form'))
            formData["projectId"] = $("#flagProjectId").val();
            formData["searchType"] = 3;
            var searchUrl = "${ctx}/atiDeviceDataRecordHistory/getCompareDataNew";
            $.post(searchUrl, formData, function (data) {
                if (data.success == '1') {
                    data = data.data;
                    var searchType = $("#searchType").val();
                    //渲染标题
                    data.title = searchType == 1 ? "同一时间段不同监测点" : "不同时间段同一监测点";
                    //选择数据标识
                    if (searchType == 1) {
                        //同一时间不同监测点  名称以监测点命名
                        var monOneText = $("#monitorSitesOne").find("option:selected").text();
                        var monTwoText = $("#monitorSitesTwo").find("option:selected").text();
                        data.legendData = [monOneText, monTwoText];
                    } else if (searchType == 2) {
                        //不同时间段同一监测点 名称以时间段命名
                        var monOneText = $("#monitorSitesOne").find("option:selected").text();
                        var timeOneText = $("#searchBeginTimeOne").val() + "-" + $("#searchEndTimeOne").val();
                        var timeTwoText = $("#searchBeginTimeTwo").val() + "-" + $("#searchEndTimeTwo").val();
                        data.legendData = [timeOneText, timeTwoText]
                    } else {
                        var monOneText = $("#monitorParamText").val();
                        data.legendData = [monOneText + "-1/x", monOneText + "-2/y"];
                    }

                    initEachart(data);
                    $('.sjcl-table').html('<table class="m-table" cellspacing="0" cellpadding="0" style="width: 41vw;margin: 0 auto;">' +
                        '<thead>' +
                        '<tr>' +
                        '<th style="text-align: center;color: white;">最大值</th>' +
                        '<th style="text-align: center;color: white;">最小值</th>' +
                        '<th style="text-align: center;color: white;">平均值</th>' +
                        '</tr>' +
                        '</thead>' +
                        '<tbody class="J_table">' +
                        '</tbody>' +
                        '<tr>' +
                        '<td style="color: white;">' + data.max + '</td>' +
                        '<td style="color: white;">' + data.min + '</td>' +
                        '<td style="color: white;">' + data.ava + '</td>' +
                        '</tr>' +
                        '</table>');
                    layer.close(index);
                } else {
                    layer.msg("请选择正确的时间区域");
                }
            });


            var ssurl = "${ctx}/atiDeviceDataRecordHistory/getCompareFFTData";
            $.post(ssurl, formData, function (data) {
                if (data.success == '1') {
                    $('#echartFFT').show();
                    var fftData = data.data;
                    var searchType = $("#searchType").val();
                    //选择数据标识
                    initEachartFFT(fftData);
                } else {
                    $('#echartFFT').hide();
                }
            });


            var searchSUrl = "${ctx}/atiDeviceDataRecordHistory/getHistoryStatistics";
            $.post(searchSUrl, formData, function (data) {
                data = data.data
                initEachartRight(data)
                var tableHtml = "";
                for (var i = 0; i < data.legendData.length; i++) {
                    tableHtml += '<tr>' +
                        '<td style="color: white;">' + data.legendData[i] + '</td>' +
                        '<td style="color: white;">' + data.rate[i] + '</td>' +
                        '<td style="color: white;">' + data.sum[i] + '</td>' +
                        '</tr>'
                }
                $('#statistics').html('<table class="m-table" cellspacing="0" cellpadding="0" style="width: 41vw;margin: 0 auto;">' +
                    '<thead>' +
                    '<tr>' +
                    '<th style="text-align: center;color: white;">时间</th>' +
                    '<th style="text-align: center;color: white;">速率</th>' +
                    '<th style="text-align: center;color: white;">累计值</th>' +
                    '</tr>' +
                    '</thead>' +
                    '<tbody class="J_table">' +
                    '</tbody>' +
                    tableHtml +
                    '</table>');
            })
        });

        layui.use('element', function () {
            var element = layui.element;
            element.init(); //更新全部  2.1.6 可用 element.render() 方法替代
        });

        layui.use('form', function () {
            var form = layui.form;
            form.render();
            getMonitorData(form);
            form.render();


        });

        layui.use('laydate', function () {
            var laydate = layui.laydate;

            laydate.render({
                elem: '#test1' //指定元素
            });
            //执行一个laydate实例
            laydate.render({
                elem: '#test2' //指定元素
            });
        });


        function initEachartFFT(data) {
            // 基于准备好的dom，初始化echarts实例
            var myChart = echarts.init(document.getElementById('echartFFT'), 'macarons');
            // 指定图表的配置项和数据
            option = {
                title: {
                    x: '12px',
                    text: 'FFT值'
                },
                tooltip: {
                    trigger: 'axis'
                },
                legend: {
                    data: data.legendData,
                    textStyle: {
                        color: "#fff"
                    }
                },
                grid: {
                    bottom: 50,
                    containLabel: true,
                    left: "1%"
                },
                dataZoom: [{
                    type: 'slider',
                    show: true, //flase直接隐藏图形
                    xAxisIndex: [0],
                    left: '5%', //滚动条靠左侧的百分比
                    bottom: 5,
                    start: 0,//滚动条的起始位置
                    end: 100,//滚动条的截止位置（按比例分割你的柱状图x轴长度）
                    textStyle: false
                }],
                toolbox: {
                    show: true,
                    x: '75%',
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
                series: [{
                    name: 'FFT',
                    type: 'line',
                    data: data.lineOneData,
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
                }
                ]
            };


            // 使用刚指定的配置项和数据显示图表。
            myChart.setOption(option);
        }


        // 基于准备好的dom，初始化echarts实例
        function initEachart(data) {
            // 基于准备好的dom，初始化echarts实例
            var myChart = echarts.init(document.getElementById('echartLeft'), 'macarons');

            // 指定图表的配置项和数据
            option = {
                title: {
                    x: '12px',
                    text: data.title
                },
                tooltip: {
                    trigger: 'axis'
                },
                legend: {
                    data: data.legendData,
                    textStyle: {
                        color: "#fff"
                    }
                },
                grid: {
                    bottom: 50,
                    containLabel: true,
                    left: "1%"
                },
                dataZoom: [{
                    type: 'slider',
                    show: true, //flase直接隐藏图形
                    xAxisIndex: [0],
                    left: '5%', //滚动条靠左侧的百分比
                    bottom: 5,
                    start: 0,//滚动条的起始位置
                    end: 100,//滚动条的截止位置（按比例分割你的柱状图x轴长度）
                    textStyle: false
                }],
                toolbox: {
                    show: true,
                    x: '75%',
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
                series: [{
                    name:data.legendData[0],
                    type: 'line',
                    data: data.lineOneData,
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
                }, {
                    name:data.legendData[1],
                    type: 'line',
                    data: data.lineOneDataSpare,
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
                }
                ]
            };


            // 使用刚指定的配置项和数据显示图表。
            myChart.setOption(option);
        }

        function initEachartRight(data) {
            // 基于准备好的dom，初始化echarts实例
            var myChart = echarts.init(document.getElementById('echartRight'), 'macarons');

            // 指定图表的配置项和数据
            option = {
                title: {
                    x: '12px',
                    text: data.title
                },
                tooltip: {
                    trigger: 'axis'
                },
                legend: {
                    data: ["速率", "累计"],
                    textStyle: {
                        color: "#fff"
                    }
                },
                grid: {
                    bottom: 50,
                    containLabel: true
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
                    x: '75%',
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
                    data: data.legendData
                }],
                yAxis: [{
                    type: 'value'
                }],
                series: [{
                    name: "速率",
                    type: 'line',
                    data: data['rate'],
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
                }, {
                    name: "累计",
                    type: 'line',
                    data: data['sum'],
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
                }
                ]
            };
            // 使用刚指定的配置项和数据显示图表。
            myChart.setOption(option);
        }
    });

    function getMonitorData(form) {
        var structureId = $("#structureId").val();
        var index = layer.load();
        $.ajax({
            type: 'POST',
            url: ctx + '/processing/getMonitorData',
            data: {
                "structureId": structureId
            },
            dataType: 'json',
            success: function (res) {
                $('.mtype').html('');
                if (res.success == '1') {
                    layer.close(index);
                    $.each(res.data, function (i, item) {
                        str = '<option value="' + item.id + '">' + item.name + '</option>';
                        $('.mtype').append(str);
                    });
                    form.render();
                    form.on('select(monitorType)', function (data) {
                        var index = layer.load();
                        $.ajax({
                            type: 'POST',
                            url: ctx + '/processing/getMonitorItem',
                            data: {
                                'typeId': data.value
                            },
                            dataType: 'json',
                            success: function (res) {
                                if (res.success == '1') {
                                    layer.close(index);
                                    $('.mproject').html('');
                                    $.each(res.data, function (i, item) {
                                        str = '<option value="' + item.id + '">' + item.name + '</option>';
                                        $('.mproject').append(str);
                                    });
                                    form.render();
                                    form.on('select(monitorProject)', function (data) {
                                        var index = layer.load();
                                        $.ajax({
                                            type: 'POST',
                                            url: ctx + '/processing/getParam',
                                            data: {
                                                'itemId': data.value
                                            },
                                            dataType: 'json',
                                            success: function (res) {
                                                if (res.success == '1') {
                                                    layer.close(index);
                                                    $('.mparam').html('');
                                                    $.each(res.data, function (i, item) {
                                                        str = '<option value="' + item.id + '">' + item.name + '</option>';
                                                        $('.mparam').append(str);
                                                    });
                                                    form.render();
                                                    form.on('select(monitorParam)', function (data) {
                                                        var index = layer.load();
                                                        $("#monitorParamText").val($(data.elem).find("option:selected").html());
                                                        $.ajax({
                                                            type: 'POST',
                                                            url: ctx + '/processing/getSpoy',
                                                            data: {
                                                                'paramId': data.value,
                                                                'projectId': $("#flagProjectId").val()
                                                            },
                                                            dataType: 'json',
                                                            success: function (res) {
                                                                if (res.success == '1') {
                                                                    layer.close(index);
                                                                    $('.mspot').html('');
                                                                    $.each(res.data, function (i, item) {
                                                                        str = '<option value="' + item.id + '">' + item.name + '</option>';
                                                                        $('.mspot').append(str);
                                                                    });
                                                                    form.render();
                                                                }
                                                            }
                                                        });
                                                        form.render('select');
                                                    });
                                                }
                                            }
                                        });
                                        form.render('select');
                                    });
                                }
                            }
                        });
                        form.render('select');
                    });
                }
            }
        });
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