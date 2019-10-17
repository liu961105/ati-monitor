<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/public/taglib.jspf"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<style type="text/css">
.device-li {
	border: #ddd;
	background: #fff;
}
.device-li ul {
	overflow: hidden;
}
.device-li .it.user {
    background: #c3c2c2;
}
.device-li .it {
    float: left;
    padding: 10px;
    width: 180px;
    height: 80px;
    border-radius: 4px;
    margin-right: 14px;
    margin-bottom: 14px;
    cursor: pointer;
}
.device-li .it .img {
    width: 40px;
    height: 40px;
    float: left;
}
.device-li .it .user-name, .device-li .it .user-gh, .device-li .it .user-gw {
    margin-left: 50px;
    width: 130px;
    overflow: hidden;
    text-align: left;
    line-height: 22px;
}
.device-li .it .user-name {
    font-weight: bold;
    font-size: 18px;
}
.device-li .it img {
    width: 40px;
    height: 40px;
}
.topSelect{
    margin-left: 15px;
}
.topSelect li {
    display: inline-block;
}
.device-li .it.disuser {
    background: #97c9ff;
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
	<!-- 人员选择弹窗开始 -->
	<div id="userOpen">
		<div class="layui-row" style="margin-bottom: 12px; margin-top: 5px;">
			<ul class="topSelect">
				<li><input class="layui-input"  id="userName" placeholder="输入员工姓名、工号查询"></li>
				<li><button type="button" class="layui-btn layui-btn-normal" id="selectUser">搜索</button></li>
				<li><button type="button" class="layui-btn" id="saveGroupUser">保存</button></li>
			</ul>
		</div>
		<div class="device-li" style="padding-left:14px;">
			<ul id="user-ul">
				
			</ul>
		</div>
		<div id="pagefenye" class="fenye" style="text-align: center;"></div>
	</div>
	<!-- 人员选择弹窗结束 -->
<script type="text/javascript">
var useridArr = ${sysUsers};
$(function(){
	getUserList('1','9','');
	
	//双击添加用户
	$('#user-ul').on('dblclick', '.it',function(){
		var userId = $(this).data('userid');
	  	if($(this).hasClass('disuser')){
			$(this).removeClass('disuser').addClass('user');
			useridArr = $.grep(useridArr, function(value) {
			 return value != userId;
			});
	  	}else{
			$(this).removeClass('user').addClass('disuser');
			useridArr.push(userId);
	  	}
	});
	
	//根据员工姓名或员工工号查询员工
	$('#selectUser').on('click',function(){
		var userName = $('#userName').val();
		getUserList('1','9',userName);
	});
	
	//班组关联人员保存
	$("#saveGroupUser").click(function(){
		var groupId = "${groupId}";
		var userids = "";
		for(var i=0;i<useridArr.length;i++){
			userids+=useridArr[i]+",";
		}
		userids = userids.substr(0,userids.length-1);
		$.ajax({
			url:"${ctx}/sysGroup/saveGroupUser",
			type:"post",
			data:{"groupId":groupId,"userids":userids},
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

/*******获取人员*******/
function getUserList(start,pageSize,userName){
 	$.ajax({
 		type:'POST',
 		url:'${ctx}/prodSchedu/getUserList',
 		data:{'start':start,'pageSize':pageSize,'userName':userName},
 		dataType:'json',
 		success:function(res){
 			if(res.success=='1'){
				var userList = res.data.content;
				$('#user-ul').empty();
 				for(var i=0;i<userList.length;i++){
					var $li = '';
					$li+='<li data-userid="'+userList[i].userId+'" class="it user">';
					$li+='<div class="img"><i class="layui-icon" style="font-size: 30px; color: #656a6d">&#xe612;</i>  </div>';
					$li+='<div class="user-name">'+userList[i].rolename+'</div>';
					$li+='<div class="user-gh">'+(userList[i].usercode=="null"||userList[i].usercode==null?"":userList[i].usercode)+'</div>';
					$li+='<div class="user-gw">'+(userList[i].postName=="null"||userList[i].postName==null?"":userList[i].postName)+'</div>';
					$li+='</li>';
					$('#user-ul').append($li);
 				}
 				getUserPage(res.data.totalElements,res.data.size,res.data.number+1,userName);
				
				//加载关联人员
				var userid = "";
				for(var i=0;i<useridArr.length;i++){
					userid = useridArr[i];
					$("#user-ul").find("li[data-userid='"+userid+"']").addClass('disuser');
				}
 			}
 		}
 	});
}

function getUserPage(count,pageSize,pageNo,userName){
	layui.use(['laypage', 'layer'], function(){
		var laypage = layui.laypage,layer = layui.layer;
		//完整功能
		laypage.render({
   			elem: 'pagefenye',
   			count: count || 0,
			theme: '#009587',
			limit : pageSize||9,
			limits:[9],
			curr :pageNo||1,
			layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip'],
			jump: function(obj,first){
				if(!first){
	 				getUserList(obj.curr,obj.limit,userName);
				}
			}
		});
	});
}
</script>
</body>
</html>