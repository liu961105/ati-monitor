<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/public/taglib.jspf"%>
<link rel="stylesheet" href="${ctx}/res/ati_monitor/css/kzmb.css">
<div id="data-list">
	<div class="banner">
		<span class="base-blue-01 base-search hidden" data-title='监测内容'>监测内容</span>
	</div>
	<div class="contBox">
		<div class="topCont  flexDirectionRow">
			<!-- origin -->
			<div class="contLeft rightBack J_rightBack" id="smallImg">
				<div class="tit">监测点分布示意图</div>
				<button type="button" class="layui-btn" id="btn-upload"
					style="z-index: 2;position: absolute;right: 2vw;top: 4vh";>上传文件</button>
				<div class="bg-immmg">
					<%-- <img id="smallImgT" src="${ctx}/res/img/monitorcontent/bridge.jpg"
						alt="" class="rightBack-img back-img-flag"> --%>
					<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
						<ul class="layui-tab-title" id="tab-title">
							<li class="layui-this">图片</li>
							<li>视频</li>
						</ul>
						<div class="layui-tab-content" style="height: 100px;">
							<div class="layui-tab-item layui-show" style="margin-left: 2vw;" id="imageShow">
								<%-- <img id="smallImgT" src="${ctx}/res/img/monitorcontent/bridge.jpg" alt="" class="rightBack-img back-img-flag"> --%>
								<%-- <img src="${ctx}/res/img/gcxcgl/zwzp.png" alt="">
								<img src="${ctx}/res/img/gcxcgl/zwzp.png" alt="">
								<img src="${ctx}/res/img/gcxcgl/zwzp.png" alt="">
								<img src="${ctx}/res/img/gcxcgl/zwzp.png" alt="">
								<img src="${ctx}/res/img/gcxcgl/zwzp.png" alt="">
								<img src="${ctx}/res/img/gcxcgl/zwzp.png" alt=""> --%>
							</div>
							<div class="layui-tab-item"id="videoShow">
							   <!--  <video src="" controls="controls" style="width: 100%;height: 100%;"></video> -->
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="contRight">
				<div class="tit">异常未处理监测点信息</div>
				<div class="center tbl-header table">
					<table cellspacing="0" cellpadding="0">
						<thead>
							<tr style="background: #0f4d84;color: #fff;">
								<th>监测项</th>
								<th>监测参数</th>
								<th>点位</th>
								<th>监测值</th>
								<th>等级</th>
								<th>上传时间</th>
							</tr>
						</thead>
					</table>
				</div>
				<div class="scroll-nav">
					<div class="center tbl-body table">
						<table cellspacing="0" cellpadding="0">
							<thead>
								<tr>
									<th>监测项</th>
									<th>监测参数</th>
									<th>点位</th>
									<th>监测值</th>
									<th>等级</th>
									<th>上传时间</th>
								</tr>
							</thead>
							<tbody id="scroll-space" class="J_table">
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>

		<div class="opt-btn">
			<!-- <a id="uploadData">上传</a> -->
			<!-- <a id="freshPage"style="background: #43a6fd;">刷新</a> -->
		</div>
		<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief"
			style="margin: 0 0 20px;">
			<ul id="monitorTypeTab" class="layui-tab-title">
				<!-- <li class="layui-this" data-pkid>周边环境监测</li>
				<li data-pkid>变形监测</li>
				<li data-pkid>结构内力监测</li> -->
			</ul>
		</div>
		<div class="bottomList">
			<ul id="monitorItemTab">
				<li>
					<div class="tit flexDirectionRow">
						1、车辆荷载
						<div class="more">更多</div>
					</div>
					<div class="moreData">
						<div class="colla-item">
							<h2 class="colla-title">
								断面交通流<i class="layui-icon layui-colla-icon layui-icon-right"></i>
							</h2>
							<div class="colla-content">
								<ul>
									<li class="flexDirectionRow">
										<h3>雨量计1：</h3>
										<div class="count flexDirectionRow">
											累计雨量：<span class="num">20.68mm</span>
										</div>
										<div class="count flexDirectionRow">
											Y轴：<span class="num">20.8mm</span>
										</div>
									</li>
									<li class="flexDirectionRow">
										<h3>雨量计2：</h3>
										<div class="count flexDirectionRow">
											累计雨量：<span class="num">20.99mm</span>
										</div>
									</li>
									<li class="flexDirectionRow">
										<h3>雨量计3：</h3>
										<div class="count flexDirectionRow">
											累计雨量：<span class="num">19.28mm</span>
										</div>
									</li>
								</ul>
							</div>
						</div>
						<div class="colla-item">
							<h2 class="colla-title">
								车型<i class="layui-icon layui-colla-icon"></i>
							</h2>
							<div class="colla-content show-this">
								<ul>
									<li class="flexDirectionRow">
										<h3>雨量计1：</h3>
										<div class="count flexDirectionRow">
											累计雨量：<span class="num">20.68mm</span>
										</div>
										<div class="count flexDirectionRow">
											Y轴：<span class="num">20.8mm</span>
										</div>
									</li>
									<li class="flexDirectionRow">
										<h3>雨量计2：</h3>
										<div class="count flexDirectionRow">
											累计雨量：<span class="num">20.99mm</span>
										</div>
									</li>
									<li class="flexDirectionRow">
										<h3>雨量计3：</h3>
										<div class="count flexDirectionRow">
											累计雨量：<span class="num">19.28mm</span>
										</div>
									</li>
								</ul>
							</div>
						</div>
					</div>
				</li>

				<li>
					<div class="tit flexDirectionRow">
						2、风速、风向
						<div class="more">更多</div>
					</div>
					<div class="moreData">
						<div class="colla-item">
							<h2 class="colla-title">
								桥面<i class="layui-icon layui-colla-icon"></i>
							</h2>
							<div class="colla-content show-this">
								<ul>
									<li class="flexDirectionRow">
										<h3>雨量计1：</h3>
										<div class="count flexDirectionRow">
											累计雨量：<span class="num">20.68mm</span>
										</div>
										<div class="count flexDirectionRow">
											Y轴：<span class="num">20.8mm</span>
										</div>
									</li>
									<li class="flexDirectionRow">
										<h3>雨量计2：</h3>
										<div class="count flexDirectionRow">
											累计雨量：<span class="num">20.99mm</span>
										</div>
									</li>
									<li class="flexDirectionRow">
										<h3>雨量计3：</h3>
										<div class="count flexDirectionRow">
											累计雨量：<span class="num">19.28mm</span>
										</div>
									</li>
								</ul>
							</div>
						</div>
						<div class="colla-item">
							<h2 class="colla-title">
								拱顶<i class="layui-icon layui-colla-icon"></i>
							</h2>
							<div class="colla-content show-this">
								<ul>
									<li class="flexDirectionRow">
										<h3>雨量计1：</h3>
										<div class="count flexDirectionRow">
											累计雨量：<span class="num">20.68mm</span>
										</div>
										<div class="count flexDirectionRow">
											Y轴：<span class="num">20.8mm</span>
										</div>
									</li>
									<li class="flexDirectionRow">
										<h3>雨量计2：</h3>
										<div class="count flexDirectionRow">
											累计雨量：<span class="num">20.99mm</span>
										</div>
									</li>
									<li class="flexDirectionRow">
										<h3>雨量计3：</h3>
										<div class="count flexDirectionRow">
											累计雨量：<span class="num">19.28mm</span>
										</div>
									</li>
								</ul>
							</div>
						</div>
					</div>
				</li>
			</ul>
		</div>
	</div>
