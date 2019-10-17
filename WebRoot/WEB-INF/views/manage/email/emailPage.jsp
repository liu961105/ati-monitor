<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/public/taglib.jspf"%>
<style>
<!--
-->
.add-button{
    height: 33px;
    border: none;
    border-radius: 10px;
    background-color: #eaf3fd;
    font-size: 14px;
    color: #0072ff;
    margin-bottom: 3px;
    width:10%;
    cursor: pointer;
 }
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
.user-bm {
	margin-left:50px;
}
.user-yx {
	margin-left:50px;
}
</style>
<!-- 列表界面 -->
<div id="data-list">
	<div class="banner">
		<span class="base-blue-01 base-search" data-title='邮件管理'>邮件管理</span>
	</div>
<!-- 	邮件管理 -->
	<div class="layui-tab layui-tab-brief">
	  <ul class="layui-tab-title">
	    <li class="layui-this">邮件配置</li>
<!-- 	    <li >生产期过期</li>
	    <li>通知类型3</li>
	    <li>通知类型4</li>
	    <li>通知类型5</li> -->
	    <li>测试邮件</li>
	  </ul>
	  <div class="layui-tab-content">
	    <div class="layui-tab-item layui-show">
	      <form class="layui-form" action="" lay-filter="emailForm">
            <div class="layui-collapse" lay-filter="test11" id="remindItem">
              
                     <input type="hidden" name="id" id="sbyc_id" value="${sysEmail.id}">
<%--                       <input type="hidden" name="code" value="${sysEmail.code}" > --%>
                       <input type="hidden" id="equContent" value="${sysEmail.content}">
              
					 <div class="layui-colla-item">
					    <h2 class="layui-colla-title">邮件内容配置</h2>
					    <div class="layui-colla-content layui-show">
					    	<div style="width: 200px;">
					    	 	<input type="hidden" id="sbycCode" value="${type}" >
	 							<p>邮件类型：</p>
						      	<select  name="code" lay-filter="code_filter"  id="sbyc_code">
								  <option value="sbyc">设备异常</option>
								  <option value="scqgq">生产期过期</option>
								</select> 
					    	</div>
					      <p>邮件主题：</p> <input type="text" name="subject" value="${sysEmail.subject}" id="que_subject" placeholder="请输入主题" class="layui-input">
					      <p>邮件内容：</p> <textarea  name="content" id="equ_content" placeholder="请输入内容" class="layui-textarea"></textarea>
					      <p>邮件附件：</p> 
					                    <input type="hidden" value="${sysEmail.fileList}" name="fileList" id="sbyc_fileNames">
								      <div class="layui-upload">
										  <button type="button" class="layui-btn layui-btn-normal layui-btn-sm" id="sbycEmaiselectlBtn">选择多文件</button> 
										  <div class="layui-upload-list">
										    <table class="layui-table">
										      <thead>
										        <tr><th>文件名</th>
										        <th>大小</th>
										        <th>状态</th>
										        <th>操作</th>
										      </tr></thead>
										      <tbody id="sbycbody">
										      <c:if test="${not empty sysEmail.fileList}">
										      <c:set value="${fn:split(sysEmail.fileList, ',') }" var="fileLists" />
											      	<c:forEach items="${fileLists}" var="item" >
											      		<tr>
											      			<td>${item}</td>
											      			<td></td>
											      			<td>已上传</td>
											      			<td><button type="button" class="layui-btn layui-btn-xs layui-btn-danger" onclick="delFileTr(this)">删除</button></td>
											      		</tr>
											      	</c:forEach>
										      	</c:if>
										      </tbody>
										    </table>
										  </div>
										  <button type="button" class="layui-btn layui-btn-sm" id="sbycEmailsubmitBtn">开始上传</button>
										</div> 
					    </div>
					  </div> 
					  <div class="layui-colla-item">
					    <h2 class="layui-colla-title">收件人配置</h2>
					    <div class="layui-colla-content layui-show">
					    	<input type="hidden" name="toList" id="userIds">
					     <button type="button" id="addbadButton" class="add-button"><i style="font-size:14px;" class="layui-icon">&#xe61f;</i> <span>添加收件人</span></button>
					      <table class="layui-table">
							  <!-- <colgroup>
							    <col width="150">
							    <col width="200">
							    <col>
							  </colgroup> -->
							  <thead>
							    <tr>
							      <th>姓名</th>
							      <th>邮箱</th>
							      <th>部门</th>
							      <th>岗位</th>
							      <th>操作</th>
							    </tr> 
							  </thead>
							  <tbody id="userTbody">
							  	<c:forEach items="${sysEmail.sysUsers}" var ="item">
							  	<tr data-userid='${item.userId}'>
							  	  <td>${item.rolename}</td>
							      <td>${item.email}</td>
							      <td>${item.deptName}</td>
							      <td>${item.postName}</td>
							      <td><button type="button" class="layui-btn layui-btn-xs layui-btn-danger" onclick="deleteUserEmail(this)">删除</button></td>
							    </tr>
							  	</c:forEach>
							   <!--  <tr>
							      <td>张安安</td>
							      <td>1334663563@qq.com</td>
							      <td>总经办</td>
							      <td>总经理</td>
							      <td><button class="layui-btn layui-btn-xs layui-btn-danger">删除</button></td>
							    </tr> -->
							  
							  </tbody>
							</table>
					      <button type="button" class="layui-btn layui-btn-sm" lay-submit lay-filter="sbycEmailForm"  style="margin-left: 4px; margin-top: 2px;" id="test9">保存配置</button>
					    </div>
					  </div>
		   </div>	
		    </form> 
	    </div>
