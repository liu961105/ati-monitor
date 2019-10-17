<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/public/taglib.jspf"%>
<%-- <link rel="stylesheet" href="${ctx}/res/js/lib/zTree_v3/css/zTreeStyle/zTreeStyle.css?2"> --%>
<style type="text/css">
.title-top{
    height: 18px;
    line-height: 18px;
    font-size: 18px;
    color: #0072ff;
    margin-bottom: 12px;
}
.title-icon{
    display: inline-block;
    background-size: 100% 100%;
    width: 20px;
    height: 16px;
    background:url("${ctx}/res/img/manage/title_icon.png");
}
.p-img{
height: 4px;
    background: url("${ctx}/res/img/manage/p1.png");
    margin-bottom: 20px;
}
.search-group li{
display: inline-block;
flow: right;
}
.label .check_btn {
    display: inline-block;
    width: 18px;
    height: 18px;
    border: 1px solid #cfd9db;
    vertical-align: middle;
    margin-right: 12px;
    cursor: pointer;
 }
 .requied:before {
	content: "*";
	display: inline-block;
	margin-right: 4px;
	line-height: 1;
	font-family: SimSun;
	font-size: 12px;
	color: #f30;
}
.layui-table td, .layui-table th {
	word-break: break-all;
}
#handout_wrap_inner {
	height:98%!important;
}
</style>
<div id="data-list" style="margin-top:25px;">
	<div class="banner" style="display:none;">
		<span class="base-blue-01 base-search" data-title='文件历史列表'></span>
	</div>
	<div class="top"> 
		<h3 class="title-top">
			<span class="title-icon"></span>
		 	<span >文件列表</span>
		 </h3>
	</div>
	<div class="p-img"></div>
	<!-- 搜索 -->
	<div  class="layui-row" style=" margin-bottom: 12px;">
		<ul class="search-group" style="float: right;">
			<li><input class="layui-input" style="width: 270px;" id="productModel" value="${productModel}" placeholder="文件名称/ 所属目录"></li>
			<li><button  class="layui-btn layui-btn-normal" id="selectOrder">搜索</button></li>
			<li>
				<shiro:hasPermission name="fileManage:downFile"> <button  class="layui-btn layui-btn-normal" id="downloadFile">下载</button></shiro:hasPermission>
			</li>
			<li>
				<shiro:hasPermission name="fileManage:deletes"> <button  class="layui-btn layui-btn-danger" id="fileDeletes">删除</button></shiro:hasPermission>
			</li>
		</ul>
	</div>
	<div style="margin-top:15px;">
		<table class="layui-table">
		<colgroup>
		    	<col >
		    	<col width="80">
		    	<col width="300">
		    	<col width="180">
		    	<col width="180">
		    	<col width="100">
		    	<col width="100">
		    	<col width="200">
		  	</colgroup> 
			<thead>
				<tr>
					<th style="width:15px;"><div class="label"><input id="checkAll"  type="checkbox" class="check_btn"></div></th>
					<th style="width:30px;">序号</th>
					<th>文件名称</th>
					<th>文件类型</th>
					<th style="width:100px;">所属目录</th>
					<th style="width:30px;">是否锁定</th>
					<th style="width:30px;">是否失效</th>
					<th style="width:100px;">上传时间</th>
					<!-- <th>审核状态</th> -->
					<th style="width: 250px;">操作</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${page.content}" var ="fileM" varStatus="status">
					<tr>
						<td>
							<div class="label">
								<input data-id="${fileM.id}" name="fileItem" value="${fileM.id}" data-shstate="${fileM.shStatus}" data-state="${fileM.status}" data-name="${fileM.fileName}" data-url="${fileM.filePath}" type="checkbox" class="check_btn" >
							</div>
						</td>
						<td>${status.count}</td>
						<td><a onclick="openOffice('${fileM.filePath}','docx');">${fileM.fileName}</a></td>
						<td>${fileM.sysParam.paramName}</td>
						<td>${fileM.fileCatalog.catalogName}</td>
						<td>
							<c:if test="${fileM.shStatus eq '1'}">否</c:if>
							<c:if test="${fileM.shStatus eq '0'}">是</c:if>
						</td>
						<td>
							<c:if test="${fileM.status eq '1'}">否</c:if>
							<c:if test="${fileM.status eq '0'}">是</c:if>
						</td>
						<td>${fileM.uploadTime}</td>
						<%-- <td>
							<c:if test="${fileM.shStatus eq '0'}">待审核</c:if>
							<c:if test="${fileM.shStatus eq '1'}">审核通过</c:if>
							<c:if test="${fileM.shStatus eq '2'}">审核不通过</c:if>
						</td> --%>
						<td>
							<c:if test="${fileM.shStatus eq '1'}">
							<shiro:hasPermission name="fileManage:lockFile"> 
								<button class="layui-btn layui-btn-sm layui-btn layui-btn-normal" onclick="operateFile('${fileM.id}','fileLockOpt','0');">锁定</button>
							</shiro:hasPermission> 
							</c:if>
							<c:if test="${fileM.shStatus eq '0'}">
							<shiro:hasPermission name="fileManage:unLockFile">
								<button class="layui-btn layui-btn-sm layui-btn-warm" onclick="operateFile('${fileM.id}','fileLockOpt','1');">解锁</button>
							</shiro:hasPermission> 
							</c:if>
						 	<c:if test="${fileM.status eq '1'}">
						 	<shiro:hasPermission name="fileManage:loseFile">
								<button class="layui-btn layui-btn-sm layui-btn-danger" onclick="operateFile('${fileM.id}','fileLoseOpt','0');">失效</button>
							</shiro:hasPermission> 
						 	</c:if>
							<c:if test="${fileM.status eq '0'}">
							<shiro:hasPermission name="fileManage:recoverFile">
								<button class="layui-btn layui-btn-sm" onclick="operateFile('${fileM.id}','fileLoseOpt','1');">恢复</button>
							</shiro:hasPermission> 
							</c:if>
							<shiro:hasPermission name="fileManage:deleteFile">
								<button class="layui-btn layui-btn-sm layui-btn layui-btn-primary" onclick="operateFile('${fileM.id}','fileDelete','0');">删除</button>
							</shiro:hasPermission> 
							<c:if test="${(fileM.status ne '0') and (fileM.shStatus ne '0')}">
							<shiro:hasPermission name="fileManage:fileYl">
								<button class="layui-btn layui-btn-sm layui-btn" onclick="filePreview('${fileM.fileName}','${fileM.filePath}');">预览</button>
							</shiro:hasPermission> 
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div id="pagefenye" class="fenye" style="text-align: center;"></div>
	</div>
	<!-- <iframe src='https://view.officeapps.live.com/op/view.aspx?src=/upload/11111.xls' width='100%' height='100%' frameborder='1'>
            </iframe> -->
