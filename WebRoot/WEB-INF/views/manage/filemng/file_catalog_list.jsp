<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/public/taglib.jspf"%>

<link rel="stylesheet" href="${ctx}/res/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css"/>
<link rel="stylesheet" href="${ctx}/res/css/manage/tree-app.css" type="text/css"/>
<script type="text/javascript" src="${ctx}/res/region/region_catalog.js"></script>
<script type="text/javascript" src="${ctx}/res/js/lib/validate/jquery.validate.js"></script>
<script type="text/javascript" src="${ctx}/res/js/lib/validate/jquery.validate.extension.js"></script>

<div id="data-list" class="data-list">
	<div class="banner" style="display:none;">
		<span class="base-blue-01 base-search" data-title='文件目录列表'></span>
	</div>
	<%-- <shiro:hasPermission name="sysComp:exportOrder"> --%>
		<button id="catalogConfig" class="layui-btn layui-btn-normal" style="float:right;margin-right: 10px;cursor:pointer;z-index:10;position: relative;">目录配置</button>
	<%-- </shiro:hasPermission> --%>
	<div class="layui-tab layui-tab-brief" lay-filter="docDemoTabBrief">
	<ul id="isLoseCatalog" class="layui-tab-title">
		<li class="layui-this" id="unPlan" data-url="${ctx}/fileCatalog/normalMain">可用文件</li>
		<li id="planed" data-url="${ctx}/fileCatalog/loseMain">失效文件</li>
	</ul>
	</div>
    <!--左侧树形结构-->
    <div id="tablelist">
	</div>
	
	<div id="configDialog" style="display:none;">
		<table class="tablelist" style="min-width:500px;width: 98%;">
			<tbody>
				<tr>
					<td>
						<div class="zTreeDemoBackground left" style="overflow-x:auto;overflow-y:auto;">
							<ul id="treeDemo" class="ztree" style="width:95%; height:450px; display: block;"></ul>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	</div>

    <!--表单的底部区域-->
    <div class="form-footer"></div>
    <!--表单的预览或提示区域-->
    <div class="form-preview"></div>
    <!--表单的提示区域-->
    <div class="form-tip"></div>
    <!--表单的弹出层区域-->
    <div class="form-dialog"></div>

</div>
<script type="text/javascript">
$().ready(function() {
	$.initThirdTitle();
	//默认加载可用文件
	$("#tablelist").load("${ctx}/fileCatalog/normalMain");
	
	//选项卡切换
	$("#isLoseCatalog li").click(function(){
		var dataUrl = $(this).data("url");
		$("#tablelist").load(dataUrl);
	});
	
	//目录配置弹窗
	$("#catalogConfig").click(function(){
		layer.open({
			type: 1,
			shade: false,
			title: "<span class='dialog_title base-zb-info'>目录配置</span>",
			area: ['40%', '58%'],
			content: $("#configDialog"),
			cancel: function(index, layero){ 
				$("#tablelist").load("${ctx}/fileCatalog/normalMain"); 
			}  
		});
	})
	
//表单校验
var deptNameInput=$("#deptName").val();
var deptCode=$("#regionCode").val();
      // Ajax重命名校验
	$.uniqueValidate('uniqueDeptName', '${ctx}/sys/department/checkDeptName', ['regionName','oldRoleName','regionCode'], '对不起，这个部门名称重复了');

});
</script>
