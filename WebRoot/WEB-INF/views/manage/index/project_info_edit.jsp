<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/public/taglib.jspf"%>
<link rel="stylesheet" href="${ctx}/res/ati_monitor/css/gcxxwh.css">
<div id="data-list">
	<div class="banner">
		<span class="base-blue-01 base-search hidden" data-title='工程信息维护'>工程信息维护</span>
	</div>
	<div class="outwh">
		<div class="inwh">
				<!-- <input type="hidden" name="projectId" value="0"> <input
					type="hidden" name="projectIntroduction" value="花果园及五里冲棚户区、危旧房改造项目">
				<input type="hidden" name="photo"
					value="https://timgsa.baidu.com/timg?image&amp;quality=80&amp;size=b9999_10000&amp;sec=1520536625717&amp;di=fe43e6fd42c102d0cd5af1e31ebc62c9&amp;imgtype=0&amp;src=http%3A%2F%2Fimg.pconline.com.cn%2Fimages%2Fupload%2Fupc%2Ftx%2Fphotoblog%2F1505%2F21%2Fc17%2F7129539_7129539_1432216063578_mthumb.jpg">
				<input type="hidden" name="longitude" value="106.687915"> <input
					type="hidden" name="latitude" value="26.499209"> <input
					type="hidden" name="monitorOrgId" value=""> <input
					type="hidden" name="monitorTypeCode" value="bpgc"> <input
					type="hidden" name="projectUrl" value="project/bpjk"> <input
					type="hidden" name="workStatus" value="0"> <input
					type="hidden" name="positionImgUrl" value=""> <input
					type="hidden" name="status" value="1"> -->
			<div class="layui-form-item">
				<div class="layui-inline">
					<button id="add_project_item" type="button" class="layui-btn" data-toggle="modal">
						添加选项
					</button>
					<button id="save_project_item" type="button" class="layui-btn layui-btn-normal" data-toggle="modal">
						保存
					</button>
				</div>
			</div>
			<form id="gcxxForm">
				<!-- <div class="last_listwh">
					<p class="namewh"><input type="text" name="projectName" value="工程名称"></p>
					<span>:</span>
					<p class="valuewh">
						<input type="text" name="projectName" value="花果园及五里冲棚户区、危旧房改造项目">
					</p>
				</div>
				<div class="last_listwh">
					<p class="namewh"><input type="text" name="projectName" value="监理单位"></p>
					<span>:</span>
					<p class="valuewh">
						<input type="text" name="projectScale" value="江阳建设集团有限公司">
					</p>
				</div> -->
			</form>
		</div>
	</div>
</div>
<script type="text/javascript">
	$.initThirdTitle();
	var projectId = $("#flagProjectId").val();
	$(function(){
		var reqAjax = {
				url:'${ctx}/projectInfoo/getDataPage',
				para:{'projectId':projectId},
				callback : function(res) {
					if(res.success=='1'){
						var html = '<div class="last_listwh">'+
										'<p class="namewh"><input type="text" name="projectName" value="项目名称"></p>'+
										'<span>:</span>'+
										'<p class="valuewh"><input type="text" name="projectScale" value="'+res.data.projectName+'"></p>'+
									'</div>'+
									'<div class="last_listwh">'+
										'<p class="namewh"><input type="text" name="projectAddr" value="项目地点"></p>'+
										'<span>:</span>'+
										'<p class="valuewh"><input type="text" name="projectScale" value="'+res.data.address+'"></p>'+
									'</div>';
						if (res.data.atiProjectInfo.length>0) {
							for (var i=0;i<res.data.atiProjectInfo.length;i++) {
								var obj = res.data.atiProjectInfo[i];
								html += '<div class="last_listwh">'+
											'<p class="namewh"><input type="text" name="objKey" value="'+obj.objKey+'"></p>'+
											'<span>:</span>'+
											'<p class="valuewh"><input type="text" name="objValue" value="'+obj.objValue+'"></p>'+
											'<i class="layui-icon layui-icon-close-fill del-item"></i>'+
										'</div>';
							}
						}
						$("#gcxxForm").html(html);
					} else {
						layer.msg("工程信息获取失败",{icon:5});
					}
				}
		}
		$._MultAjax(reqAjax);
		
		//添加工程信息选项
		$('#add_project_item').on('click',function(){
			var html = '<div class="last_listwh">'+
							'<p class="namewh"><input type="text" name="objKey" value=""></p>'+
							'<span>:</span>'+
							'<p class="valuewh"><input type="text" name="objValue" value=""></p>'+
							'<i class="layui-icon layui-icon-close-fill del-item"></i>'+
						'</div>';
			$('#gcxxForm').append(html);
		});
		
		//保存功能
		$('#save_project_item').on('click',function(){
			var objKeys = '';
			var objValues = '';
			$('#gcxxForm').find('input[name="objKey"]').each(function(){
				objKeys += $(this).val()+',';
			});
			$('#gcxxForm').find('input[name="objValue"]').each(function(){
				objValues += $(this).val()+',';
			});
			objKeys = objKeys.substr(0,objKeys.length-1);
			objValues = objValues.substr(0,objValues.length-1);
			var transAjax = {
					url:'${ctx}/projectInfoo/saveDataPage',
					para:{
						'projectId' : projectId,
						'objKeys' : objKeys,
						'objValues' : objValues
					},
					callback : function(res) {
						if(res.success=='1'){
							layer.msg('保存成功',{icon:6});
						} else {
							layer.msg(res.message,{icon:5});
						}
					}
			};
			$._MultAjax(transAjax);
		})
		
		//删除功能
		$(document).off("click",".del-item").on("click",".del-item",function(){
			$(this).parent().remove();
		});
	})
</script>