<!--	    <div class="layui-tab-item"></div>
 	    <div class="layui-tab-item">内容3</div>
	    <div class="layui-tab-item">内容4</div>
	    <div class="layui-tab-item">内容5</div> -->
	    <div class="layui-tab-item">
	     <div class="layui-collapse" lay-filter="test" id="testEmailTab">
	     <form class="layui-form" action="">
	         <div class="layui-colla-item">
			    <h2 class="layui-colla-title">测试邮件功能</h2>
			    <div class="layui-colla-content layui-show">
			      <p>邮件主题：</p> <input type="text" name="subject" required lay-verify="required"   placeholder="请输入主题" class="layui-input">
			      <p>邮件内容：</p> <textarea name="content" required lay-verify="required"  placeholder="请输入内容" class="layui-textarea"></textarea>
			      <p>邮件附件：</p> <input type="hidden" name="fileList" id="testEmailfileNames"><!-- <button type="button" class="layui-btn layui-btn-normal layui-btn-sm"   id="fileList">选择文件</button> -->
						      <div class="layui-upload">
								  <button type="button" class="layui-btn layui-btn-normal layui-btn-sm" id="testEmailselectBtn">选择多文件</button> 
								  <div class="layui-upload-list">
								    <table class="layui-table">
								      <thead>
								        <tr><th>文件名</th>
								        <th>大小</th>
								        <th>状态</th>
								        <th>操作</th>
								      </tr></thead>
								      <tbody id="testEmailBody"></tbody>
								    </table>
								  </div>
								  <button type="button" class="layui-btn layui-btn-sm" id="testEmailsubmitBtn">开始上传</button>
								</div> 
			      <p>收件人：</p> <input type="text" name="toList" required  lay-verify="required" placeholder="请输入收件人邮箱，测试多收件人请已英文逗号隔开，如：abcd@qq.com,2124ssff@163.com" class="layui-input">
			      <button type="button" class="layui-btn" lay-submit lay-filter="testEmailForm"  style="margin-left: 4px; margin-top: 20px;" id="test11119">立即发送邮件</button>
			    </div>
			  </div> 
			  </form>
		  </div>
	    </div>
	  </div>
	</div>
