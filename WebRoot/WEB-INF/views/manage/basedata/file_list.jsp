<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/public/taglib.jspf"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!-- 列表界面 -->
<div id="data-list">
	<div class="banner layui-hide">
		<span class="base-blue-01 base-search" data-title='文档列表'>文档列表</span>
	</div>
	<div class="banner">
		<span class="base-blue-01 base-search">文档列表</span>
	</div>

	<form id="fa-search" class="layui-form-pane" style="margin-top: 15px;">
		<input type="hidden" id="fileId" name="fileId" value="${id}">

		<div class="layui-form-item">
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
			<div class="layui-inline">
				<label class="layui-form-label">文件名称</label>
				<div class="layui-input-inline">
					<input type="text" name="fileName" id="fileName" autocomplete="off"
						class="layui-input">
				</div>
				<div class="layui-inline">
					<button id="btn_search" type="button"
						class="layui-btn layui-btn-normal" data-toggle="modal">
						<i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
					</button>
				</div>
				<div class="layui-inline layui-inline-right">
					<shiro:hasPermission name="fileManage:downloadFiles">
						<button id="downloadFiles" type="button" class="layui-btn"
							data-toggle="modal">批量下载</button>
					</shiro:hasPermission>
					<shiro:hasPermission name="fileManage:deleteFiles">
						<button type="button" class="layui-btn layui-btn-danger"
							data-toggle="modal" id="fileDeletes">删除</button>
					</shiro:hasPermission>
					<button id="btn_back1" type="button" class="layui-btn layui-btn-warm"
			data-toggle="modal">返回</button>
				</div>
			</div>
		</div>
	</form>
	<div id="list">
		<table class="layui-table">
			<colgroup>
				<col width="50">
				<col width="60">
				<col width="200">
				<col width="150">
				<col width="150">
				<col width="150">
				<col width="80">
				<col width="100">
				<col width="150">
			</colgroup>
			<thead>
				<tr>
					<th><div class="label">
							<input id="checkAll" lay-skin="primary" type="checkbox"
								class="check_btn"> <label class="checkboxLable"
								for="checkAll"></label>
						</div></th>
					<th>序号</th>
					<th>文件名称</th>
					<th>文件存放路径</th>
					<th>文件大小</th>
					<th>上传时间</th>
					<th>修改时间</th>
					<th>状态</th>
					<th>操作</th>
				</tr>
			</thead>
			<tbody id="datalist">
			</tbody>

			<script id="tradecent-template" type="text/x-handlebars-template">
	{{#each this}}
	<tr>
		<td><div class="label">
			 	<input id="{{id}}" name="fileItem" value="{{id}}" type="checkbox" class="check_btn check_item" 
				   data-shstate="{{shStatus}}" data-state="{{status}}" data-name="{{fileName}}" data-url="{{filePath}}">
				<label class="checkboxLable" for="{{id}}"></label>
			</div>
		</td>
		<td><div class='base-wrap'>{{addOne @index}}</div></td>
		<td><div class='base-wrap left' id='fileName'>{{fileName}}</div></td>
			<td><div class='base-wrap left'>{{filePath}}</div></td>
		<td><div class='base-wrap left'>{{fileSize}}</div></td>
		<td><div class='base-wrap left'>{{uploadTime}}</div></td>
		<td><div class='base-wrap left'>{{updateTime}}</div></td>
		<td><div class='base-wrap'>{{getStatus status}}</div></td>
		<td>
		<shiro:hasPermission name="fileManage:deleteFile"><span  class="oper-handle iconfont icon-shanchu base-red delete" title='删除文件' data-pkid={{id}}></span></shiro:hasPermission>
		<shiro:hasPermission name="fileManage:updateFile"><span class="oper-handle iconfont icon-bianji base-yellow update" title='修改文档' data-pkid={{id}}></span></shiro:hasPermission>
		<shiro:hasPermission name="fileManage:downloadFile"><span class="oper-handle iconfont icon-daochu base-green download" title='文件导出' data-pkid={{id}}  name="downloadItem" data-name="{{fileName}}" data-url="{{filePath}}"></span></shiro:hasPermission>	
</td>
	</tr>
	{{/each}}		
	</script>
		</table>
	</div>
</div>

<!-- 新增与详情页面 -->
<div id="data-form" data-title='文档类型新增' style="height: 300px">
	<form id="form" class="layui-form-pane">
		<input type="hidden" name="id"> <input type="hidden"
			name="atiProjectStructure.id" id="atiProjectStructureId" />
		<div class="layui-row">
			<div class="layui-col-md6">
				<div class="layui-form-item">
					<label class="layui-form-label">文件名称</label>
					<div class="layui-input-block">
						<input name="fileName" class="layui-input validate require">
						<input name="projectId" id="projectId" class="layui-input validate "
							type="hidden">
							<input name="filePath"id ="filePath" class="layui-input validate"  type= "hidden"/> 
							<input name="fileSize"id ="fileSize" class="layui-input validate" type= "hidden"/> 
						<input name="uploadTime"id ="uploadTime" class="layui-input validate" type= "hidden"/> 
						<input name="projectId"id ="projectId" class="layui-input validate" type= "hidden"/> 
							<input name="projectId"id ="projectId" class="layui-input validate" type= "hidden"/> 
							<input name="fileType"id ="fileType" class="layui-input validate" type= "hidden"/> 
							<input name="strucId"id ="strucId" class="layui-input validate" type= "hidden"/> 
								<input name="strucId"id ="strucId" class="layui-input validate" type= "hidden"/> 
								<input name="fileId"id ="fileId" class="layui-input validate" type= "hidden"/> 
					</div>
				</div>
			</div>
	   </div>
		<div class="layui-row">
			<div class="layui-col-md6">
				<div class="layui-form-item">
					<label class="layui-form-label">状态</label>
					<div class="layui-input-block">
						<select class="base-select validate require" name="status">
							<option value="1">有效</option>
							<option value="0">无效</option>
						</select>
					</div>
				</div>
			</div>
		</div>
	</form>
	<div id="toolbar" class="toolbar buttom-btn">
		<button id="btn_back" type="button" class="layui-btn layui-btn-warm"
			data-toggle="modal">返回</button>
		<button id="btn_save" type="button" class="layui-btn layui-btn-normal"
			data-toggle="modal">保存</button>
	</div>
</div>
<!--end新增与详情页面-->

<!-- 文件上传弹出框 -->
<div id="mainPage" style="display:none;margin:10px auto;">
	<form class="layui-form" id="orderForm"
		style="border: 1px solid #ddd;border-color: #e3e8ee;height: 100px;width: 90%;">
		<input type="hidden" id="fileId" name="fileId" value="${id}">
		<div style="padding-right: 30px;">
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
<div id="handout_wrap_inner" style="display:none;"></div>
<script type="text/javascript">

	$(function() {
		$.baseEvent({
			ctx : '${ctx}',
			param : [ 'fileName', 'fileId' ],
			isPage : true,
			pageList_url : '/fileManage/pageList',
			form_url : '/fileManage/save',
			data_list : '${ctx}/route/manage/basedata/file_list',
			del_url : '/fileManage/fileDelete',
			findBy_url : '/fileManage/findById',
			add_is_dialog : false
		})
	//getDept();//上级参数
	//	$(".pName").on('click',function(){
	//		$("#tree").show();
	//		$.fn.zTree.init($("#tree"), setting);
	//	});
	//隐藏tree
	//   $('.hidetree').click(function(){
	//		$(".topul").next().hide();
	//	}); 
	});

	$(function() {
		//全选/反选
		$("#checkAll").click(function() {
			if (this.checked) {
				$("input[name='fileItem']:checkbox").each(function() {
					$(this).attr("checked", true);
				});
			} else {
				$("input[name='fileItem']:checkbox").each(function() {
					$(this).attr("checked", false);
				});
			}
		});
		$("#btn_back1").click(function(){
		 $(".data-content").load("${ctx}/route/manage/basedata/file_type");
	})

		//文件批量删除
		$("#fileDeletes").click(function() {
			var ids = [];
			$("input[name='fileItem']:checked").each(function() {
				ids.push($(this).attr("id"));
			});
			if (ids.length > 0) {
				var fileId = ids.join(",");
				layer.confirm('你确定要删除该文件吗？', {
					btn : [ '确定', '取消' ] //按钮
				}, function() {
					$.ajax({
						url : '${ctx}/fileManage/fileDeletes',
						data : {
							ID : fileId
						},
						dataType : 'json',
						success : function(data) {
							if (data.success == "success") {
								layer.msg(data.message, {
									time : 1500
								});
								$("#data-list").gotoNewLink({
									url : "${ctx}/route/manage/basedata/file_list",
									data : {
										"fileId" : fileId
									}
								});
							} else {
								layer.msg(1, {
									content : data.message,
									time : 1500,
									success : function(layero) {
										layero.css({
											'background-color' : '#F00'
										});
										layero.find('.layui-layer-content').css({
											'color' : '#FFFFFF',
											'font-size' : '13px'
										});
									}
								});
							}
						},
						error : function() {
							layer.msg(1, {
								content : '网络故障，请稍后再试',
								time : 1500,
								success : function(layero) {
									layero.css({
										'background-color' : '#F00'
									});
									layero.find('.layui-layer-content').css({
										'color' : '#FFFFFF',
										'font-size' : '13px'
									});
								}
							});
						}
					})
				});
			}
		})
	})
	//条件查询
	//	 $('#selectOrder').click(function() {
	//		var projectId = $("#flagProjectId").val();
	//		$("#data-list").load("${ctx}/fileManage/pageList?productModel=" + projectId);
	//	});

	/*
	*文件上传 
	*/
	var uploadDialogShow = "";
	$("#uploadDialog").click(function() {
		$("#productModelNum").val("");
		$("#catalogId").val("")
		uploadDialogShow = layer.open({
			type : 1,
			shade : false,
			title : "<span class='dialog_title base-zb-info'>新增文件</span>",
			area : [ '30%', '38%' ],
			content : $("#mainPage")
		});
	});

	///加载文件目录树
	$("#catalogName").on("click", function() {
		$("#tree").show();
		$.fn.zTree.init($("#tree"), setting);
	});


	//批量下载
	$("#downloadFiles").on("click", function() {
		var fileNames = "";
		var filePaths = "";
		var flagName = "[";
		var tmp = "";
		$("input[name='fileItem']").each(function() {
			var shState = $(this).data("shstate");
			var state = $(this).data("state");
			var fileName = $(this).data("name");
			var filePath = $(this).data("url");
			if (this.checked) {
				fileNames += fileName + ",";
				filePaths += filePath + ",";
			}
			if (shState == "0" || state == "0") {
				flagName += fileName + "]、[";
				tmp += fileName + ",";
			}
		});
		if (fileNames == "") {
			layer.msg("请选择文件");
		} else if (tmp != "") {
			flagName = flagName.substr(0, flagName.length - 2);
			layer.alert("已选文件中,文件" + flagName + "已被锁定或失效，无法下载,请重新选择！");
		} else {
			window.location.href = "${ctx}/fileManage/downLoadFiles?fileNames=" + fileNames + "&filePaths=" + filePaths;
		}
	});

	/*
	* 单个文件下载
	*/

	$("#data-list").on("click", ".download", function() {
		var fileName = "";
		var filePath = "";
		fileName = $(this).data("name");
		filePath = $(this).data("url");
		if (fileName == "" || filePath == "") {
			layer.msg("文件不存在");
		} else {
			window.location.href = "${ctx}/fileManage/download?fileName=" + fileName + "&filePath=" + filePath;
		}
	});






	/**************************ztree************************************/
	var setting = {
		view : {
			dblClickExpand : false,
			showLine : true,
			selectedMulti : false,
			showIcon : false
		},
		data : {
			simpleData : {
				enable : true
			}
		},
		async : { //ztree异步请求数据 
			enable : true,
			url : "${ctx}/fileCatalog/fcTree", //请求action方法 
			type : "get",
			dataFilter : filter, //预处理数据
		//autoparam: ["data"]
		},
		callback : {
			beforeClick : beforeClick
		}
	};

	function filter(treeId, parentNode, childNodes) {
		if (!childNodes) return null;
		for (var i = 0, l = childNodes.length; i < l; i++) {
			childNodes[i].name = childNodes[i].name.replace('', '');
		}
		return childNodes;
	}
	/* 获取返回的数据，进行预操作 */
	function ajaxDataFilter(treeId, parentNode, responseData) {
		responseData = responseData.data;
		return responseData;
	}
	;

	//异步加载完成时运行，此方法将所有的节点打开
	function zTreeOnAsyncSuccess(event, treeId, msg) {
		var treeObj = $.fn.zTree.getZTreeObj("tree");
		treeObj.expandAll(true);
		treeObj.checkNode(treeId, !treeId.checked, null, true);
		//详情界面
		var my = {
			url : "${ctx}/sysRole/findAuthority",
			para : {
				"roleId" : $("input[name='roleId']").val()
			},
			callback : function(res) {
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
		$("#" + treeId).hide();
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




	layui.use([ 'form', 'element', 'jquery', 'layer', 'upload' ], function(data) {
		var $ = layui.jquery,
			form = layui.form,
			layer = parent.layer === undefined ? layui.layer : parent.layer,
			element = layui.element,
			upload = layui.upload;
		var mfCode;
		var mfName;
		var fileType;
		var fileTypeName;
		var projectName;
		var projectNamevalue;
		form.on('select(mfName)', function(data) { //aihao为下拉框的lay-filter
			//mfCode = data.value;
			mfName = data.elem[data.elem.selectedIndex].text;
			$.ajax({
				url : '${ctx}/fileManage/getMaterielCodeList',
				type : 'post',
				data : {
					'materielName' : mfName
				},
				dataType : 'json',
				success : function(res) {
					if (res.success == 'success') {
						var html = '<option value="">请选择物料代码</option>';
						for (var i = 0; i < res.data.length; i++) {
							html += '<option value="' + res.data[i].materielCode + '">' + res.data[i].materielCode + '</option>';
						}
						$("#mfCode").html(html);
						form.render();
					} else {
						layer.msg(1, {
							content : res.message,
							time : 1500,
							success : function(layero) {
								layero.css({
									'background-color' : '#F00'
								});
								layero.find('.layui-layer-content').css({
									'color' : '#FFFFFF',
									'font-size' : '13px'
								});
							}
						});
					}
				},
				error : function() {
					layer.msg(1, {
						content : '网络故障，请稍后再试',
						time : 1500,
						success : function(layero) {
							layero.css({
								'background-color' : '#F00'
							});
							layero.find('.layui-layer-content').css({
								'color' : '#FFFFFF',
								'font-size' : '13px'
							});
						}
					});
				}
			})
		//$("#mfCode").val(mfCode);
		//form.render();
		})
		form.on('select(mfCode)', function(data) { //aihao为下拉框的lay-filter
			//$("#mfCode").val(data.value);
			mfCode = data.value;
		});

		form.on('select(fileType)', function(data) { //aihao为下拉框的lay-filter
			fileType = data.value;
			fileTypeName = data.elem[data.elem.selectedIndex].text;
		});
		form.on('select(projectName)', function(data) {
			projectName = data.value;
			projectNamevalue = data.elem[data.elem.selectedIndex].text;
		});
		form.render();
		<!--文件上传 - -->
		var fileId = $('#fileId').val();
		upload.render({
			elem : '#checkoutFile',
			url : '${ctx}/fileManage/uploadFile',
			data : {
				"fileType" : function() {
					return fileType;
				},
				"fileId" : fileId
			},
			method : "post",
			auto : false,
			bindAction : '#uploadFile',
			accept : 'file',
			before : function(obj) {},
			done : function(res) {
				if (res.success == 'success') {
					showOkTip(res.message);
					debugger
					$(".data-content").load("${ctx}/fileType/sonPageMain", {
						"id" : $('#fileId').val()
					});
					//var upload = layer.getFrameIndex(window.name);
					layer.close(uploadDialogShow);
				} else {
					alertError(res.message);
				}
			}
		});
	})
</script>
