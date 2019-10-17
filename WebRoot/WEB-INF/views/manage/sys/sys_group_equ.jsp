<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/public/taglib.jspf"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
.device-li-it ul {
    overflow: hidden
}

.device-li-it .it {
	float: left;
	padding: 10px;
	width: 80px;
    height: 70px;
	border-radius: 4px;
	margin-right: 14px;
	margin-bottom: 14px;
	cursor:pointer;
}
.device-li-it .bad {
    background: #c3c2c2;
    border: 3px solid #c3c2c2;
}
.device-li-it .it.disuser {
    background: #97c9ff;
    border: 3px solid #97c9ff;
}
.topSelect{
    margin-left: 15px;
}
.topSelect li {
    display: inline-block;
}
</style>
<link rel="stylesheet" href="${ctx}/res/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/res/css/manage/tree-app.css" type="text/css" />
<link rel="stylesheet" href="${ctx}/res/js/lib/layui/css/layui.css" media="all">
<script src="${ctx}/res/js/lib/jquery/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="${ctx}/res/ztree/js/jquery.ztree.all-3.5.min.js"></script>
<script src="${ctx}/res/js/lib/layui/layui.js"></script>
<script src="${ctx}/res/js/lib/layui/layui.all.js"></script>
<script src="${ctx}/res/js/main.js"></script>
</head>
<body>
	<!-- 设备选择弹窗开始 -->
	<div id="deviceOpen">
		<!-- 搜索 -->
		<div class="layui-row" style="margin-bottom: 12px; margin-top: 5px;">
			<ul class="topSelect">
				<li><input class="layui-input" id="deviceCode" placeholder="输入设备号、设备名称查询"></li>
				<li><button type="button" class="layui-btn layui-btn-normal" id="selectDevice">搜索</button></li>
				<li><button type="button" class="layui-btn" id="saveGroupEqu">保存</button></li>
			</ul>
		</div>
		<div class="device-li-it" style="padding-left:14px;">
			<ul id="device-ul">
				
			</ul>
		</div>
		<div id="devicePage" class="fenye" style="text-align: center;"></div>
	</div>
	<!-- 设备选择弹窗结束 -->	
<script type="text/javascript">
var deviceidArr = ${equs};

$(function(){
	getDeviceList('1','9','');
	
	//双击添加设备
	$('#device-ul').on('dblclick', '.it',function(){
  		var userId = $(this).data('deviceid');
	  	if($(this).hasClass('disuser')){
			$(this).removeClass('disuser').addClass('bad');
			deviceidArr = $.grep(deviceidArr, function(value) {
			 return value != userId;
			});
	  	}else{
			$(this).removeClass('bad').addClass('disuser');
			deviceidArr.push(userId);
	  	}
	});
	
	//根据设备编号或者设备名称获取设备
	$('#selectDevice').on('click',function(){
		var deviceCode = $('#deviceCode').val();
		getDeviceList('1','9',deviceCode);
	});
	
	//班组关联设备保存
	$("#saveGroupEqu").click(function(){
		var groupId = "${groupId}";
		var deviceids = "";
		for(var i=0;i<deviceidArr.length;i++){
			deviceids+=deviceidArr[i]+",";
		}
		deviceids = deviceids.substr(0,deviceids.length-1);
		$.ajax({
			url:"${ctx}/sysGroup/saveGroupEqu",
			type:"post",
			data:{"groupId":groupId,"deviceids":deviceids},
			dataType:"json",
			success : function(res){
	 			if(res.success=='1'){
	 				layer.msg(res.message, {icon: 6,time:1000},function(){
	 					var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
	 					parent.layer.close(index); //再执行关闭 
	 				});
	 			}else{
	 				layer.msg(res.message, {icon: 5});
	 			}
	 		},
	 		error:function(){
	 			layer.msg('网络异常，请稍后再试', {icon: 7});
	 		}
		});
	})
})

/*******获取设备*******/
function getDeviceList(start,pageSize,code){
 	$.ajax({
 		type:'POST',
 		url:'${ctx}/prodSchedu/getEquList',
 		data:{'start':start,'pageSize':pageSize,'code':code},
 		dataType:'json',
 		success:function(res){
 			if(res.success=='1'){
				var deviceList = res.data.content;
				$('#device-ul').empty();
 				for(var i=0;i<deviceList.length;i++){
					var $li = '';
					$li+='<li class="it bad" data-deviceid='+deviceList[i].id+'>';
					$li+='<div class="name">'+deviceList[i].name+'</div>';
					$li+='</li>';
					$('#device-ul').append($li);
 				}
 				getDevicePage(res.data.totalElements,res.data.size,res.data.number+1,code);
 				
 				
 				//加载关联设备
				var deviceid = "";
				for(var i=0;i<deviceidArr.length;i++){
					deviceid = deviceidArr[i];
					$("#device-ul").find("li[data-deviceid='"+deviceid+"']").removeClass('bad').addClass('disuser');
				}
 			}
 		}
 	});
 }

function getDevicePage(count,pageSize,pageNo,code){
	layui.use(['laypage', 'layer'], function(){
		var laypage = layui.laypage,layer = layui.layer;
		//完整功能
		laypage.render({
		    elem: 'devicePage',
		    count: count || 0,
		    theme: '#009587',
		    limit : pageSize||5,
		    limits:[5,10],
		    curr :pageNo||1,
		    layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip'],
		    jump: function(obj,first){
				if(!first){
					getDeviceList(obj.curr,obj.limit,code);
				}
			}
		});
	});
}
</script>
</body>
</html>