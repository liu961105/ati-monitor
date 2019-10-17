<%@ page language="java" pageEncoding="utf-8"%>
<%@include file="/WEB-INF/views/public/taglib.jspf"%>

<link rel="stylesheet" href="${ctx}/res/ati_monitor/css/base.css">
<link rel="stylesheet" href="${ctx}/res/ati_monitor/css/jquery.page.css">
<link rel="stylesheet" href="${ctx}/res/ati_monitor/css/baseless.css">
<link rel="stylesheet" href="${ctx}/res/ati_monitor/css/index.css">


<div class="banner" style="display:none;">
		<span class="base-blue-01 base-search" data-title='项目管理'>项目管理</span>
</div>

<div class="wapper" style="height: 100%;background-color: #171939">
	<section class="contaiter-right">
		<section class="n-contaiter">
			<div class="left">
				<h3>项目查看</h3>
				<form id="searchProjectForm">
					<ul class="n-form">
						<li>
							<label >项目名称：</label> <input type="text" name="projectName" id="projectName">
							<label>项目状态：</label>
							<select id="projectStatus"  name="projectStatus">
								<option value="">全部</option>
								<option value="0">正常</option>
								<option value="1">异常</option>
							</select>
						</li>
						<li>
							<label >项目地址：</label> <input type="text" name="address" id="address">
							<button type="button" id="searchProjectBtn" class="m-btn m-btn-success">搜索</button>
						</li>
					</ul>
				</form>
				<table class="m-table" cellspacing="0" cellpadding="0">
					<thead>
					<tr>
						<th style="width: 3vw;">序号</th>
						<th width="36%">项目地址</th>
						<th width="33%">项目名称</th>
						<th width="15%">项目状态</th>
						<th>操作</th>
					</tr>
					</thead>
					<tbody class="J_table">

					</tbody>
				</table>
				<ul style="margin-top: 16px;" id="page"></ul>
			</div>
			<div class="right">
				<div class="right-top">
					<ul class="charts">
						<li id="charts1">

						</li>
						<li class="on" id="charts2">

						</li>
						<li id="charts3" >

						</li>
					</ul>
				</div>
				<div class="right-center">
					<h3>告警地点分布</h3>
					<div class="map" id="map" style="width: 30vw;height: 30vw;">

					</div>
				</div>
			</div>
		</section>
	</section>

</div>
<script src="${ctx}/res/ati_monitor/js/jquery.page.js"></script>
<!-- 字符云，右边的阿里巴巴 -->
<script src="${ctx}/res/ati_monitor/js/hmap.js"></script>