</div>
<div id="handout_wrap_inner" style="display:none;"></div>
<script src="${ctx}/res/js/main.js"></script>
<script src="${ctx}/res/js/jquery.media.js"></script>
 <script type="text/javascript">
layui.use(['laypage', 'layer'], function(){
	var laypage = layui.laypage,layer = layui.layer;
	//完整功能
	$.initThirdTitle();
	laypage.render({
	    elem: 'pagefenye',
	    count: ${page.totalElements},
	    theme: '#009587',
	    limit : ${page.size},
	    limits:[5, 10, 20, 30, 40],
	    curr : ${page.number+1},
	    layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip'],
	    jump: function(obj,first){
			if(!first){
	  			var productModel = $("#productModel").val();
	 			$("#data-list").load("${ctx}/fileManage/pageHisList?start="+obj.curr+"&pageSize="+obj.limit+"&productModel="+productModel);
			}
		}
	});
});

$(function(){
	//条件查询
	$('#selectOrder').click(function(){
		var productModel = $("#productModel").val();
		$("#data-list").load("${ctx}/fileManage/pageHisList?productModel="+productModel);
	});
	//全选/反选
	$("#checkAll").click(function() { 
		if (this.checked){  
	        $("input[name='fileItem']:checkbox").each(function(){ 
	              $(this).attr("checked", true);  
	        });
	    } else {
	        $("input[name='fileItem']:checkbox").each(function() {   
	              $(this).attr("checked", false);  
	        });
	    }  
	});
	
	//批量下载
	$("#downloadFile").on("click",function(){
		var fileNames = "";
		var filePaths = "";
		var flagName = "[";
		var tmp="";
		$("input[name='fileItem']").each(function(){
			var shState = $(this).data("shstate");
			var state = $(this).data("state");
			var fileName = $(this).data("name");
			var filePath = $(this).data("url");
			if (this.checked) {
				fileNames+=fileName+",";
				filePaths+=filePath+",";
			}
			if(shState=="0" || state=="0") {
				flagName +=fileName+"]、[";
				tmp+=fileName+",";
			}
		});
		if(fileNames==""){
			layer.msg("请选择文件");
		}else if(tmp != ""){
			flagName = flagName.substr(0, flagName.length-2);
			layer.alert("已选文件中,文件"+flagName+"已被锁定或失效，无法下载,请重新选择！");
		}else {
			window.location.href = "${ctx}/fileManage/downLoad2?fileNames="+fileNames+"&filePaths="+filePaths;
		}
	});
	
	//批量删除
	$("#fileDeletes").click(function(){
		var productModel = $("#productModel").val();
		var ids="";
		var fileNames="";
		var flagName = "[";
		$("input[name='fileItem']").each(function(){
			var fileName = $(this).data("name");
			var thisId = $(this).data("id");
			if (this.checked) {
				fileNames+=fileName+",";
				ids+=thisId+",";
				flagName +=fileName+"]、[";
			}
			
		});
		if(ids==""){
			layer.msg("请选择文件");
		}else {
			fileNames = fileNames.substr(0, fileNames.length-1);
			ids = ids.substr(0, ids.length-1);
			flagName = flagName.substr(0, flagName.length-2);
			layer.confirm('确定刪除文件'+flagName+'吗？', {
	  			  btn: ['确定','取消'] //按钮
	  			}, function(){
  				$.ajax({
  					url:"${ctx}/fileManage/fileDelete",
  					type:"post",
  					data:{"fileIds":ids},
  					dataType:"json",
  					success:function(data){
  						if(data.success=="success"){
  							layer.msg(data.message,{time:1500});
  							$("#data-list").gotoNewLink({
  								url : "${ctx}/fileManage/pageHisList",
  								data:{
  									"productModel":productModel
  								}
  							});
  						}else{
  							layer.msg(1, {
  					  			content: data.message,
  					  			time: 1500,
  					  			success: function(layero) {					
  					  				layero.css({'background-color':'#F00'});					
  								    layero.find('.layui-layer-content').css({
  									     'color': '#FFFFFF',
  									     'font-size': '13px'
  									});
  								}
  							});
  						}
  					},
  					error:function(){
  						layer.msg(1, {
  				  			content: '网络故障，请稍后再试',
  				  			time: 1500,
  				  			success: function(layero) {					
  				  				layero.css({'background-color':'#F00'});					
  							    layero.find('.layui-layer-content').css({
  								     'color': '#FFFFFF',
  								     'font-size': '13px'
  								});
  							}
  						});
  					}
  				})
	  		});
		}
	})
	
})
  
	
function operateFile(fileId,url,state){
	var productModel = $("#productModel").val();
	var jumpUrl = "${ctx}/fileManage/"+url;
	if(url=="fileDelete"){
		layer.confirm('确定刪除吗？', {
			btn: ['确定','取消'] //按钮
		}, function(){
			$.ajax({
				url:jumpUrl,
				type:"post",
				data:{"fileIds":fileId},
				dataType:"json",
				success:function(data){
					if(data.success=="success"){
						layer.msg(data.message,{time:1500});
						$("#data-list").gotoNewLink({
							url : "${ctx}/fileManage/pageHisList",
							data:{
								"productModel":productModel
							}
						});
					}else{
						layer.msg(1, {
				  			content: data.message,
				  			time: 1500,
				  			success: function(layero) {					
				  				layero.css({'background-color':'#F00'});					
							    layero.find('.layui-layer-content').css({
								     'color': '#FFFFFF',
								     'font-size': '13px'
								});
							}
						});
					}
				},
				error:function(){
					layer.msg(1, {
			  			content: '网络故障，请稍后再试',
			  			time: 2000,
			  			success: function(layero) {					
			  				layero.css({'background-color':'#F00'});					
						    layero.find('.layui-layer-content').css({
							     'color': '#FFFFFF',
							     'font-size': '13px'
							});
						}
					});
				}
			})
		});
	}else {
		$.ajax({
			url:jumpUrl,
			type:"post",
			data:{"fileId":fileId,"state":state},
			dataType:"json",
			success:function(data){
				if(data.success=="success"){
					layer.msg(data.message,{time:1500});
					$("#data-list").gotoNewLink({
						url : "${ctx}/fileManage/pageHisList",
						data:{
							"productModel":productModel
						}
					});
				}else{
					layer.msg(1, {
			  			content: data.message,
			  			time: 1500,
			  			success: function(layero) {					
			  				layero.css({'background-color':'#F00'});					
						    layero.find('.layui-layer-content').css({
							     'color': '#FFFFFF',
							     'font-size': '13px'
							});
						}
					});
				}
			},
			error:function(){
				layer.msg(1, {
		  			content: '网络故障，请稍后再试',
		  			time: 1500,
		  			success: function(layero) {					
		  				layero.css({'background-color':'#F00'});					
					    layero.find('.layui-layer-content').css({
						     'color': '#FFFFFF',
						     'font-size': '13px'
						});
					}
				});
			}
		})
	}
}


function filePreview(fileName,filePath){
	var lodding = layer.load(0, {shade: false});
	$.ajax({
		url:"${ctx}/fileManage/filePreview",
		type:"post",
		data:{"fileName":fileName,"filePath":filePath},
		dataType:"json",
		success:function(res){
			layer.close(lodding);
			if(res.success=="success"){
				$('#handout_wrap_inner').media({
			        width: '99%',
			        height: '100%',
			        autoplay: true,
			        src:'/upload/'+res.data,
			    });
			    layer.open({
				  type: 1,
				  skin: 'layui-layer-rim', //加上边框
				  area: ['900px', '800px'], //宽高
				  shade:false,
				  content: $("#handout_wrap_inner")
				});
			}else{
				showErrorTip(res.message);
			}
		},
		error:function(){
			layer.close(lodding);
			showErrorTip(res.message);
		}
	})
}

</script> 