</div> 
<!-- 人员选择弹窗开始 -->
	<div id="userOpen" style="display: none;">
		<div class="layui-row" style="margin-bottom: 12px; margin-top: 5px;">
			<ul class="topSelect">
				<li><input class="layui-input"  id="userName" placeholder="输入员工姓名、工号查询"></li>
				<li><button type="button" class="layui-btn layui-btn-normal"
						id="selectUser">搜索</button></li>
			</ul>
			
			<!-- <div class="layui-form" style="width:160px; margin-left: 15px;">
				<input type="radio" name="workBatch" value="白班" title="白班" checked>
				<input type="radio" name="workBatch" value="夜班" title="夜班">
			</div> -->
		</div>
		<div class="device-li" style="padding-left:14px;">
			<ul id="user-ul">
				
			</ul>
		</div>
		
		<div id="pagefenye" class="fenye" style="text-align: center;"></div>
	</div>
		<!-- 人员选择弹窗结束 -->



<script type="text/javascript">
 $(function() {
     //初始化菜单标题
	 $.initThirdTitle();
	 
	 
	 
	getTabElem();
	
	getUserList('1','9','');
	//加载折叠面板	
	
	$("#addbadButton").click(function(){
		layer.open({
			type: 1,
	        shade: false,
	        resize:true,
	        title: "<span class='dialog_title base-zb-info'>收件人</span>",
	        area: ['660px', '600px'],
	        content: $('#userOpen'),
	        cancel: function(index, layero){ 
			    $('#userOpen').hide();
			}   
		});
	});
	
	 $('#user-ul').on('dblclick', '.it',function(){
	  	var workBatch = $("input[name='workBatch']:checked").val();
	  	if(!$(this).hasClass('disuser')){
	  		var username = $(this).find(".user-name").text();
	  	   var gw = $(this).find(".user-gw").text();
	  	   var bm = $(this).find(".user-bm").text();
	  	   var email = $(this).find(".user-yx").text();
	  	   var userid = $(this).find(".user-id").val();
	  	   
	  	   var html="<tr data-userid="+userid+">"+
				      "<td>"+username+"</td>"+
				      "<td>"+email+"</td>"+
				      "<td>"+bm+"</td>"+
				      "<td>"+gw+"</td>"+
				     '<td><button type="button" class="layui-btn layui-btn-xs layui-btn-danger" onclick="deleteUserEmail(this)">删除</button></td>'+
				    "</tr>";
			$("#userTbody").append(html);	    
			$(this).removeClass('user').addClass('disuser');
	  	}
	
	  });
	  
	  $('#selectUser').on('click',function(){
		var userName = $('#userName').val();
		getUserList('1','9',userName);
	  });
						 
	//form表单
	layui.use('form', function(){
	  var form = layui.form;
	  //监听testEmailForm提交
	  form.on('submit(testEmailForm)', function(data){
	    //layer.msg(JSON.stringify(data.field));
	    testEmail(data.field);
	    return false;
	  });
	  //监听设备异常提交
	  form.on('submit(sbycEmailForm)', function(data){
	    //layer.msg(JSON.stringify(data.field));
	    var userIds = '';
	    $('#userTbody tr').each(function(){
	    	var userid = $(this).data('userid');
	    	userIds+=userid+',';
	    });
	    userIds = userIds.substr(0,userIds.length-1);
//	    $('#userIds').val(userIds);
	     data.field.toList = userIds;
	    debugger;
	    sbycEmail(data.field);
	    return false;
	  });
	  //监听生产期过期提交
	  form.on('submit(scqgqEmailForm)', function(data){
	    //layer.msg(JSON.stringify(data.field));
	    scqgqEmail(data.field);
	    return false;
	  });
	  
    });
	
    //设备异常	
	getUploadPlug($('#sbycbody'),'#sbycEmaiselectlBtn','#sbycEmailsubmitBtn','#sbycbody tr',$('#sbyc_fileNames'));
	//生产期过期
	getUploadPlug($('#scqgqbody'),'#scqgqEmaiselectlBtn','#scqgqEmailsubmitBtn','#scqgqbody tr',$('#scqgq_fileNames'));
	//测试邮件
	getUploadPlug($('#testEmailBody'),'#testEmailselectBtn','#testEmailsubmitBtn','#testEmailBody tr',$('#testEmailfileNames'));
	
	
	
	renderForm();
	
	//类型监听
selectChange();

//select赋值
selectTovalue();
});	
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
					
					if(userList[i].userImg){
						$li+='<div class="img"><img src="/itws/res/img/userImg/'+userList[i].userImg+'"></div>';
					}else{
						$li+='<div class="img"><i class="layui-icon" style="font-size: 30px; color: #656a6d">&#xe612;</i>  </div>';
						
					}

					$li+='<div class="user-name">'+userList[i].rolename+'</div>';
					$li+='<div class="user-gh">'+(userList[i].usercode=="null"||userList[i].usercode==null?"":userList[i].usercode)+'</div>';
					$li+='<div class="user-gw">'+(userList[i].postName=="null"||userList[i].postName==null?"":userList[i].postName)+'</div>';
					$li+='<div class="user-bm">'+(userList[i].deptName=="null"||userList[i].deptName==null?"":userList[i].deptName)+'</div>';
					$li+='<div class="user-yx">'+(userList[i].email=="null"||userList[i].email==null?"":userList[i].email)+'</div>';
					$li+='<input type="hidden" class="user-id" value=\"'+(userList[i].userId=="null"||userList[i].userId==null?"":userList[i].userId)+'\">';
					$li+='</li>';
					$('#user-ul').append($li);
 				}
 				
 				getUserPage(res.data.totalElements,res.data.size,res.data.number+1,userName);
 				
 				$('#selectedUser li').each(function(item, index){
 				 	var selected = $(this);
 					var $id1 = selected.data('userid');
	 				$('#user-ul li').each(function(obj,k){

	 					var $id2 = $(this).data('userid');
	 					if($id1==$id2){
	 						$(this).removeClass('user').addClass('disuser');
	 					}
	 				});
 				});
 				
 				xrUserInfo();
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
	
	//测试邮件
	function testEmail(data) {
	  //console.log(data);
	     var my = {
				url : "${ctx}/email/testEmail",
				para:data,
				callback : function(res) {
				   if(res.success == 1){ 
	                       layer.msg("发送成功，请查看邮箱！")
				   }else{
				           layer.msg("发送失败，请检查输入是否正确！")
				   }
				}
		}
		$._NormalRequest(my);
		debugger;
	}
	
	
	//配置设备异常邮件
	function sbycEmail(data) {
	  //console.log(data);
	     var my = {
				url : "${ctx}/email/sbycEmail",
				para:data,
				callback : function(res) {
				   if(res.success == 1){ 
	                       layer.msg("操作成功！")
				   }else{
				           layer.msg("操作失败，请检查输入是否正确！")
				   }
				}
		}
		$._NormalRequest(my);
		//debugger;
	}
	
	
	//配置生产期过期邮件
	function scqgqEmail(data) {
	  //console.log(data);
	     var my = {
				url : "${ctx}/email/scqgqEmail",
				para:data,
				callback : function(res) {
				   if(res.success == 1){ 
	                       layer.msg("操作成功！")
				   }else{
				           layer.msg("操作失败，请检查输入是否正确！")
				   }
				}
		}
		$._NormalRequest(my);
		//debugger;
	}
	
	
	//调用layui上传插件
	function getUploadPlug(bodyelem,selectbtn,submitbtn,trelem,dataelem) {
       //上传附件
	   layui.use('upload', function(){
		  var $ = layui.jquery,upload = layui.upload;
		 //多文件列表示例
			  var demoListView = bodyelem
			  ,uploadListIns = upload.render({
			    elem: selectbtn
			    ,url: '${ctx}/email/importFileList'
			    ,accept: 'file'
			    ,multiple: true
			    ,auto: false
			    ,bindAction: submitbtn
			    ,choose: function(obj){   
			      var files = this.files = obj.pushFile(); //将每次选择的文件追加到文件队列
			      //读取本地文件
			      obj.preview(function(index, file, result){
			        var tr = $(['<tr id="upload-'+ index +'">'
			          ,'<td>'+ file.name +'</td>'
			          ,'<td>'+ (file.size/1014).toFixed(1) +'kb</td>'
			          ,'<td>等待上传</td>'
			          ,'<td>'
			            ,'<button class="layui-btn layui-btn-xs demo-reload layui-hide">重传</button>'
			            ,'<button class="layui-btn layui-btn-xs layui-btn-danger demo-delete">删除</button>'
			          ,'</td>'
			        ,'</tr>'].join(''));
			        
			        //单个重传
			        tr.find('.demo-reload').on('click', function(){
			          obj.upload(index, file);
			        });
			        //删除
			        tr.find('.demo-delete').on('click', function(){
			          delete files[index]; //删除对应的文件
			          tr.remove();
			          uploadListIns.config.elem.next()[0].value = ''; //清空 input file 值，以免删除后出现同名文件不可选
			        });
			        demoListView.append(tr);
			      });
			    }
			    ,done: function(res, index, upload){
			      if(res.success == 1){ //上传成功
			        	var names = ''
					    $(trelem).each(function(index,item){
					    	var fileName = $(this).children().eq(0).text();
					    	names+=fileName+',';
					    });
						names = names.substr(0,names.length-1);
						dataelem.val(names);
						debugger;
			        var tr = demoListView.find('tr#upload-'+ index)
			        ,tds = tr.children();
			        tds.eq(2).html('<span style="color: #5FB878;">上传成功</span>');
			        tds.eq(3).html(''); //清空操作
			        return delete this.files[index]; //删除文件队列已经上传成功的文件
			      }
			      this.error(index, upload);
			    }
			    ,error: function(index, upload){
			      var tr = demoListView.find('tr#upload-'+ index)
			      ,tds = tr.children();
			      tds.eq(2).html('<span style="color: #FF5722;">上传失败</span>');
			      tds.eq(3).find('.demo-reload').removeClass('layui-hide'); //显示重传
			    }
			  }); 
		});
	}
	
	
	
	//获取上传文件名
	function getTabElem() {
		layui.use(['element', 'layer'], function(){
							  var element = layui.element;
							  var layer = layui.layer;
							   //element.init();
							  /* element.on('tab(test11)', function(data) {
							        cosnole.log(data);
							    }); */
							  
						 });
	}
	
	function deleteUserEmail(obj){
		var userid = $(obj).parent().parent().data("userid");
		$(obj).parent().parent().remove();
		$('#user-ul li').each(function(){
			var puerid = $(this).data('userid');
			if(userid==puerid){
				$(this).removeClass('disuser').addClass('user');
			}
		});
	
	}
	
	function xrUserInfo(){
		$('#userTbody tr').each(function(idnex,obj){
			var userid = $(obj).data('userid');
			$('#user-ul li').each(function(k,el){
				var puerid = $(el).data('userid');
				if(userid==puerid){
					$(el).removeClass('user').addClass('disuser');
				}
			});
			
		});
		
		$('#equ_content').text($('#equContent').val());	
		
	}
function delFileTr(obj){
	$(obj).parent().parent().remove();
    var names = ''
    $('#sbycbody tr').each(function(index,item){
    	var fileName = $(this).children().eq(0).text();
    	names+=fileName+',';
    });
	names = names.substr(0,names.length-1);
	$('#sbyc_fileNames').val(names);
}	

function renderForm(){
  	layui.use('form', function(){
   	var form = layui.form;
   	form.render();
  	});
} 
	
	
function selectChange(){
  	layui.use('form', function(){
   		var form = layui.form;
  	    form.on('select(code_filter)', function(data){
			$('#data-list').load('${ctx}/email/emailPage?type='+data.value);
		}); 
  	});

}	


function selectTovalue(){
 	var ss = $('#sbycCode').val();
	layui.use('form', function(){
	var form = layui.form;
		form.val("emailForm", {
		  "code": ss
		 });
	}) 
}
</script>