<script type="text/javascript">
    $(function () {
        //首页启动时候 加载遮罩
		var lodeIndex = layer.load();
        initECharts();

        pageData();

        $("#searchProjectBtn").on('click',function () {
            pageData(1);
        })

        function pageData(pageIndex) {
            var pageDataUrl = "${ctx}/atiProject/projectPageInfo";
            //获取参数
            var formData = serializeObject($("#searchProjectForm"));
            formData['pageCurrent'] = pageIndex;
            formData['projectStructureId'] = $("#structureId").val();
            $.post(pageDataUrl,formData,function (data) {
                if(data.success == '1' || data.success == '2'){
                    data = data.data;
                    var totalPages = data.totalPages;
                    pushPageData(data.content)
                    $("#page").Page({
                        totalPages: totalPages,//分页总数
                        liNums: 10,//分页的数字按钮数(建议取奇数)
                        activeClass: 'activP', //active 类样式定义
                        indexPage:pageIndex,
                        callBack: function (page) {
                            pageData(page)
                        }
                    });
                }else{
                    //弹出错误
                }
                layer.close(lodeIndex);
            })
        }
        function pushPageData(data) {
            var html = "";
            if(data != null && data.length > 0){
                for (var index = 0; index < data.length; index++) {
                    html += '<tr>\n' +
                        '        <td>'+(index * 1 + 1)+'</td>\n' +
                        '        <td>'+data[index].address+'</td>\n' +
                        '        <td>'+data[index].projectName+'</td>\n' +
                        '        <td>\n' ;
                    if(data[index].warnCount > 0){
                        html+='<button type="button" style="width: 50%" class="m-btn m-btn-warning">'+"异常"+'</button> &nbsp;&nbsp;\n'
                    }else {
                        html+='<button type="button" style="width: 50%" class="m-btn m-btn-success">'+"正常"+'</button> &nbsp;&nbsp;</td>\n'
                    }
                    html+= '         <td> <button type="button" class="m-btn m-btn-primary" onclick="intoProject(\''+data[index].id+'\',\''+data[index].projectName+'\')">查看</button>\n' +
                        '        </td>\n' +
                        '    </tr>';
                }
			}else{
				html = '<h1 style="width: 47vw;text-align: center;">暂无数据</h1>';
            }

            $(".J_table").html(html);
        }


    });

	function serializeObject(form) {
        var o = {};
        var a = form.serializeArray();
        $.each(a, function() {
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

    function intoProject(projectId,projectName) {
    	$("#flagProjectId").val(projectId);
    	$(".second-title").show();
    	$(".second-title").text(projectName);
    	$(".spread-btn").hide();
    	var _this = $("#menuTopRight li:eq(0)");
    	var topRightFirstId = _this.data("id");
    	$(".bread-dis li:eq(1)").show();
    	$(".bread-dis li:eq(1) span").text("工程信息");
		$(".bread-dis li:eq(1)").addClass("base-blue-01");
		$(".bread-dis li:eq(2)").hide();
		_this.addClass("layui-this").siblings().removeClass("layui-this");
		$("#menuLeft").empty();
		var parentId = _this.data("id");
		intitLeftMenus(getMenus(parentId));
		$("#menuLeft li:eq(0)").addClass("layui-this").siblings().removeClass("layui-this");
    	$("#menu_l").animate({width: '200px'});
		$(".mainCont").animate({left: '200px'});
    	$(".data-content").gotoNewLink({
            url: "${ctx}/route/manage/index/project_info",
        });
    }


    //init eCharts
	function initECharts() {
		//请求改数据
		var getCurrentProjectUrl = "${ctx}/atiProject/findCurrentBeResponsibleForProject";
		$.post(getCurrentProjectUrl,{projectStructureId:$("#structureId").val()},function (data) {
			data = data.data;
            gyMap(data.currentProject);
            var baseValue = 180;
            var warnCount = 0;
            var successCount = 0;
            var currentTotalProject = data.currentProject.length;
			var allTotalProject = data.projectTotal;
            var successSocer = 0;
            var warnSocer = 0;
            var totalSocer = 0;
            $.each(data.currentProject,function (i,item) {
				if(item.warnCount && item.warnCount > 0){
				    warnCount ++;
				}else {
				    successCount ++;
				}
            });
			//求正常数
			if(warnCount == 0){
			    successSocer = 180;
			}else {
			    successSocer = successCount / currentTotalProject * baseValue;
			}

			//求异常数
			if(successCount == 0){
			    warnSocer = 180;
			}else {
                warnSocer =  warnCount / currentTotalProject * baseValue;
			}

            //设置正常数
            setChartsVal("charts1", successCount,currentTotalProject,"正常数","#0dda8b");
            //设置异常数
            setChartsVal("charts2", warnCount,currentTotalProject,"异常数","#FF4500");

            //设置监测数
            setChartsVal("charts3", currentTotalProject,currentTotalProject,"监测数","#00ffff");
        })
    }

    function setChartsVal(dom, val,total,name,color) {
        var myChart = echarts.init(document.getElementById(dom));
        option = {
        backgroundColor:"#383c58",
            series: [{
                name: '刻度',
                type: 'gauge',
                radius: '130%',
                center:["49.7%","75%"],
                min: 0,
                backgroundColor:"red",
                max: total,//刻度
                splitNumber: 2, //刻度数量
                startAngle: 180,
                endAngle: 0,
                axisLine: {
                    show: false,
                    lineStyle: {
                        width: 1,
                        color: [
                            [1, 'rgba(0,0,0,0)']
                        ]
                    }
                }, //仪表盘轴线
                axisLabel: {
                    show: true,
                    color: '#3B53A2',
                    distance: 15,
                    fontSize: 6,
                    formatter: '{value}'
                }, //刻度标签。
                axisTick: {
                    show: true,
                    lineStyle: {
                        color: {
                            type: 'radial',
                            colorStops: [{
                                offset: 0,
                                color: '#77C664'
                            },

                                {
                                    offset: 0.2,
                                    color: '#2CB7C7'
                                },

                                {
                                    offset: 0.4,
                                    color: '#1DB2DD'
                                },

                                {
                                    offset: 0.6,
                                    color: '#2D89ED'
                                },

                                {
                                    offset: 0.8,
                                    color: '#7765B4'
                                },

                                {
                                    offset: 1,
                                    color: '#EB3457'
                                }
                            ],
                            globalCoord: false // 缺省为 false
                        },
                        width: 1,
                        length: 20,
                    },
                    length: -5
                }, //刻度样式
                splitLine: {
                    show: true,
                    length: -5,
                }, //分隔线样式
                detail: {
                    show: false
                },
                pointer: {
                    show: false
                }
            },
                {
                    type: 'gauge',
                    radius: '120%',
                    min: 0,
                    max: total,//总数
                    center: ['49.7%', '70%'],
                    splitNumber: 0, //刻度数量
                    startAngle: 180,
                    endAngle: 0,
                    pointer:{show:true,width:3},
                    axisLine: {
                        show: true,
                        lineStyle: {
                            width: 5,

                            color: [
                                [1,
                                    new echarts.graphic.LinearGradient(0, 0, 1, 0, [

                                        {
                                            offset: 0,
                                            color: '#77C664'
                                        },

                                        {
                                            offset: 0.2,
                                            color: '#2CB7C7'
                                        },

                                        {
                                            offset: 0.4,
                                            color: '#1DB2DD'
                                        },

                                        {
                                            offset: 0.6,
                                            color: '#2D89ED'
                                        },

                                        {
                                            offset: 0.8,
                                            color: '#7765B4'
                                        },

                                        {
                                            offset: 1,
                                            color: '#EB3457'
                                        }
                                    ])
                                ]
                            ],
                        }
                    },
                    //分隔线样式。
                    splitLine: {
                        show: false,
                    },
                    axisLabel: {
                        show: false
                    },
                    axisTick: {
                        show: false
                    },


                    //仪表盘详情，用于显示数据。
                    detail: {
                        show:true,
                        formatter : "{value|{value}}\n{name|"+name+"}",
                        offsetCenter: [0, "20%"],
                        rich : {
                            value : {
                                color : color,
                                fontFamily : "微软雅黑",
                                fontSize : 12,
                                height:20,
                            },
                            name : {
                                height : 10,
                                color : color,
                                fontFamily : "微软雅黑",
                                fontSize : 12
                            }
                        }
                    },
                    data: [{
                        //name: "当前用户总数:"+100,
                        value: val
                    }]
                }
            ]
        };

        myChart.setOption(option);
    }


</script>
