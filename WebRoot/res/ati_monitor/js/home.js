var warnLevel = "";
var runningState = "";
var dealStatus = "";
var monitorTypeName = "";
var sortOrder = "";
layui.use('layer', function() {
	var layer = layui.layer;			
});

$(function() {
	getMonitorType();
	getStatisticsData();
	warnLevel = "";
	runningState = "";
	dealStatus = "";
	monitorTypeName = "";
	sortOrder = "";
	$(".J_checkout").find("li").find("span").click(function() {
		var itemDad = $(this).parent().find('label').text();
		var itemBaby = $(this).text();
		if (itemDad == '安全等级：') {
			if (itemBaby == '黄色') {
				warnLevel = 1;
			} else if (itemBaby == '橙色') {
				warnLevel = 2;
			} else if (itemBaby == '红色') {
				warnLevel = 3;
			}else{
				warnLevel = '';
			}
		} else if (itemDad == '处理结果：') {
			if (itemBaby == '已处理') {
				dealStatus = 1;
			} else if (itemBaby == '未处理') {
				dealStatus = 0;
			}else{
				dealStatus = '';
			}
		} else if (itemDad == '数据状态：') {
			if (itemBaby == '正常') {
				runningState = 1;
			} else if (itemBaby == '异常') {
				runningState = 2;
			}else{
				runningState = '';
			}
		} else if (itemDad = '排序方式：') {
			if (itemBaby == '告警源') {
				sortOrder = 'monitorSitesName';
			} else if (itemBaby == '等级') {
				sortOrder = 'warnLevel';
			} else if (itemBaby == '告警产生时间') {
				sortOrder = 'uploadTime';
			}else{
				sortOrder='';
			}
		}
		$(this).addClass("on").siblings("span").removeClass("on");

	})
    
	$("#btn_search").click(function() {
		pageData(1);
	});
	
	pageData(1);

})

function getMonitorType() {
	var structureId = $("#structureId").val();
	var index = layer.load();
	$.ajax({
		type : 'POST',
		url : ctx + '/security/getMonitorType',
		data : {
			"structureId" : structureId
		},
		dataType : 'json',
		success : function(res) {
			layer.close(index); 
			$('.monitorType').html('');
			var html = "";
			if (res.success == '1') {
				$.each(res.data, function(i, item) {
					html += '<span>' + item.name + '</span>'
				});
				$('.monitorType').append('<label for="">监测类型：</label> (单选) <span class="on">全部</span>' + html);
				$('.monitorType').find("span").click(function() {
					var itemDad = $(this).parent().find('label').text();
					var itemBaby = $(this).text();
					if (itemDad == '监测类型：') {
						if (itemBaby == '全部') {
							monitorTypeName = '';
						} else {
							monitorTypeName = itemBaby;
						}
					}
					$(this).addClass("on").siblings("span").removeClass("on");
				});
			} else {
				//错误
				layer.close(index); 
			}
		}
	});


}


function getStatisticsData() {
	var projectId = $("#flagProjectId").val();

var index = layer.load();
	$.ajax({
		type : 'POST',
		url : ctx + '/security/getStatisticsData',
		data : {
			"projectId" : projectId
		},
		dataType : 'json',
		success : function(res) {	
			if (res.success == '1') {
				layer.close(index); 
				$(".level1").text('一级（'+res.data.level1+'）');
				$(".level2").text('二级（'+res.data.level2+'）');
				$(".level3").text('三级（'+res.data.level3+'）');
			} else {
				//错误
				layer.close(index); 
			}
		}
	});
}


