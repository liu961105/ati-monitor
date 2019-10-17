<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/public/taglib.jspf"%>
<%-- <link rel="stylesheet" href="${ctx}/res/js/lib/zTree_v3/css/zTreeStyle/zTreeStyle.css?2"> --%>
<style type="text/css">
.title-top {
	height: 18px;
	line-height: 18px;
	font-size: 18px;
	color: #0072ff;
	margin-bottom: 12px;
}

.title-icon {
	display: inline-block;
	background-size: 100% 100%;
	width: 20px;
	height: 16px;
	background: url("${ctx}/res/img/manage/title_icon.png");
}

.p-img {
	height: 4px;
	background: url("${ctx}/res/img/manage/p1.png");
	margin-bottom: 20px;
}

.search-group li {
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
		<span class="base-blue-01 base-search" data-title='文件列表'></span>
	</div>
	<div class="top">
		<h3 class="title-top">
			<span class="title-icon"></span> <span>文件列表</span>
		</h3>
	</div>
	<div class="p-img"></div>
	<!-- 搜索 -->
	<div class="layui-row" style=" margin-bottom: 12px;">
		<%-- <div class="label layui-col-md4">
			<form action="${ctx}/order/exportExcel" method="post" onsubmit="return exportExcel();" id="exportOrder">
				 <shiro:hasPermission name="sysComp:exportOrder"><button class="layui-btn layui-btn-normal" style="margin-left: 10px;">导出</button></shiro:hasPermission>
				
			</form>
			
		</div> --%>
		<div class="layui-col-md3">
			<form class="form-x" method="post" enctype="multipart/form-data"
				id="uploadform">
				<div class="layui-upload">
					<shiro:hasPermission name="fileManage:importFile">
						<button type="button" class="layui-btn" id="uploadDialog">上传文件</button>
					</shiro:hasPermission>
				</div>
			</form>
		</div>
		<ul class="search-group" style="float: right;">
			<li><input class="layui-input" style="width: 270px;"
				id="productModel" value="${productModel}"
				placeholder="文件名称/ 所属目录"></li>
			<li><button class="layui-btn layui-btn-normal" id="selectOrder">搜索</button></li>
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
					<th >序号</th>
					<th>文件名称</th>
					<th>文件类型</th>
					<th >所属目录</th>
					<th >是否锁定</th>
					<th >是否失效</th>
					<th >上传时间</th>
					<!-- <th>审核状态</th> -->
					<th style="width: 250px;">操作</th>
				
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${pageVo.content}" var="fileM" varStatus="status">
					<tr>
						<td>
							<div class="label">
								<input data-id="${fileM.id}" name="fileItem" value="${fileM.id}" data-shstate="${fileM.sh_status}" data-state="${fileM.status}" data-name="${fileM.file_name}" data-url="${fileM.file_path}"
									type="checkbox" class="check_btn">
							</div>
						</td>
						<td>${status.count}</td>
						<td>${fileM.file_name}</td>
						<td>${fileM.param_name}</td>
						<td>${fileM.catalog_name}</td>
						<td><c:if test="${fileM.sh_status eq '1'}">否</c:if> <c:if
								test="${fileM.sh_status eq '0'}">是</c:if></td>
						<td><c:if test="${fileM.status eq '1'}">否</c:if> <c:if
								test="${fileM.status eq '0'}">是</c:if></td>
						<td>${fileM.upload_time}</td>
						<td><c:if test="${fileM.sh_status eq '1'}">
								<shiro:hasPermission name="fileManage:lockFile">
									<button
										class="layui-btn layui-btn-sm layui-btn layui-btn-normal"
										onclick="operateFile('${fileM.id}','fileLockOpt','0');">锁定</button>
								</shiro:hasPermission>
							</c:if> <c:if test="${fileM.sh_status eq '0'}">
								<shiro:hasPermission name="fileManage:unLockFile">
									<button class="layui-btn layui-btn-sm layui-btn-warm"
										onclick="operateFile('${fileM.id}','fileLockOpt','1');">解锁</button>
								</shiro:hasPermission>
							</c:if> <c:if test="${fileM.status eq '1'}">
								<shiro:hasPermission name="fileManage:loseFile">
									<button class="layui-btn layui-btn-sm layui-btn-danger"
										onclick="operateFile('${fileM.id}','fileLoseOpt','0');">失效</button>
								</shiro:hasPermission>
							</c:if> <c:if test="${fileM.status eq '0'}">
								<shiro:hasPermission name="fileManage:recoverFile">
									<button class="layui-btn layui-btn-sm"
										onclick="operateFile('${fileM.id}','fileLoseOpt','1');">恢复</button>
								</shiro:hasPermission>
							</c:if>
							<shiro:hasPermission name="fileManage:deleteFile">
								<button
									class="layui-btn layui-btn-sm layui-btn layui-btn-primary"
									onclick="operateFile('${fileM.id}','fileDelete','0');">删除</button>
							</shiro:hasPermission>
							<c:if test="${(fileM.status ne '0') and (fileM.sh_status ne '0')}">
							<shiro:hasPermission name="fileManage:fileYl">
								<button class="layui-btn layui-btn-sm layui-btn" onclick="filePreview('${fileM.file_name}','${fileM.file_path}');">预览</button>
							</shiro:hasPermission>
							</c:if>
							</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		<div id="pagefenye" class="fenye" style="text-align: center;"></div>
	</div>
	<div id="mainPage" style="display:none;width: 95%;margin:15px auto;">
		<form class="layui-form" id="orderForm"
			style="border: 1px solid #ddd;border-color: #e3e8ee;height: 300px;width: 98%;">
			<input type="hidden" value="${orderInfo.orderId}" name="orderId" />
			<input type="hidden" value="${orderInfo.createTime}" name="createTime" />
			<div style="padding-right: 30px;">
				<div class="layui-row" style="margin-top: 35px;">
					<div class="layui-col-xs6">
						<label class="layui-form-label requied">产品型号：</label>
						<div class="layui-input-block">
							<!-- <input type="text" id="productModelNum" name="productModelNum" lay-verify="required" placeholder="请输入产品型号" autocomplete="off" class="layui-input"> -->
							<select name="mfName" lay-filter="mfName" lay-verify=""
								lay-search>
								<option value="">请选择产品型号</option>
								<c:forEach items="${materielFiles}" var="mf">
									<option value="${mf.materielCode}">${mf.materielName}</option>
								</c:forEach>
							</select>
						</div>
					</div>
					<div class="layui-col-xs6">
						<label class="layui-form-label requied">所属目录：</label>
						<div class="layui-input-block">
							<input type="text" id="catalogName" name="catalogName"
								lay-verify="required" placeholder="点击获取文件目录" autocomplete="off"
								class="layui-input">
							<ul id="tree" class="ztree ztree-position"></ul>
							<input id="catalogId" name='catalogId' type="hidden"
								data-id="catalogId">
						</div>
					</div>
				</div>
				<div class="layui-row" style="margin-top: 35px;">
					<div class="layui-col-xs6">
						<label class="layui-form-label requied">物料代码：</label>
						<div class="layui-input-block">
							<select id="mfCode" name="mfCode" lay-filter="mfCode"
								lay-verify="" lay-search>
								<option value="">请先选择产品型号</option>
								<%-- <c:forEach items="${materielFactories}" var="mf">
									<option value="${mf.materielCode}">${mf.materielCode}</option>
								</c:forEach> --%>
							</select>
						</div>
					</div>
					<div class="layui-col-xs6">
						<label class="layui-form-label requied">文件类型：</label>
						<div class="layui-input-block">
							<select name="fileType" lay-filter="fileType" lay-verify=""
								lay-search>
								<option value="">请选择文件类型</option>
								<c:forEach items="${sysparam}" var="sysparam">
									<option value="${sysparam.paramId}">${sysparam.paramName}</option>
								</c:forEach>
								<!-- <option value="1">bom文件</option>
							  <option value="2">工艺文件</option>
							  <option value="2">普通文件</option> -->
							</select>
						</div>
					</div>
				</div>
				<div class="layui-row" style="margin-top: 35px;">
					<div class="layui-col-xs12">
						<label class="layui-form-label requied">文件选择：</label>
						<div class="layui-input-block">
							<form class="form-x" method="post" enctype="multipart/form-data"
								id="uploadform">
								<div class="layui-upload">
									<button type="button" class="layui-btn layui-btn-normal"
										id="checkoutFile">选择文件</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
			<div class="layui-form-item" style="margin-top: 35px;">
				<div class="layui-input-block"
					style="margin: 0 auto; text-align: center;">
					<button class="layui-btn" id="uploadFile">上传</button>
				</div>
			</div>
		</form>
	</div>
</div>
<div id="handout_wrap_inner" style="display:none;"></div>
<script src="${ctx}/res/js/main.js"></script>
<script src="${ctx}/res/js/jquery.media.js"></script>
<script type="text/javascript">
 var uploadDialogShow;
layui.use(['laypage', 'layer'], function(){
  var laypage = layui.laypage,layer = layui.layer;
      //完整功能
	$.initThirdTitle();
  laypage.render({
    elem: 'pagefenye',
    count: ${pageVo.totalElements},
    theme: '#009587',
    limit : ${pageVo.size},
    limits:[5, 10, 20, 30, 40],
    curr : ${pageVo.number+1},
    layout: ['count', 'prev', 'page', 'next', 'limit', 'refresh', 'skip'],
    jump: function(obj,first){
	if(!first){
	  var productModel = $("#productModel").val();
	 $("#data-list").load("${ctx}/fileManage/pageList?start="+obj.curr+"&pageSize="+obj.limit+"&productModel="+productModel);
	}
	}
  });
});
  
$(function(){
	//条件查询
	$('#selectOrder').click(function(){
		var productModel = $("#productModel").val();
		$("#data-list").load("${ctx}/fileManage/pageList?productModel="+productModel);
	});
	
	//文件上传
	$("#uploadDialog").click(function(){
		$("#productModelNum").val("");
		$("#catalogId").val("")
		uploadDialogShow = layer.open({
			type: 1,
			shade: false,
			title: "<span class='dialog_title base-zb-info'>新增文件</span>",
			area: ['40%', '58%'],
			content: $("#mainPage")
		});
	});
	
	///加载文件目录树
	$("#catalogName").on("click",function(){
		$("#tree").show();
		$.fn.zTree.init($("#tree"), setting);
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
  								url : "${ctx}/fileManage/pageList",
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
	
	
	/**************************ztree************************************/
    var setting = {
        view: {
            dblClickExpand: false,
            showLine: true,
            selectedMulti: false,
            showIcon: false
        },
        data: {
			simpleData: {
				enable: true
			}
		},
        async: { //ztree异步请求数据 
            enable: true,
            url: "${ctx}/fileCatalog/fcTree", //请求action方法 
            type:"get",
            dataFilter: filter, //预处理数据
            //autoparam: ["data"]
        },
        callback: {
            beforeClick: beforeClick
        }
    };
    function filter(treeId, parentNode, childNodes) { 
		if (!childNodes) return null; 
		for (var i=0, l=childNodes.length; i<l; i++) { 
			childNodes[i].name = childNodes[i].name.replace('',''); 
		} 
		return childNodes; 
	} 
    /* 获取返回的数据，进行预操作 */
    function ajaxDataFilter(treeId, parentNode, responseData) {
        responseData = responseData.data;
        return responseData;
    };
    
  //异步加载完成时运行，此方法将所有的节点打开
    function zTreeOnAsyncSuccess(event, treeId, msg) {
        var treeObj = $.fn.zTree.getZTreeObj("tree");
        treeObj.expandAll(true);
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
    	var pMenuId = $(".pMenuId");
    	$("#catalogName").val(treeNode.name);
    	$("#catalogId").val(treeNode.tld);
    	$("#"+treeId).hide();
    	/* var menuId = $("input[name='menuId']").val();
    	if(pMenuId.val() && pMenuId.val()==menuId){
    		pMenuId.val("");
    		$(".pName").val("");
			layer.tips('上级菜单和本级菜单不能一样,请重新选择上级菜单', "input[name='parentMenuPname']");
		} */
        var zTree = $.fn.zTree.getZTreeObj("tree");
        zTree.checkNode(treeNode, !treeNode.checked, null, true);
        return false;
    }
	
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
  								url : "${ctx}/fileManage/pageList",
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
  							url : "${ctx}/fileManage/pageList",
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
	
layui.use(['form','element','jquery','layer','upload'], function(data){
  var $ = layui.jquery,form = layui.form,
  	  layer = parent.layer===undefined ? layui.layer:parent.layer,
  	  element = layui.element,
  	  upload = layui.upload;
	var mfCode;
	var mfName;
	var fileType;
	var fileTypeName;
	form.on('select(mfName)', function (data) {//aihao为下拉框的lay-filter
		//mfCode = data.value;
		mfName = data.elem[data.elem.selectedIndex].text;
		$.ajax({
			url:'${ctx}/fileManage/getMaterielCodeList',
			type:'post',
			data:{'materielName':mfName},
			dataType:'json',
			success:function(res){
				if(res.success=='success'){
					var html = '<option value="">请选择物料代码</option>';
					for(var i=0; i<res.data.length;i++){
						html+='<option value="'+res.data[i].materielCode+'">'+res.data[i].materielCode+'</option>';
					}
					$("#mfCode").html(html);
					form.render();
				}else{
					layer.msg(1, {
			  			content: res.message,
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
		//$("#mfCode").val(mfCode);
		//form.render();
	})
	form.on('select(mfCode)', function (data) {//aihao为下拉框的lay-filter
		//$("#mfCode").val(data.value);
		mfCode = data.value;
	});
	
	form.on('select(fileType)', function (data) {//aihao为下拉框的lay-filter
		fileType = data.value;
		fileTypeName = data.elem[data.elem.selectedIndex].text;
	});
	form.render();
  
   upload.render({
    elem: '#checkoutFile',
    url: '${ctx}/fileManage/uploadFile',
    data:{
    	"productModel":function(){
    	    return mfName;
    	  },
    	"catalogId":function(){
    	    return $("#catalogId").val();
    	  },
    	 "mfCode":function(){
     	    return mfCode;
     	  },
     	  "fileType":function(){
       	    return fileType;
       	  }
    },
    method: "post",
    auto: false,
    bindAction: '#uploadFile',
    accept:'file',
    before:function(obj){
    	var catalogId = $("#catalogId").val();
    	if(catalogId == null || catalogId ==""){
    		layer.msg(1, {
			    content: '文件目录不能为空',
			    time: 1500,
			    success: function(layero) {                     
			        layero.css({'background-color':'#F00'});                     
			        layero.find('.layui-layer-content').css({
			             'color': '#FFFFFF',
			             'font-size': '13px'
			        });
			    }
			});
			return false;
    	}
    	if(fileType == null || fileType ==""){
    		layer.msg(1, {
			    content: '文件类型不能为空',
			    time: 1500,
			    success: function(layero) {                     
			        layero.css({'background-color':'#F00'});                     
			        layero.find('.layui-layer-content').css({
			             'color': '#FFFFFF',
			             'font-size': '13px'
			        });
			    }
			});
			return false;
    	}else if(fileTypeName!="其他"){
    		if(mfName == null || mfName ==""){
    			layer.msg(1, {
				    content: '产品型号不能为空',
				    time: 1500,
				    success: function(layero) {                     
				        layero.css({'background-color':'#F00'});                     
				        layero.find('.layui-layer-content').css({
				             'color': '#FFFFFF',
				             'font-size': '13px'
				        });
				    }
				});
				return false;
    		}
    		if(mfCode == null || mfCode ==""){
    			layer.msg(1, {
				    content: '物料代码不能为空',
				    time: 1500,
				    success: function(layero) {                     
				        layero.css({'background-color':'#F00'});                     
				        layero.find('.layui-layer-content').css({
				             'color': '#FFFFFF',
				             'font-size': '13px'
				        });
				    }
				});
				return false;
    		}
    	}
    },
    //exts:'xls|xlsx',
    done: function(res){
      if(res.success=='success'){
      	showOkTip(res.message);
      	$("#data-list").load("${ctx}/route/manage/basedata/file_list");
      	//var upload = layer.getFrameIndex(window.name);
      	layer.close(uploadDialogShow);
      }else{
      	alertError(res.message);
      } 
    }
  });
});


function exportExcel (){
	var ids=[];
	$("input[name='fileItem']:checked").each(function(){ 
     ids.push($(this).attr("id"));
     });
       var orderId;
     if(ids.length>0){
     	orderId=ids.join(",");
     }
    var productModel = $("#productModel").val();
    $("#exportProductNum").val(productModel);
     $("#exportOrderId").val(orderId);
	$("#exportOrder").submit();
     
};

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
