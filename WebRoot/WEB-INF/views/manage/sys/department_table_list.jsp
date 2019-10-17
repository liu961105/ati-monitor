<%@ page language="java" pageEncoding="UTF-8"%>
<%@include file="/WEB-INF/views/public/taglib.jspf"%>

<link rel="stylesheet" href="${ctx}/res/ztree/css/zTreeStyle/zTreeStyle.css" type="text/css"/>
<script >
var RGparam = '${companyId}';
var companyId = '${companyId}';
</script>
<script type="text/javascript" src="${ctx}/res/js/lib/jquery/jquery-1.8.3.min.js"></script>
<script type="text/javascript" src="${ctx}/res/ztree/js/jquery.ztree.all-3.5.min.js"></script>
<script type="text/javascript" src="${ctx}/res/region/region.js"></script>
<script type="text/javascript" src="${ctx}/res/js/lib/validate/jquery.validate.js"></script>
<script type="text/javascript" src="${ctx}/res/js/lib/validate/jquery.validate.extension.js"></script>

<style>
#tablelist table { text-align: left; width: 100%; margin-bottom: 0; background: #FFF; border: 1px solid #DDD; /*margin-top: 60px;*/ margin-right: auto; margin-left: auto; /*_width: 98%;*/ }
#tablelist table a { text-decoration: none; font-weight: normal; font-size: 12px; }
#tablelist table tr.even td { background: #fbfbfb; }
#tablelist table tr td, #tablelist table tr, .table_ninghua td { font-size: 12px !important; }
#tablelist table tr td, #tablelist table tr th { padding: 8px 10px; line-height: normal; text-align: left; }
.zTreeDemoBackground {border: 1px solid #ddd; */}
#tablelist form #main tbody tr td {padding: 0px 0px;}
#tablelist table tr td b, #tablelist table tr th b { padding: 0 5px; vertical-align: middle;}
#tablelist table tr th.headerSortUp { color: #333; background: url(../images/sortd.gif) 95% center no-repeat; }
#tablelist table tr th.headerSortDown { color: #333; background: url(../images/sorta.gif) 95% center no-repeat; }
#tablelist table tr td { color: #000; font-size: 13px; }
#tablelist table tr td.delete { width: 29px; text-align: center; }
#tablelist table tr td.delete a { opacity: .50; -moz-opacity: .50; }
#tablelist table tr td.delete a:hover { opacity: 1; -moz-opacity: 1; }
#tablelist table thead { background: #F7F7F7; border: 1px ssolid #9EDAFA; }
#tablelist table thead th { font-size: 14px; color: #636363; background: #D8D8D8 url(images/bar_bottom.png) bottom repeat-x; /*text-align:center;*/ }
#tablelist table td.td_tiele { text-align: right; color: #333; }
#tablelist .tableactions { overflow: hidden; padding: 0 1em 0px 0; float: right; }
#tablelist .tableactions select { width: 100px; margin-right: 5px; vertical-align: middle; outline: none; padding: 3px; background: #F3F3F3; color: #636363; border: 1px solid #D7D7D7; }
#tablelist .tableactions input.submit { border: 1px solid #D7D7D7; background: #F1F1F1 url(../images/mbg.jpg) center repeat-x; padding: 1px 6px; line-height: 20px; font-size: 12px; /*font-weight: bold;*/ color: #333; vertical-align: middle; /*text-shadow: 0 1px 0 #000;*/ cursor: pointer; border-radius: 1px; -moz-border-radius: 1px; -webkit-border-radius: 1px; }
#tablelist .tableactions input.submit:hover { background: #3D82BD url(../images/mbgh.jpg) center repeat-x; color: #FFF; border: 1px solid #243C62; /*text-shadow: 0 1px 0 #6e3704; -moz-box-shadow: inset 0 1px 0 #f3cf8c; -webkit-box-shadow: inset 0 1px 0 #f3cf8c; box-shadow: inset 0 1px 0 #f3cf8c;*/ }
#tablelist .table_pagination { font-size: 10px; font-weight: bold; padding: 5px 0 5px 1em; font-family: Verdana, Geneva, sans-serif; }
#tablelist .table_pagination.right { float: right; text-align: right; border: 0; width: 500px; overflow: hidden; padding-top: 1px; }
#tablelist .table_pagination a { text-decoration: none; border: 1px solid #ccc; padding: 3px 7px; margin: 0 1px; -webkit-border-radius: 3px; -moz-border-radius: 3px; border-radius: 3px; }
#tablelist .table_pagination a.active { color: #FFF; background: #5278F3; }
#tablelist .table_pagination a:hover { color: #fff; background: #5278F3; border: 1px solid #0069ac; text-shadow: 0 1px 0 #333; }

#tablelist table.data_form { margin: 5px auto; width: 98%; text-align: left;  color: #666; }
#tablelist table.data_form input { padding: 5px; }
/*#tablelist table.data_form tr { border-bottom: 1px solid #CCC; }*/
#tablelist table.data_form td { border: none; border-bottom: 1px solid #CCC; padding: 5px; line-height: 38px; vertical-align: middle; }
#tablelist table.data_form td img { vertical-align: middle; margin: 0 4px; }
#tablelist table.data_form span { padding: 0 5px; font-size: 20px; height: 30px; overflow: hidden; color: #CCC; }
#tablelist table.data_form select { width: 210px; padding: 5px; font: 14px/24px "microsoft yahei"; }
.blue_sub { background: #2A75AF; border: none; color: #FFF; padding: 0 20px; }
.blue_sub:hover { border: none; }
#tablelist table.data_form .pass_reg_submit { background: url(../../Images/New/WebPic/regbtn-split.gif) no-repeat; width: 109px; height: 34px; color: white; border: none; font-size: 14px; clear: both; display: inline-block; cursor: pointer; line-height: 10px; padding: 0; margin: 0 10px 0 0; }
#tablelist table.data_form .pass_reg_submit_hover, input.pass_reg_submit:hover { background-position: -120px 0; }
#tablelist table.data_form .pass_reg_submit_mousedown { background-position: -240px 0; }


#tablelist table.mes_form { margin: 5px auto; width: 95%; text-align: left;  color: #666; }
#tablelist table.mes_form input { padding: 2px 6px; }
/*#tablelist table.data_form tr { border-bottom: 1px solid #CCC; }*/
#tablelist table.mes_form td { border: none; border-bottom: 1px dashed #999; padding: 2px 5px; line-height: 34px; vertical-align: middle; }
#tablelist table.mes_form td img { vertical-align: middle; margin: 0 4px; }
#tablelist table.mes_form span { padding: 0 5px; font-size: 20px; height: 30px; overflow: hidden; color: #CCC; }
#tablelist table.mes_form select { width: 210px; padding: 5px; font: 14px/24px "microsoft yahei"; }
#tablelist table.mes_com td, #tablelist table.mes_com tr { border: none; padding: 0 5px; }

#tablelist table.reg_#tablelist table { width: 600px; /*background:#FF6;*/ margin: 2em 0 0 0; float: left; border: none; }
#tablelist table.reg_#tablelist table td { border: none; line-height: normal; height: 30px; overflow: hidden; vertical-align: top; }
.ztree li span.button.switch.level0 {visibility:hidden; width:1px;}
.ztree li ul.level0 {padding:0; background:none;}
.ztree li span.button.add {margin-left:2px; margin-right: -1px; background-position:-144px 0; vertical-align:top; *vertical-align:middle}

.list-warper {
padding: 0 0px;
letter-spacing: 0.05em;
}
.form-warper
{
 min-width:1003px;
}

.form-content .form-table {
    margin: 0 -20px;
}

ol, ul {
    list-style: none;
}

.form-content .input, .form-content textarea {
    width: 100%;
    display: block;
    height: 40px;
    font-size: 14px;
    line-height: 32px;
    color: #555;
    background-color: #fff;
    background-image: none;
    border: 1px solid #cfd9db;
    border-radius: 4px;
 }
 
 .form-title {
    color: #6d747b;
    padding: 5px 15px;
    line-height: 16px;
    font-size: 24px;
    border-left: 0px solid #ffa200;
    overflow: hidden;
    margin: 21px 0;
}

.form-content.double {
    width: 50%;
}
.form-content {
    padding: 10px 0;
}
.fn-left {
    float: left;
}
.fn-left {
    float: left;
}
.fn-left, .fn-right {
    display: inline;
}

.form-table li {
    padding: 5px 0;
}

.form-btn{
	left:20px;
}
.form-btn .btn {
    line-height: 38px;
    padding: 0 18px;
    background-color: #1E9FFF;
    color: #fff;
    white-space: nowrap;
    text-align: center;
    font-size: 14px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    margin-left: 40%;
    margin-top: 10px;
}
</style>


<div class="data-list">
	<div class="banner">
		<span class="base-blue-01 base-search" data-title='公司组织机构'>组织机构</span>
	</div>
    <!--左侧树形结构-->
    <div id="tablelist">
    <table class="tablelist" style="width:300px;float:left;min-width:0px;">
      <tbody>
        <tr>
		  <td>
		  <div class="zTreeDemoBackground left" style="overflow-x:auto;overflow-y:auto;">
			<ul id="treeDemo" class="ztree" style="width:300px; height:400px; display: block;"></ul>
		</div>
		</td>
		  
		</tr>
		
      </tbody>
    </table>
	</div>

	
	<!--表单的标题区域--> 
	<div class="form-title">部门编辑</div>
    <!--表单的选项卡切换-->
    <form id="editForm" method="post" action="${ctx}/sys/departmentSave">
    
    <div style="display:none;">
    	<input type="hidden" id="deptId" name="deptId" value="${sysDepartment.deptId}"/>
    	<input type="hidden" id="deptState" name="deptState" value="${sysDepartment.deptState}"/>	
    	<input type="hidden" id="createTime" name="createTime" value="${sysDepartment.createTime}"/>	
    	<input type="hidden" id="userAcctId" name="userAcctId" value="${sysDepartment.userAcctId}"/>	
    	<input type="hidden" id="setId" name="setId" value="${sysDepartment.setId}"/>
    	<input type="hidden" id="companyId" name="companyId" value="${companyId}"/>
    </div>
    
    <!--表单的主内容区域-->
    <div class="form-content double fn-left">
        <ul class="form-table">
        	 <li>部门名称</li>
            <li>
            	<input type="text" disabled="disabled" class="input" id="regionName1" name="deptName1" value="${sysDepartment.deptName}"  />
            	 <input type="hidden" class="input" id="regionName" name="deptName" value="${sysDepartment.deptName}"  />
            	<input type="hidden" id="oldDeptName" name="oldDeptName" value="${sysDepartment.deptName}"  />
            	<i class="form-icon-clear"></i>
            </li>
            <li>部门编码</li>
            <li>
            	<input type="text" disabled="disabled" class="input regionCode" id="regionCode1" name="deptCode1" value="${sysDepartment.deptCode}" />
            	<input type="hidden" class="input regionCode" id="regionCode" name="deptCode" value="${sysDepartment.deptCode}" />
            	<i class="form-icon-clear"></i>
            </li> 
            <li>部门排序</li>
            <li>
            	<input type="text" class="input deptSeq"id="deptSeq"  name="deptSeq" value="${sysDepartment.deptSeq}" />
            	<i class="form-icon-clear"></i>
            </li> 
            <li>上级部门</li>
            <li>
            	<input disabled="disabled" type="text" class="input parentDeptName" id="parentDeptName" name="parentDeptName" value="${sysDepartment.parentDepartment.deptName}" />
            	<i class="form-icon-clear"></i>
            	<input type="hidden" id="parentDeptCode" name="parentDeptCode"  value="${sysDepartment.parentDeptCode}"/>
            </li>
        </ul>
        
        <div style="clear:both;"></div>
    	<!--表单的按钮组区域-->
    	<div class="form-btn">
    		<input type="submit" id="submit-btn" value="保存" class="btn green"/>
    	</div>
    </div>
    
    </form>
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
//表单校验
var deptNameInput=$("#deptName").val();
var deptCode=$("#regionCode").val();
RGparam = '${companyId}';
console.log("RGparam",RGparam);
 $("#editForm").validate({
    rules: {
	   deptName: {
	    required: true,
	    maxlength: 32,
	    uniqueDeptName:true,
	    stringCheck:deptNameInput
	   },
	   deptSeq: {
	    required: true,
	    digits:true,
	    range:[0,999]
	   }
	  },submitHandler:function(form){           
            var deptId=$("#deptId").val();
            if(deptId==''){
            	$.validator.errorShow($("#regionName"),'添加组织请从左侧树添加，此处只用于编辑');
            	return false;
            }else{
				 form.submit();
			}
        } 
    });
      // Ajax重命名校验
	$.uniqueValidate('uniqueDeptName', '${ctx}/sys/department/checkDeptName', ['regionName','oldRoleName','regionCode','companyId'], '对不起，这个部门名称重复了');

});
</script>
