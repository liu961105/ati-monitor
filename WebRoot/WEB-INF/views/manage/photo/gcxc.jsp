<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/public/taglib.jspf"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<script type="text/javascript">
	var ctx = "${ctx}";
</script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="renderer" content="webkit">
<meta name="viewport" content="width=device-width">
<title></title>
<link rel="stylesheet" href="${ctx}/res/ati_monitor/css/base.css">
<link rel="stylesheet" href="${ctx}/res/css/manage/iconfont.css">
<link rel="stylesheet" href="${ctx}/res/ati_monitor/css/jquery.page.css">
<link rel="stylesheet" href="${ctx}/res/ati_monitor/css/baseless.css">
<link rel="stylesheet" href="${ctx}/res/css/manage/xczp.css">
</head>

<body class="index">

	<div class="main">
		<div class="wrap"
			style="width: 100%;height: 100%; background: #171939;">
			<div class="head">
				<img src="${ctx}/res/img/icon_gcxx.png" alt=""> <span>工程相册</span>
			</div>
			<div class="list" style="margin-top: 7vh;">
				<ul class="imges_list gcxc">
				</ul>
			</div>
		</div>
	</div>
	<script src="${ctx}/res/js/main.js"></script>
	<script type="text/javascript">
		var Items = "";
		layui.use('layer', function() {
			var layer = layui.layer;
		});
	
	
		var option = '';
		$(function() {
			getPhotoList();
			$(".fd_img").die().live('click', function() {
				var url = $(this).attr('src');
				layer.photos({
				    photos: {
					  "title": "查看详情", //相册标题
					  "id": 123, //相册id
					  "start": 0, //初始显示的图片序号，默认0
					  "data": [   //相册包含的图片，数组格式
					    {
					      "alt": "图片名",
					      "pid": 666, //图片id
					      "src": url, //原图地址
					      "thumb": "" //缩略图地址
					    }
					  ]
					}
				})
			})
	
			$('.gcxc li img').die().live('click', function() {
	
				var projectId = $("#flagProjectId").val();
				var type = $(this).attr('id');
				var htmlString = '';
				//ajax
				var index = layer.load();
				$.ajax({
					type : 'POST',
					url : ctx + '/photo/getImageByType',
					data : {
						'projectId' : projectId,
						'type' : type
					},
					dataType : 'json',
					success : function(res) {
						if (res.success == '1') {
							layer.close(index);
							$.each(res.data, function(i, item) {
								htmlString += '<li><img class="fd_img" src="' + item.url + '" alt=""  style="margin:0.5vw;float:left; display: display:inline;width: 240px;height: 200px;border: 7px solid #fff;outline: #c2c2c2 solid thin;"/></li>'
							});
							layer.open({
								title : '查看详情',
								area : [ '850px', '650px' ],
								content : '<ul style="margin: auto;width: 800px; overflow: hidden;">' +
									htmlString + '</ul>',
							});
						}
					}
				});
			});
	
			$("#upload").click(function() {
				option = '';
				$.each(Items, function(i, item) {
					option += '<option value="' + item.code + '">' + item.name + '</option>'
				});
				layer.open({
					title : '选择上传类型',
					area : [ '500px', '260px' ],
					btn : false,
					content : '<div class="layui-form-item">' +
						'<label class="layui-form-label" style="white-space:nowrap">照片类型</label>' +
						'<div class="layui-input-block">' +
						'<select class="range" name="range" id="range" lay-filter="range">' +
						option +
						'</select>' +
						'</div>' +
						'<input id="file" type="file" name="file[]" multiple="multiple" accept="image/gif,image/jpeg,image/jpg,image/png,image/svg" style="margin-left: 0.7vw;margin-top: 1vh;">' +
						'<button id="changefile" type="button" class="layui-btn layui-btn-normal" style="margin-left: 15vw;margin-top: 5vh;">开始上传</button>' +
						'</div>'
				})
				$("#changefile").click(function() {
					var formData = new FormData();
					for (var i = 0; i < $('#file')[0].files.length; i++) {
						formData.append('file[]', $('#file')[0].files[i]);
					}
					var type = $('.range').val();
					var prijectId = $("#flagProjectId").val();
					var index = layer.load();
					$.ajax({
						type : "POST",
						url : ctx + "/photo/upload?type=" + type + "&projectId=" + prijectId,
						data : formData,
						contentType : false, // 不设置内容类型
						processData : false, // 不处理数据
						dataType : "json",
						success : function(data) {
							if (data.success == '1') {
								layer.close(index);
								layer.closeAll();
								alert('上传成功');
								getPhotoList();
							}
						},
						error : function(data) {
							layer.close(index);
							layer.closeAll();
							alert('上传失败');
							// 请求失败后要执行的代码
	
						}
					});
				});
			});
	
		});
	
		function getPhotoList() {
			var projectId = $("#flagProjectId").val();
			var index = layer.load();
			$.ajax({
				type : 'POST',
				url : ctx + '/photo/getPhotoList',
				data : {
					'projectId' : projectId
				},
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
			$('.gcxc').html("");
			var projectId = $("#flagProjectId").val();
			$.each(Items, function(i, item) {
				str = '<li>' +
					'<img src="' + item.cover + '" alt="" id="' + item.code + '"><span>' + item.name + '</span>' +
					'<input type="hidden" name=' + projectId + ' value=0><input type="hidden" name="modelCode" value="' + item.code + '"></li>'
				$('.gcxc').append(str);
			});
		}
	</script>
</body>

</html>