</div>
<script type="text/javascript">
	var structId = $("#structureId").val();
	var projectId = $("#flagProjectId").val();
	$(function() {
	    getPhoto();
	    getVideo();
		$.initThirdTitle();

		//获取监测类型
		var monitorTypeReq = {
			url : '${ctx}/monitorType/getTypeList',
			para : {
				'structId' : structId
			},
			callback : function(res) {
				if (res.data) {
					var html = '';
					var v = res.data;
					for (var i = 0; i < v.length; i++) {
						html += '<li data-pkid="' + v[i].id + '">' + v[i].name + '</li>';
					}
					$('#monitorTypeTab').html(html);
					$('#monitorTypeTab li:eq(0)').addClass('layui-this');
					getMonitorItems($('#monitorTypeTab li:eq(0)').data('pkid'), $('#monitorTypeTab li:eq(0)'));
				//监测类型标签切换
				}
			}
		}
		$._MultAjax(monitorTypeReq);

		$('#data-list').off('click', '#monitorTypeTab li').on('click', '#monitorTypeTab li', function() {
			var _this = $(this);
			var monitorTypeId = _this.data('pkid');
			getMonitorItems(monitorTypeId, _this);
		});
		
		/* $('#imageShow img').off('dblclick', '#imageShow img').on('dblclick', '#imageShow img', function() {
			alert('test');
		}); */
		
	
		var timer = null;
		$('#imageShow').off("dblclick","img").on("dblclick","img",function(){
		 clearTimeout(timer);
		      var index = layer.load();
			  var pid =$(this).next().val();
			  layer.confirm('你确要删除该照片吗？', {
                                btn : [ '确定', '取消' ] //按钮
                            }, function() {
                                $.ajax({
                                    type : 'POST',
                                    url : '${ctx}/monitorContent/delPhoto',
                                    data : {
                                        'photoId' : pid
                                    },
                                    dataType : 'json',
                                    success : function(res) {
                                        if (res.success == '1') {
                                            layer.close(index);
                                            layer.msg('删除成功');
                                            getPhoto();
                                        }
                                    }
                                });
                            },function(){
                            	layer.close(index);
                            });
			
		})
		$('#imageShow').off("click","img").on("click","img",function(){
		var _this = $(this);
		  clearTimeout(timer);
		  timer = setTimeout(function(){
		    var url =_this[0].src;
		  layer.open({
					title : '查看详情',
					area : [ '1080px', '700px' ],
					content:'<img src=' + url + ' alt="" />' ,
					});
		  
        }, 300);    
		})
		
		
		
		//上传按钮点击事件
		$(document).off('click', '#btn-upload').on('click', '#btn-upload', function() {
			layer.open({
						title : '选择上传文件类型',
						area : [ '500px', '260px' ],
						btn : false,
						content : '<div class="layui-form-item">' +
							'<input id="file" type="file" name="file[]" multiple="multiple" accept="image/gif,image/jpeg,image/jpg,image/png,image/svg,video/mp4" style="margin-left: 0.7vw;margin-top: 1vh;">' +
							'<button id="changefile" type="button" class="layui-btn layui-btn-normal" style="margin-left: 15vw;margin-top: 5vh;">开始上传</button>' +
							'</div>'
					})
					$("#changefile").click(function() {
						var formData = new FormData();
						for (var i = 0; i < $('#file')[0].files.length; i++) {
							formData.append('file[]', $('#file')[0].files[i]);
						}
						var prijectId =$("#flagProjectId").val();
						var index = layer.load();
					$.ajax({
						type : "POST",
						url : "${ctx}/monitorContent/upload?projectId="+prijectId,
						data : formData,
						contentType : false, // 不设置内容类型
						processData : false, // 不处理数据
						dataType : "json",
						success : function(data) {
						  if (data.success == '1') {
						      layer.close(index); 
						      layer.closeAll();
	                          layer.msg('上传成功');
	                          getPhoto();
	                          getVideo();
					        }
						},
						error : function(data) {
						layer.close(index); 
	                          layer.closeAll();
						      layer.msg('上传失败');
							// 请求失败后要执行的代码
	
						}
					});
				});
		});
		//加载所有未处理的异常数据
		getAllNoDealErrorData();
	});


	//获取监测项
	function getMonitorItems(monitorTypeId, domObj) {
		var monitorItemReq = {
			url : '${ctx}/monitorContent/getMonitorItemsConfig',
			para : {
				'projectId' : projectId,
				'monitorTypeId' : monitorTypeId
			},
			callback : function(res) {
				var html = '';
				if (res.data) {
					var v = res.data;
					if (v.length > 0) {
						var itemObj = {};
						var paramList = [];
						for (var i = 0; i < v.length; i++) {
							itemObj[v[i].monitor_item_id] = v[i].monitor_item_name;
							var paramObj = {};
							paramObj.paramId = v[i].monitor_param_id;
							paramObj.paramName = v[i].monitor_param_name;
							paramObj.pItemId = v[i].monitor_item_id;
							paramList.push(paramObj);
						}

						if (itemObj) {
							var i = 1;
							$.each(itemObj, function(k, v) {
								html += '<li>' +
									'<div class="tit flexDirectionRow">' + i + '、' + v +
									'<div class="more" data-pkid="' + k + '">更多</div>' +
									'</div>' +
									'<div class="moreData"></div>'
								'</li>';
								i++;
							})
						}

						//展开收缩监测项
						$('#monitorItemTab').off('click', 'li .more').on('click', 'li .more', function() {
							var _this = $(this);
							_this.parent().next('.moreData').empty();
							//方法一
							_this.parent().siblings('.moreData').slideToggle(function() {
								if ($(this).is(":visible")) {
									if (paramList) {
										var monitorItemId = _this.data('pkid');
										getMonitorParams(monitorItemId, paramList, _this.parent().next('.moreData'));
									} else {
										layer.msg('暂无配置监测参数', {
											icon : 5,
											time : 1500
										});
									}
								}
							});
						});

					} else {
						layer.msg('暂无配置监测项', {
							icon : 5,
							time : 1500
						});
					}
				} else {
					layer.msg(res.message, {
						icon : 5,
						time : 1000
					});
				}
				$('#monitorItemTab').html(html);

			}
		}
		$._MultAjax(monitorItemReq);
	}

	//获取监测参数
	function getMonitorParams(monitorItemId, paramList, domObj) {
		var html = '';
		$.each(paramList, function(i, v) {
			if (monitorItemId == v.pItemId) {
				html += '<div class="colla-item" data-pkid="' + v.paramId + '">' +
					'<h2 class="colla-title">' +
					v.paramName + '<i class="layui-icon layui-colla-icon layui-icon-right"></i>' +
					'</h2>' +
					'<div class="colla-content">' +
					'<ul></ul>' +
					'</div>' +
					'</div>';
			}
		});
		$(domObj).html(html);
		//展开收缩监测参数
		$('#data-list').off('click', '#monitorItemTab li .moreData .colla-item .colla-title').on('click', '#monitorItemTab li .moreData .colla-item .colla-title', function() {
			var _this = $(this).parent(); //getMonitorDatas  colla-content
			var monitorParamId = _this.data('pkid');
			_this.find('.colla-content').empty();
			//方法一
			_this.find('.colla-content').slideToggle(function() {
				if ($(this).is(":visible")) {
					var monitorItemId = _this.data('pkid');
					getMonitorDatas(monitorItemId, _this.find('.colla-content'));
				}
			});
		});
	}

	//获取项目关联点位数据
	function getMonitorDatas(monitorParamId, domObj) {
		var monitorItemReq = {
			url : '${ctx}/monitorContent/getRealTimeDatas',
			para : {
				'projectId' : projectId,
				'monitorParamId' : monitorParamId
			},
			callback : function(res) {
				var html = '<ul>';

				//演示用
				/* for (var i=0;i<3;i++) {
					html += '<li data-project="1" data-monitorparam="2" data-device="3" data-site="4" class="flexDirectionRow">'+
						'<div class="count flexDirectionRow">'+
							'设备：<span class="num">应变计</span>'+
						'</div>'+
						'<div class="count flexDirectionRow">'+
							'点位：<span class="num">1#正弦应变</span>'+
						'</div>'+
						'<div class="count flexDirectionRow">'+
							'值：<span class="num">0.06522746</span>'+
						'</div>'+
						'<div class="count flexDirectionRow">'+
							'单位：<span class="num">uε</span>'+
						'</div>'+
					'</li>';
				} */

				//项目正式介入设备时用
				if (res.data) {
					var v = res.data;
					if (v.length > 0) {
						for (var i = 0; i < v.length; i++) {
							html += '<li data-project="' + v[i].project_id + '" data-monitorparam="' + v[i].monitor_param_id + '" data-device="' + v[i].device_id + '" data-site="' + v[i].monitor_sites_id + '" class="flexDirectionRow">' +
								'<div class="count flexDirectionRow">' +
								'设备：<span class="num">' + v[i].device_name + '</span>' +
								'</div>' +
								'<div class="count flexDirectionRow">' +
								'点位：<span class="num">' + v[i].monitor_sites_name + '</span>' +
								'</div>' +
								'<div class="count flexDirectionRow">' +
								'值1/x：<span class="num">' + v[i].device_upload_data + '</span>' +
								'</div>' +
								'<div class="count flexDirectionRow">' +
								'单位1：<span class="num">' + v[i].unit + '</span>' +
								'</div>' +
								'<div class="count flexDirectionRow">' +
								'值2/Y：<span class="num">' + v[i].device_upload_data_spare + '</span>' +
								'</div>' +
								'<div class="count flexDirectionRow">' +
								'单位2：<span class="num">' + v[i].unit_spare + '</span>' +
								'</div>' +
								'<div class="count flexDirectionRow">' +
								'温度：<span class="num">' + v[i].temperature + ' ℃</span>' +
								'</div>' +
								'<div class="count flexDirectionRow">' +
								'上传时间：<span class="num">' + v[i].upload_time + '</span>' +
								'</div>' +
								'</li>';
						}
						html += '</ul>';
					} else {
						layer.msg('暂无数据', {
							icon : 5,
							time : 1000
						});
					}
				} else {
					layer.msg(res.message, {
						icon : 5,
						time : 1000
					});
				}
				$(domObj).html(html);
				//获取监测参数监测数据折线图
				$('#data-list').off('click', '#monitorItemTab li .moreData .colla-item .colla-content ul li').on('click', '#monitorItemTab li .moreData .colla-item .colla-content ul li', function() {
					var _this = $(this); //getMonitorDatas  colla-content
					var projectId = _this.data('project');
					var monitorParamId = _this.data('monitorparam');
					var deviceId = _this.data('device');
					var monitorSite = _this.data('site');
					//layer.alert(projectId+","+monitorParamId+","+deviceId+","+monitorSite);
					layer.msg('暂无可接入设备', {
						icon : 5
					});
				});
			}
		}
		$._MultAjax(monitorItemReq);
	}

	function dataGo() {
		var itemLen = $("#scroll-space").find("tr").length;
		if (itemLen > 6) {
			$('.tbl-body tbody').html($('.tbl-body tbody').html() + $('.tbl-body tbody').html());
			$('.tbl-body').css('top', '0');
			var tblTop = 0;
			var speedhq = 30; // 数值越大越慢
			var outerHeight = $('.tbl-body tbody').find("tr").outerHeight();
			//测试用临时变量，勿删
			var speedhqnew = speedhq;
			function Marqueehq() {
				if (tblTop <= -outerHeight * itemLen) {
					tblTop = 0;
				} else {
					tblTop -= 1;
				}
				$('.tbl-body').css('top', tblTop + 'px');

			//测试用临时变量，勿删
			/* speedhqnew += 30;
			if (speedhqnew >= 10) {
				clearInterval(MyMarhq);
			} */
			}

			//此处MyMarhq定时任务在base_top.jsp中设置为全局变量
			console.log(MyMarhq);
			clearInterval(MyMarhq);

			MyMarhq = setInterval(Marqueehq, speedhq);
			// 鼠标移上去取消事件 
			$(".tbl-body tbody").hover(function() {
				clearInterval(MyMarhq);
			}, function() {
				clearInterval(MyMarhq);
				MyMarhq = setInterval(Marqueehq, speedhq);
			})
		} else {
			$(".tbl-body tbody").off("hover");
			$('.tbl-body').css('top', '0');
		}
	}

	function getAllNoDealErrorData() {
		var projectId = $("#flagProjectId").val();
		var dataReq = {
			url : '${ctx}/monitorContent/getAllNoDealErrorData',
			para : {
				'projectId' : projectId
			},
			callback : function(res) {
					if (res.success == '1') {
						var html = '';
						for (var i = 0; i < res.data.length; i++) {
							html += '<tr>' +
								'<td>' + res.data[i].monitr_item_name + '</td>' +
								'<td>' + res.data[i].monitor_param_name + '</td>' +
								'<td>' + res.data[i].monitor_sites_name + '</td>' +
								'<td>' + res.data[i].device_upload_data + '</td>';
							if (res.data[i].warn_level == '1') {
								html += '<td><label class="yellow-lab color-lab"></label></td>';
							} else if (res.data[i].warn_level == '2') {
								html += '<td><label class="orange-lab color-lab"></label></td>';
							} else if (res.data[i].warn_level == '3') {
								html += '<td><label class="red-lab color-lab"></label></td>';
							} else {
								html += '<td><label class="green-lab color-lab"></label></td>';
							}
							;
							html += '<td>' + res.data[i].upload_time + '</td>' +
								'</tr>';
						}
						$("#scroll-space").html(html);
					dataGo();
					}
				}
			};
			$._MultAjax(dataReq);
		}



		function getPhoto() {
			var projectId = $("#flagProjectId").val();
			var index = layer.load();
			$.ajax({
				type : 'POST',
				url : '${ctx}/monitorContent/getPhoto',
				data : {
					'projectId' : projectId
				},
				dataType : 'json',
				success : function(res) {
					if (res.success == '1') {
						layer.closeAll();
						$('#imageShow').html("");
						var projectId = $("#flagProjectId").val();
						$.each(res.data, function(i, item) {
							str = '<img src=' + item.url + ' alt="" /><input type="hidden" value='+item.id+'>';
							$('#imageShow').append(str);
						});
					}
				}
			});
		}
		
		
		function getVideo() {
			var projectId = $("#flagProjectId").val();
			var index = layer.load();
			$.ajax({
				type : 'POST',
				url : '${ctx}/monitorContent/getVideo',
				data : {
					'projectId' : projectId
				},
				dataType : 'json',
				success : function(res) {
					if (res.success == '1') {
						layer.close(index);
						$('#videoShow').html("");
						var projectId = $("#flagProjectId").val();
						str = ' <video src="'+res.data.url+'" controls="controls" style="width: 39vw;height: 46vh;"></video>';
					    $('#videoShow').html(str);
					}
				}
			});
		}
</script>