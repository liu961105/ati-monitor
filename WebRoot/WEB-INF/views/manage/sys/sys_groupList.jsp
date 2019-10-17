<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/public/taglib.jspf"%>

<link rel="stylesheet" href="${ctx}/res/ztree/css/metroStyle/metroStyle.css" type="text/css" />

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
/* li{
flow: right;
} */
.label .check_btn {
	display: inline-block;
	width: 18px;
	height: 18px;
	border: 1px solid #cfd9db;
	vertical-align: middle;
	margin-right: 12px;
	cursor: pointer;
}

.dept-tree-wrap {
	padding: 14px;
	width: 220px;
	border: 1px solid #ddd;
	overflow: auto;
	float: left;
}

.dept-tree-wrap .ztree {
	min-height: 300px;
}

.device-list-wrap {
	border: 1px solid #ddd;
	padding: 14px;
}

.device-li {
	padding-top: 14px;
	border: #ddd;
	background: #fff;
}

.device-li ul {
	overflow: hidden;
}

.device-li .it {
	float: left;
	padding: 10px;
	width: 120px;
	height: 80px;
	border-radius: 4px;
	margin-right: 14px;
	margin-bottom: 14px;
}

.device-li .ok {
	background: #88d87d;
}

.device-li .bad {
	background: #fb9191;
}

.device-li .name {
	padding: 6px;
	color: #333;
	border-bottom: 1px dashed #ddd;
}

.device-li .btn {
	width: 40px;
	height: 40px;
	line-height: 40px;
	cursor: pointer;
	text-align: center;
	border-radius: 50%;
	border: 1px solid #ddd;
	display: inline-block;
	margin-left: 10px;
	margin-top: 8px;
	font-size: 12px;
	color: #fff;
}

.device-li .tz.btn {
	background: #488c92;
}

.device-li .bx.btn {
	background: #dcd162;
}

.device-li .tz.btn:hover {
	background: #59a8af;
}

.device-li .bx.btn:hover {
	background: #cec24b;
}

.device-li .rpi {
	background: #84b5e0;
}
</style>




<div id="data-list" style="margin-top:25px;">
	<div class="banner">
		<span class="base-blue-01 base-search" data-title='班组信息设置' style="display:none;"></span>
	</div>
	<div class="content-wrap">
		<!-- <div class="dept-tree-wrap">
			<ul id="treeDemo" class="ztree metro"></ul>
		</div> -->
		<div class="device-list-wrap"></div>
	</div>
</div>
<script type="text/javascript">
$(function(){
	$.initThirdTitle();
	$(".device-list-wrap").load("${ctx}/sysGroup/pageList");
});

//生成车间列表树
function createWkspTree(znode) {
	var setting = {
		check:{
              enable:false
        },
        data:    {
            simpleData:{
                enable:true
            }
        },
	  	view:{
	    	showIcon: false
	  	},
	  	callback:{    //第一步
	  		onClick:zTreeOnClick   
        }
	};
	var zNodes =[
		{
			name:"制造部", open:true,
			children: znode
		}
	];
	$.fn.zTree.init($("#treeDemo"), setting, zNodes);
				
}	

function zTreeOnClick(event, treeId, treeNode) {
   var wkspId=treeNode.id;
   var wkspName=treeNode.name;
   $("#wkspName").html(wkspName+'当前设备情况');
   getGroupByWorkshop(wkspId);
   
};

function getGroupByWorkshop(wkspId){
	$(".device-list-wrap").load("${ctx}/sysGroup/pageList",{"wkspId":wkspId});
}

</script>