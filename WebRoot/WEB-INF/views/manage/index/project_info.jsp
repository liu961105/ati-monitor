<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/public/taglib.jspf"%>
<link rel="stylesheet" href="${ctx}/res/ati_monitor/css/gcxx.css">
<!-- 列表界面 -->
<div id="data-list">
	<div class="banner">
		<span class="base-blue-01 base-search" data-title='工程信息'>工程信息</span>
	</div>
	<div class="out">
		<div class="in">
			<div class="second-list">
				<div class="nav-left" id="projectInfoData">
					<!-- <div class="last_list">
						<p class="name">委托单位：</p>
						<p class="value">贵阳宏益房地产开发有限公司</p>
					</div>
					<div class="last_list">
						<p class="name">监理单位：</p>
						<p class="value"></p>
					</div> -->
				</div>
				<div class="nav-right">
					<ul class="nav-img">
						
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
    getPhotoList();
	$.initThirdTitle();
	var projectId = $("#flagProjectId").val();
	$(function() {
		var reqAjax = {
			url : '${ctx}/projectInfoo/getDataPage',
			para : {
				'projectId' : projectId
			},
			callback : function(res) {
				if (res.success == '1') {
					var html = '<div class="last_list">' +
						'<p class="name">项目名称：</p>' +
						'<p class="value">' + res.data.projectName + '</p>' +
						'</div>' +
						'<div class="last_list">' +
						'<p class="name">项目地点：</p>' +
						'<p class="value">' + res.data.address + '</p>' +
						'</div>';
					if (res.data.atiProjectInfo.length > 0) {
						for (var i = 0; i < res.data.atiProjectInfo.length; i++) {
							var obj = res.data.atiProjectInfo[i];
							html += '<div class="last_list">' +
								'<p class="name">' + obj.objKey + '：</p>' +
								'<p class="value">' + obj.objValue + '</p>' +
								'</div>';
						}
					}
					$("#projectInfoData").html(html);
				//layer.msg("工程信息获取成功",{icon:6});
				} else {
					layer.msg("工程信息获取失败", {
						icon : 5
					});
				}
			}
		}
		$._MultAjax(reqAjax);
	})
	var Items = "";
	function getPhotoList() {
			var projectId = $("#flagProjectId").val();
			var index = layer.load();
			$.ajax({
				type : 'POST',
				url :  '${ctx}/photo/getPhotoList',
				data : {'projectId' : projectId},
				dataType : 'json',
				success : function(res) {
					if (res.success == '1') {
					layer.close(index);
						Items = res.data;
						loadData();
					}
				}
			});
		}
		
		function loadData() {
		    $('.nav-img').html("");
			var projectId = $("#flagProjectId").val();
			$.each(Items, function(i, item) {
				str = '<li><img src="'+item.cover+'"><h2>'+item.name+'</h2></li>'
				$('.nav-img').append(str);
			});
		}
	
	
	
</script>