function pageData(pageIndex) {
	var projectId = $("#flagProjectId").val();

var index = layer.load();
	$.ajax({
		type : 'POST',
		url : ctx + '/security/getSecurityPage',
		data : {
			"pageCurrent" : pageIndex,
			"warnLevel" : warnLevel,
			"runningState" : runningState,
			"dealStatus" : dealStatus,
			"projectId" : projectId,
			"monitorTypeName" : monitorTypeName,
			"sortOrder" : sortOrder,
			"monitorSitesIds":$("input[name='monitorSites']").val()
		},
		dataType : 'json',
		success : function(res) {
			if (res.success == '1') {
				layer.close(index); 
				var data = res.data;
				var totalPages = data.totalPages;
				pushPageData(data.content,pageIndex)
				$("#page").Page({
					totalPages : totalPages, //分页总数
					liNums : 9, //分页的数字按钮数(建议取奇数)
					activeClass : 'activP', //active 类样式定义
					indexPage : pageIndex,
					showtotalElements:true,
					totalElements:data.totalElements,
					callBack : function(page) {
						pageData(page)
					}
				});
				
			} else if (res.success == '2') {
				layer.close(index);
                $("#page").Page({
                    totalPages : 1, //分页总数
                    liNums : 9, //分页的数字按钮数(建议取奇数)
                    activeClass : 'activP', //active 类样式定义
                    indexPage : 1,
                    callBack : function(page) {
                    }
                });
				noData();
			}
		}
	});
}
function pushPageData(data,pageIndex) {
	var html = "";
	for (var index = 0; index < data.length; index++) {
		var warnlevel = '';
		if (data[index].warnLevel == 3) {
			warnlevel = '        <td><button type="button" class="m-btn m-btn-error" style="width: 3.2vw;"></button></td>\n'
		} else if (data[index].warnLevel == 2) {
			warnlevel = '        <td><button type="button" class="m-btn m-btn-warning" style="width: 3.2vw;"></button></td>\n'
		}else if(data[index].warnLevel == 1){
            warnlevel = '        <td><button type="button" class="m-btn btn-yellow" style="width: 3.2vw;"></button></td>\n'
		}else if(data[index].warnLevel == 0){
            warnlevel = '        <td><button type="button" class="m-btn m-btn-success" style="width: 3.2vw;"></button></td>\n'
		}

		var dealstatushtml = '';
		if (data[index].dealStatus == 1) {
			dealstatushtml = '        <td class=""><input type="hidden" name="id" value="'+data[index].id+'"><button  type="button" class="m-btn m-btn-success">已处理</button></td>\n'
		} else if (data[index].dealStatus == 0) {
			if(data[index].warnLevel == 0){
				dealstatushtml = '        <td class=""><input type="hidden" name="id" value="'+data[index].id+'"><button  type="button" class="m-btn m-btn-success">未处理</button></td>\n'
			}else{
				dealstatushtml = '        <td class="deal_btn"><input type="hidden" name="id" value="'+data[index].id+'"><button  type="button" class="m-btn m-btn-error">未处理</button></td>\n'	
			}
		}else{
            dealstatushtml = '        <td class=""><input type="hidden" name="id" value="'+data[index].id+'"><button  type="button" class="m-btn m-btn-warning" style="width: 4vw;">--</button></td>\n'
		}

		var dealTimehtml = '';
		 if (data[index].dealStatus == 0) {
			 dealTimehtml = '        <td>--</td>\n'
		}else{
		 	if(data[index].dealTime==null){
                dealTimehtml = '        <td>--</td>\n'
			}else {
                dealTimehtml = '        <td>' + data[index].dealTime + '</td>\n'
            }
		}


        var dealMsg = '';
        if (data[index].dealMessage!=null) {
            dealMsg = '<td style="    overflow: hidden;white-space: nowrap;text-overflow: ellipsis;">' + data[index].dealMessage + '</td>'
        }else{
            dealMsg = '<td>暂无信息</td>'
        }

        var dealUser = '';
        if (data[index].dealUser!=null) {
            dealUser = '<td>' + data[index].dealUser + '</td>'
        }else{
            dealUser = '<td>暂无确认人</td>'
        }

        var warnMessage = '';
        if (data[index].warnMessage!=null && data[index].warnMessage!='') {
            warnMessage = '        <td>' + data[index].warnMessage + '</td>\n'
        }else{
            warnMessage = '<td>暂无信息</td>'
        }


		html += '<tr>\n' +
					'<td>' + (index * 1 + 1) + '</td>\n' +
					'<td>' + data[index].monitorSitesName + '</td>\n' +
						warnlevel +
					'<td>' + data[index].deviceUploadData + '</td>\n' +
					'<td>' + data[index].deviceUploadDataSpare + '</td>\n' +
					'<td>' + data[index].uploadTime + '</td>\n' +
            warnMessage +
			dealTimehtml +
			dealstatushtml +
			dealMsg +
			dealUser +
			'  </tr>';
	}
	
	$(".J_table").html(html);
	$(".deal_btn").click(function(){
	   var id =$(this).find('input').val();
	   layer.open({
			title : '请输入处理信息',
			area : [ '600px', '200px' ],
			btn : false,
			content : '<form class="layui-form" action="">'+
			'<div class="layui-form-item">'+
			'<input id="input_text" type="text" name="title" lay-verify="title" autocomplete="off" placeholder="请输入处理信息" class="layui-input">'+
			'</div></form><br/>  <button id="commit_btn" type="button" class="layui-btn layui-btn-normal" style="margin-left: 23vw;">确认提交</button>'
		})
		$('#commit_btn').click(function(){
			var text =$('#input_text').val();

			var index = layer.load();

			$.ajax({
				type : 'POST',
				url : ctx + '/security/commitDealText',
				data : {
					"id" : id,
					"text" : text
				},
				dataType : 'json',
				success : function(res) {
					if (res.success == '1') {
						layer.close(index);
						layer.closeAll();
                        alertOk('提交成功！');
						pageData(pageIndex);
					}else{
						layer.close(index);
						layer.closeAll();
                        alertError('提交失败！');
					}
				}
			});
		
		});
	   
	});
}
function noData() {
	
	var html = '<h1 style="width: 85vw;text-align: center;">暂无数据</h1>';
	$(".zg").text('暂无数据');
	$(".J_table").html(html);
}



function init() {
	var html = "";
	for (let index = 0; index < 15; index++) {
		html += `<tr>
        <td>${index += 1}</td>
        <td>傳感器 拉线式位移1＃</td>
        <td><button type="button" class="m-btn m-btn-warning">二级</button></td>
        <td>2017-12-13 22:00:55</td>
        <td>传感器：拉线式位移1＃ 采集值为：［44:72］超出量程</td>
        <td>2017-12-13 22:00:55</td>
        <td>
          <button type="button" class="m-btn m-btn-error">未处理</button>
        </td>
        <td>处理人员：001</td>
    </tr>`;
	}
	$(".J_table").html(html);
}