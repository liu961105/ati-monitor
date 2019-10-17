<%@ page language="java" pageEncoding="UTF-8" %>
<%@include file="/WEB-INF/views/public/taglib.jspf" %>
<!-- 列表界面 -->
<div id="data-list">
    <div class="banner layui-hide">
        <span class="base-blue-01 base-search" data-title='用户列表'>用户列表查询</span>
    </div>
    <!-- <div class="base-form">
        <form id="fa-search">
            <table class="base-table form search">
                <tr>
                    <td class="td-bg" width="150">工号或姓名</td>
                    <td class="left padding-l">
                        <input	class="base-input" name="userName" id="userName">
                    </td>
                    <td class="td-bg" width="150">部门</td>
                    <td class="left padding-l">
                        <select class="base-select sysDeptIds"  name="selDeptId" id="selDeptId">
                            <option value="">请选择部门</option>
                        </select>
                    </td>
                    <td class="td-bg" width="150">岗位</td>
                    <td class="left padding-l">
                        <select class="base-select postId"  name="selPostId" id="selPostId">
                            <option value="">请选择岗位</option>
                        </select>
                    </td>
                    <td class="center" rowspan="1" width="150">
                        <button id="btn_search" type="button" class="base-btn base-bg-green" data-toggle="modal">查询</button>
                    </td>
                </tr>
            </table>
        </form>
    </div> -->
    <div class="banner">
        <span class="base-blue-01 base-search" style="float: left;">用户列表</span>
        <%--

        <div class="label layui-col-md1" style="width:4%">
                <form action="${ctx}/sysUser/exportExcel" method="post" id="exportUser">
                     <shiro:hasPermission name="sysUser:exportUser">
                     <button class="layui-btn layui-btn-sm"  onclick="return exportExcel();" style="margin-left: 10px;">导出</button>
                     </shiro:hasPermission>
                    <input type="hidden" id="exportUserId" name="userId">
                    <input type="hidden" id="exportProductNum" name="productNum">
                </form>
        </div>

        <div class="layui-col-md3">
                <form class="form-x"  method="post"  enctype="multipart/form-data" id="uploadform" >
                    <div class="layui-upload">
                     <shiro:hasPermission name="sysUser:importUser">
                     <a href="${ctx}/res/commfile/newUser.xls" style="background-color: #88786a;" class="layui-btn layui-btn-normal layui-btn-sm">模版下载</a>
                     <button type="button" class="layui-btn layui-btn-normal layui-btn-sm" style="margin-left: 0px;"   id="test8">选择文件</button>
                     <button type="button" class="layui-btn layui-btn-sm"   id="test9">开始导入</button>
                     </shiro:hasPermission>
                    </div>
                </form>
        </div> --%>
    </div>

    <form id="fa-search" class="layui-form-pane" style="margin-top: 15px;">
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">工号或姓名</label>
                <div class="layui-input-inline">
                    <input type="text" name="userName" id="userName" autocomplete="off" class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">部门</label>
                <div class="layui-input-inline">
                    <select class="base-select sysDeptIds" name="selDeptId" id="selDeptId">
                        <option value="">请选择部门</option>
                    </select>
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">岗位</label>
                <div class="layui-input-inline">
                    <select class="base-select postId" name="selPostId" id="selPostId">
                        <option value="">请选择岗位</option>
                    </select>
                </div>
            </div>

            <div class="layui-inline">
                <button id="btn_search" type="button" class="layui-btn layui-btn-normal" data-toggle="modal"><i
                        class="layui-icon layui-icon-search layuiadmin-button-btn"></i></button>
            </div>
            <div class="layui-inline layui-inline-right">
                <shiro:hasPermission name="sysUser:saveUser">
                    <button id="btn_add" type="button" class="layui-btn" data-toggle="modal">新增</button>
                </shiro:hasPermission>
                <shiro:hasPermission name="sysUser:delUser">
                    <button id="btn_del" type="button" class="layui-btn layui-btn-danger" data-toggle="modal"
                            style="margin-left: 0;">删除
                    </button>
                </shiro:hasPermission>
            </div>
        </div>
        <!-- 勿删，以下模块为对于员工的批量导入和导出 -->
        <%-- <div class="layui-row" style="margin-bottom: 10px;">
            <div class="layui-col-md12" style="text-align: right;">
                <div class="layui-inline">
                    <form class="form-x"  method="post"  enctype="multipart/form-data" id="uploadform" >
                        <div class="layui-upload">
                         <shiro:hasPermission name="sysUser:importUser">
                         <a href="${ctx}/res/commfile/newUser.xls" style="background-color: #88786a;" class="layui-btn layui-btn-normal">模版下载</a>
                         <button type="button" class="layui-btn layui-btn-normal" style="margin-left: 0px;"   id="test8">选择文件</button>
                         <button type="button" class="layui-btn" id="test9">开始导入</button>
                         </shiro:hasPermission>
                        </div>
                    </form>
                </div>
                <div class="layui-inline">
                    <form action="${ctx}/sysUser/exportExcel" method="post" id="exportUser">
                         <shiro:hasPermission name="sysUser:exportUser">
                         <button class="layui-btn"  onclick="return exportExcel();">导出</button>
                         </shiro:hasPermission>
                        <input type="hidden" id="exportUserId" name="userId">
                        <input type="hidden" id="exportProductNum" name="productNum">
                    </form>
                </div>
                <div class="layui-inline">
                      <shiro:hasPermission name="sysUser:saveUser">
                        <button id="btn_add" type="button" class="layui-btn" data-toggle="modal">新增</button>
                    </shiro:hasPermission>
                    <shiro:hasPermission name="sysUser:delUser">
                        <button id="btn_del" type="button" class="layui-btn layui-btn-danger" data-toggle="modal" style="margin-left: 0;">删除</button>
                    </shiro:hasPermission>
                </div>
            </div>
        </div> --%>
    </form>

    <div id="list">
        <table class="layui-table">
            <colgroup>
                <col width="50">
                <col width="60">
                <col width="130">
                <col width="130">
                <col width="60">
                <col width="150">
                <col width="150">
                <col width="150">
                <col width="150">
                <col width="150">
            </colgroup>
            <thead>
            <tr>
                <th>
                    <div class="label"><input id="checkAll" type="checkbox" class="check_btn"><label
                            class="checkboxLable" for="checkAll"></label></div>
                </th>
                <th>序号</th>
                <th>登录用户名</th>
                <th>真实姓名</th>
                <th>性别</th>
                <th>手机号</th>
                <th>岗位</th>
                <th>所属部门</th>
                <th>拥有角色</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody id="datalist"></tbody>
        </table>
    </div>
</div>
<!-- end列表界面 -->

<!-- 新增与详情页面 -->
<div id="data-form" class="data-form" data-title='新增用户'>
    <form id="form" class="layui-form-pane userSaveForm" enctype="multipart/form-data">
        <input type='hidden' name='userId'>
        <div class="layui-row">
            <div class="layui-col-md4">
                <div class="layui-form-item">
                    <label class="layui-form-label">登录用户名</label>
                    <div class="layui-input-block">
                        <input name="userName" class="layui-input validate require ide">
                    </div>
                </div>
            </div>
            <div class="layui-col-md4">
                <div class="layui-form-item">
                    <label class="layui-form-label">真实姓名</label>
                    <div class="layui-input-block">
                        <input name="rolename" class="layui-input validate require">
                    </div>
                </div>
            </div>
            <div class="layui-col-md4">
                <div class="layui-form-item">
                    <label class="layui-form-label">性别</label>
                    <div class="layui-input-block">
                        <select class="base-select validate require" name="sex">
                            <option value="男">男</option>
                            <option value="女">女</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>
        <div class="layui-row">
            <div class="layui-col-md4">
                <div class="layui-form-item">
                    <label class="layui-form-label">出生日期</label>
                    <div class="layui-input-block">
                        <input name="brithday" class="layui-input validate"
                               onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})">
                    </div>
                </div>
            </div>
            <div class="layui-col-md4">
                <div class="layui-form-item">
                    <label class="layui-form-label">名族</label>
                    <div class="layui-input-block">
                        <input name="minority" class="layui-input validate require">
                    </div>
                </div>
            </div>
            <div class="layui-col-md4">
                <div class="layui-form-item">
                    <label class="layui-form-label">身份证号码</label>
                    <div class="layui-input-block">
                        <input name="idcardno" class="layui-input validate">
                    </div>
                </div>
            </div>
        </div>
        <div class="layui-row">
            <div class="layui-col-md4">
                <div class="layui-form-item">
                    <label class="layui-form-label">户籍地址</label>
                    <div class="layui-input-block">
                        <input name="domicile" class="layui-input validate">
                    </div>
                </div>
            </div>
            <div class="layui-col-md4">
                <div class="layui-form-item">
                    <label class="layui-form-label">手机号码</label>
                    <div class="layui-input-block">
                        <input name="phoneNum" class="layui-input validate require">
                    </div>
                </div>
            </div>
            <div class="layui-col-md4">
                <div class="layui-form-item">
                    <label class="layui-form-label">婚姻状况</label>
                    <div class="layui-input-block">
                        <select class="base-select" name="marStatus">
                            <option value="">请选择</option>
                            <option value="未婚">未婚</option>
                            <option value="已婚">已婚</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>
        <div class="layui-row">
            <div class="layui-col-md4">
                <div class="layui-form-item">
                    <label class="layui-form-label">政治面貌</label>
                    <div class="layui-input-block">
                        <input name="isMember" class="layui-input validate">
                    </div>
                </div>
            </div>
            <div class="layui-col-md4">
                <div class="layui-form-item">
                    <label class="layui-form-label">拥有角色</label>
                    <div class="layui-input-block">
                        <select class="base-select validate require" name="roleIds" id="roleIds">
                            <option value="">请选择</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="layui-col-md4">
                <div class="layui-form-item">
                    <label class="layui-form-label">邮箱</label>
                    <div class="layui-input-block">
                        <input name="email" class="layui-input validate">
                    </div>
                </div>
            </div>
        </div>
        <div class="layui-row">
            <div class="layui-col-md4">
                <div class="layui-form-item">
                    <label class="layui-form-label">毕业院校</label>
                    <div class="layui-input-block">
                        <input name="graduateSchool" class="layui-input validate">
                    </div>
                </div>
            </div>
            <div class="layui-col-md4">
                <div class="layui-form-item">
                    <label class="layui-form-label">毕业时间</label>
                    <div class="layui-input-block">
                        <input name="graduateTime" class="layui-input validate"
                               onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})">
                    </div>
                </div>
            </div>
            <div class="layui-col-md4">
                <div class="layui-form-item">
                    <label class="layui-form-label">学历</label>
                    <div class="layui-input-block">
                        <select class="base-select" name="education">
                            <option value="">请选择</option>
                            <option value="小学">小学</option>
                            <option value="初中">初中</option>
                            <option value="高中">高中</option>
                            <option value="中专">中专</option>
                            <option value="大专">大专</option>
                            <option value="本科">本科</option>
                            <option value="硕士">硕士</option>
                            <option value="博士">博士</option>
                            <option value="博士后">博士后</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>
        <div class="layui-row">
            <div class="layui-col-md4">
                <div class="layui-form-item">
                    <label class="layui-form-label">紧急联系人</label>
                    <div class="layui-input-block">
                        <input name="linkman" class="layui-input validate">
                    </div>
                </div>
            </div>
            <div class="layui-col-md4">
                <div class="layui-form-item">
                    <label class="layui-form-label">关系</label>
                    <div class="layui-input-block">
                        <input name="linkmanRtp" class="layui-input validate">
                    </div>
                </div>
            </div>
            <div class="layui-col-md4">
                <div class="layui-form-item">
                    <label class="layui-form-label">联系人电话</label>
                    <div class="layui-input-block">
                        <input name="linkmanPhone" class="layui-input validate">
                    </div>
                </div>
            </div>
        </div>
        <div class="layui-row">

            <div class="layui-col-md4">
                <div class="layui-form-item">
                    <label class="layui-form-label">所属部门</label>
                    <div class="layui-input-block">
                        <select class="base-select sysDeptIds" name="sysDeptIds" id="sysDeptIds">
                            <option value="">请选择</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="layui-col-md4">
                <div class="layui-form-item">
                    <label class="layui-form-label">岗位</label>
                    <div class="layui-input-block">
                        <select class="base-select postId" name="postId" id="postId">
                            <option value="">请选择</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="layui-col-md4">
                <div class="layui-form-item">
                    <label class="layui-form-label">入职日期</label>
                    <div class="layui-input-block">
                        <input name="joindate" class="layui-input validate"
                               onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})">
                    </div>
                </div>
            </div>
        </div>
        <div class="layui-row">
            <div class="layui-col-md4">
                <div class="layui-form-item">
                    <label class="layui-form-label">qq号码</label>
                    <div class="layui-input-block">
                        <input name="qqNo" class="layui-input validate">
                    </div>
                </div>
            </div>
            <div class="layui-col-md4">
                <div class="layui-form-item">
                    <label class="layui-form-label">单位名称</label>
                    <div class="layui-input-block">
                        <input name="companyName" class="layui-input validate">
                    </div>
                </div>
            </div>
        </div>
        <!-- <div class="layui-row">
             <div class="layui-col-md6">
                 <div class="layui-form-item">
                     <label class="layui-form-label">用户头像</label>
                     <div class="layui-input-block">
                         <div id="userimg-warp" style="display: flex;justify-content: space-around;">
                             <div class="img-box"><img id="userImgUrl" alt="" src="" style="width: 110px;height: 100px;"></div>
                             <div class="path-box" >
                                   <input style="margin-top: 70px" id="userImgPath" name="userImgPath" class="base-input" type="file" " >
                                   <input id="userImgNotChangePath" name="userImgNotChangePath" class="base-input" type='hidden'>
                             </div>
                         </div>
                     </div>
                    </div>
             </div>
        </div> -->
    </form>
    <%-- <form id="form" class="userSaveForm" enctype="multipart/form-data">
        <table class="base-table form">
            <input type='hidden' name='userId'>

            <tr>
                <td class="td-bg" width="150">工号</td>
                <td class="left"><input  name="userName" class="base-input validate require ide"></td>

                <td width="150">姓名</td>
                <td class="left"><input name="rolename" class="base-input validate require"></td>
            </tr>


            <tr>
                <td class="td-bg" width="150">所属部门</td>
                <td class="padding-l"><select class="base-select sysDeptIds"  name="sysDeptIds" id="sysDeptIds">
                <option value="">请选择</option>
                </select></td>
                <td class="td-bg" width="150">岗位</td>
                <td class="padding-l"><select class="base-select postId"  name="postId" id="postId">
                <option value="">请选择</option>
                </select></td>
            </tr>


            <tr>
                <td class="td-bg" width="150">性别</td>
                <td class="left">
                     <select class="base-select validate require"  name="sex">
                     <option value="">请选择</option>
                        <option value="男">男</option>
                        <option value="女">女</option>
                    </select>
                </td>
                <td class="td-bg" width="150">出生日期</td>
                <td class="left"><input name="brithday" class="base-input base-date validate require" onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})"></td>
            </tr>

            <tr>
                <td class="td-bg" width="150">毕业院校</td>
                <td class="left"><input  name="graduateSchool"
                    class="base-input  require"></td>
                <td width="150">专业</td>
                <td><input type="text" name="major"
                    class="base-input validate"></td>
            </tr>
            <tr>
                <td class="td-bg" width="150">毕业时间</td>
                <td class="left"><input  name="graduateTime"
                    class="base-input base-date" onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})"></td>
                <td width="150">学历</td>
                <td>
                    <select class="base-select"  name="education">
                         <option value="">请选择</option>
                         <option value="小学">小学</option>
                         <option value="初中">初中</option>
                         <option value="高中">高中</option>
                         <option value="中专">中专</option>
                         <option value="大专">大专</option>
                         <option value="本科">本科</option>
                         <option value="硕士">硕士</option>
                         <option value="博士">博士</option>
                         <option value="博士后">博士后</option>
                    </select>
                </td>
            </tr>

            <tr>
                <td class="td-bg" width="150">是否实习学生</td>
                <td class="left">
                    <select class="base-select"  name="isStudent">
                    <option value="">请选择</option>
                        <option value="否">否</option>
                        <option value="是">是</option>
                    </select>
                </td>
                <td width="150">就读形式</td>
                <td>
                    <select class="base-select"  name="eduMode">
                    <option value="">请选择</option>
                        <option value="全日制">全日制</option>
                        <option value="网教">网教</option>
                        <option value="自学考试">自学考试</option>
                        <option value="网络教育">网络教育</option>
                        <option value="自考">自考</option>
                        <option value="函授">函授</option>
                        <option value="短期培训">短期培训</option>
                    </select>
                </td>
            </tr>

            <tr>
                <td class="td-bg" width="150">婚姻状况</td>
                <td class="left">
                    <select class="base-select"  name="marStatus">
                    <option value="">请选择</option>
                        <option value="未婚">未婚</option>
                        <option value="已婚">已婚</option>
                    </select>
                </td>
                <td width="150">生育情况</td>
                <td>
                    <select class="base-select"  name="fetStatus">
                        <option value="">请选择</option>
                        <option value="一孩">二孩</option>
                        <option value="二孩">二孩</option>
                        <option value="三孩">三孩</option>
                    </select>
                </td>
            </tr>

            <tr>
                <td class="td-bg" width="150">名族</td>
                <td><input type="text" name="minority" class="base-input validate require" ></td>
                <td class="td-bg" width="150">身份证号码</td>
                <td class="left"><input  name="idcardno" class="base-input  validate require vsfz"></td>
            </tr>
            <tr>
                <td class="td-bg" width="150">户口所在地</td>
                <td><input type="text" name="domicile" class="base-input validate require" ></td>
                <td class="td-bg" width="150">户别</td>
                <td class="left"><input  name="dmcType" class="base-input  validate require"></td>
            </tr>

            <tr>
                <td width="150">员工状态 </td>
                <td>
                    <select class="base-select"  name="jobstatus">
                    <option value="">请选择</option>
                        <option value="在职">在职</option>
                        <option value="劳务">劳务</option>
                    </select>
                </td>
                <td class="td-bg" width="150">手机号码</td>
                <td><input type="text" name="phoneNum" class="base-input validate require vsjh"></td>
            </tr>

            <tr>
                <td class="td-bg" width="150">转正情况</td>
                <td class="left"><select class="base-select"  name="isRegular">
                <option value="">请选择</option>
                        <option value="已转正">已转正</option>
                        <option value="未转正">未转正</option>
                    </select></td>
                <td width="150">转正日期</td>
                <td><input type="text" name="regularDate"
                    class="base-input base-date" onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})"></td>
            </tr>

            <tr>
                <td class="td-bg" width="150">鞋码</td>
                <td class="left"><input  name="shoeSize"
                    class="base-input  require"></td>
                <td width="150">入职日期</td>
                <td><input type="text" name="joindate"
                    class="base-input base-date" onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})"></td>
            </tr>

            <tr>
                <td class="td-bg" width="150">工序</td>
                <td class="left"><input  name="prcdure"
                    class="base-input"></td>
                <td class="td-bg" width="150">合同类型</td>
                <td class="left">
                        <select class="base-select"  name="signcontractNum">
                        <option value="">请选择</option>
                        <option value="新">新</option>
                        <option value="实习">实习</option>
                        <option value="续">续</option>
                        <option value="深圳签">深圳签</option>
                        <option value="劳">劳</option>
                        <option value="深圳">深圳</option>
                        <option value="信柏">信柏</option>
                        <option value="已通知深圳签">已通知深圳签</option>
                        <option value="续已请深圳帮签">续已请深圳帮签</option>
                        </select></td>
            </tr>

            <tr>
                <td class="td-bg" width="150">劳动合同签订日期</td>
                <td class="left"><input  name="contractSigningDate"
                    class="base-input base-date validate require" onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})"></td>
                <td width="150">劳动合同到期时间</td>
                <td><input type="text" name="contractExpirationDate"
                    class="base-input base-date validate require" onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})"></td>
            </tr>


            <tr>
                <td class="td-bg" width="150">社保</td>
                <td class="left">
                    <input  name="isSocialsecurity"
                    class="base-input  require"></td>
                <td width="150">公积金</td>
                <td>
                    <input  name="isAccumulationfund"
                    class="base-input  require"></td>
            </tr>

            <tr>
                <td class="td-bg" width="150">社保备注</td>
                <td class="left"><input  name="sosRemark"
                    class="base-input  require"></td>
                <td width="150">社会工龄入职日期</td>
                <td><input type="text" name="sosJobdate"
                    class="base-input base-date" onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})"></td>
            </tr>


            <tr>
                <td class="td-bg" width="150">紧急联系人</td>
                <td class="left">
                    <input  name="linkman"
                    class="base-input  validate require"></td>
                <td width="150">关系</td>
                <td>
                    <input  name="linkmanRtp"
                    class="base-input  validate require "></td>
            </tr>


            <tr>
                <td class="td-bg" width="150">紧急联系人电话</td>
                <td><input type="text" name="linkmanPhone" class="base-input validate require vsjh"></td>
                <td class="td-bg" width="150">介绍人</td>
                <td class="left"><input name="introducer" class="base-input"></td>
            </tr>

            <tr>
                <td class="td-bg" width="150">是否党员</td>
                <td class="left">
                    <select class="base-select validate require"  name="isCommunist">
                    <option value="">请选择</option>
                        <option value="否">否</option>
                        <option value="是">是</option>
                    </select>
                </td>
                <td width="150">政治面貌</td>
                <td class="left"><input name="isMember" class="base-input"></td>
            </tr>

            <tr>
                <td class="td-bg" width="150">职称</td>
                <td class="left"><input  name="jobtitle"
                    class="base-input"></td>
                <td width="150">离职时间</td>
                <td><input type="text" name="leavingTime"
                    class="base-input base-date" onclick="WdatePicker({skin:'whyGreen',dateFmt:'yyyy-MM-dd'})"></td>
            </tr>

            <tr>
                <td width="150">拥有角色</td>
                <td class="padding-l"><select class="base-select validate require"  name="roleIds" id="roleIds">
                <option value="">请选择</option></select></td>
                <td width="150">是否锁定</td>
                <td>
                    <select class="base-select  validate require"  name="locked">
                        <option value="false">否</option>
                        <option value="true">是</option>
                    </select>
                </td>
            </tr>


            <tr>
                <td width="150">用户图片</td>
                <td><div id="userimg-warp" style="display: flex;justify-content: space-around;">
                    <div class="img-box"><img id="userImgUrl" alt="" src="" style="width: 110px;height: 100px;"></div>
                    <div class="path-box" >
                      <input style="margin-top: 70px" id="userImgPath" name="userImgPath" class="base-input" type="file" " >
                      <input id="userImgNotChangePath" name="userImgNotChangePath" class="base-input" type='hidden'>
                    </div>
                    </div>
                </td>
                <td width="150">技能标签</td>
                <td>
                    <!-- <textarea rows="" cols="" class="base-textarea" name="skill"></textarea>  -->
                    <div id="skill-checkbox" style="margin-left: 4%;width: 80%;">
                      <!-- <label>java</label><input type="checkbox" name="like[java]"  title="java" style="width: 14px;margin-right: 25px;">
                      <label>vue</label><input type="checkbox" name="like[vue]"   title="vue" style="width: 14px;margin-right: 25px;">
                      <label>阅读</label><input type="checkbox" name="like[read]"  title="阅读" style="width: 14px;margin-right: 25px;">
                      <label>复选框</label><input type="checkbox" name="like[read]" title="阅读" style="width: 14px;margin-right: 25px;">
                      <label>复选框</label><input type="checkbox" name="like[read]" title="阅读" style="width: 14px;margin-right: 25px;">
                      <label>复选框</label><input type="checkbox" name="like[read]" title="阅读" style="width: 14px;margin-right: 25px;">
                      <label>复选框</label><input type="checkbox" name="like[read]" title="阅读" style="width: 14px;margin-right: 25px;">
                      <label>复选框</label><input type="checkbox" name="like[read]" title="阅读" style="width: 14px;margin-right: 25px;">
                      <label>复选框</label><input type="checkbox" name="like[read]" title="阅读" style="width: 14px;margin-right: 25px;">
                      <label>复选框</label><input type="checkbox" name="like[read]" title="阅读" style="width: 14px;margin-right: 25px;">  -->
                    </div>
                </td>
            </tr>



            <tr>
                <td class="td-bg" width="150">离职原因</td>
                <td class="left" colspan="3">
                    <textarea rows="" cols="" class="base-textarea" name="leavingReasons"></textarea>
                </td>
            </tr>

            <tr>
                <td class="td-bg" width="150">备注</td>
                <td class="left" colspan="3">
                    <textarea rows="" cols="" class="base-textarea" name="remark"></textarea>
                </td>
            </tr>

            <tr>
                <td class="td-bg" width="150">邮箱</td>
                <td class="left" colspan="3">
                    <input  name="email" class="base-input validate vem"></td>
            </tr>

            <tr>
                <td class="td-bg" width="150"></td>
                <td class="left"></td>
                <td width="150"></td>
                <td></td>
            </tr>
        </table>
    </form> --%>
    <div class="toolbar buttom-btn">
        <button id="btn_back" type="button" class="layui-btn layui-btn-warm" data-toggle="modal">返回</button>
        <button id="btn_save" type="button" class="layui-btn layui-btn-normal" data-toggle="modal">保存</button>
    </div>
</div>
<div id="projectSetPanel" style="display: none">
    <div>
        <ul id="tree" class="ztree" style="position: relative;bottom: 60px;margin-top:60px;height:250px"></ul>
    </div>
    <form id="menuForm">
        <input type="hidden" name="roleId">
        <input type='hidden' name='menuIds'></form>
    <div class="toolbar buttom-btn">
        <button id="btn_cancel" type="button" class="layui-btn layui-btn-warm" data-toggle="modal">取消</button>
        <button id="projectSetSave" type="button" class="layui-btn layui-btn-normal" data-toggle="modal">确定</button>
    </div>
</div>

<script src="${ctx}/res/js/main.js"></script>

<script id="tradecent-template" type="text/x-handlebars-template">
    {{#each this}}
    <tr data-id="{{userId}}">

        <td>
            <div class="label">
                <input id="{{userId}}" name="userItem" value="{{userId}}" type="checkbox" class="check_btn check_item">
                <label class="checkboxLable" for="{{userId}}"></label>
            </div>
        </td>
        <td>
            <div class='base-wrap'>{{addOne @index}}</div>
        </td>
        <td>
            <div class='base-wrap left' title='{{userName}}'>{{userName}}</div>
        </td>
        <td>
            <div class='base-wrap'>{{rolename}}</div>
        </td>
        <td>
            <div class='base-wrap'>{{sex}}</div>
        </td>
        <td>
            <div class='base-wrap'>{{phoneNum}}</div>
        </td>
        <td>
            <div class='base-wrap'>{{postName}}</div>
        </td>
        <td>
            <div class='base-wrap'>{{deptName}}</div>
        </td>
        <td>
            <div class='base-wrap'>{{#each roles}}{{name}}、{{/each}}</div>
        </td>
        <td>
            <shiro:hasPermission name="sysUser:updateUser"><span
                    class="oper-handle iconfont icon-bianji base-yellow update" title='修改用户'
                    data-pkid={{userId}}></span></shiro:hasPermission>
            <shiro:hasPermission name="sysUser:deleteUser"><span
                    class="oper-handle iconfont icon-shanchu base-red delete" title='删除用户'
                    data-pkid={{userId}}></span></shiro:hasPermission>
            <shiro:hasPermission name="sysUser:detailUser"><span
                    class="oper-handle iconfont icon-xiangqing base-blue detail" title='详情'
                    data-pkid={{userId}}></span></shiro:hasPermission>
            <shiro:hasPermission name="sysUser:initPassword"><span class="oper-handle iconfont icon-mima base-blue init"
                                                                   title='初始化密码'
                                                                   data-pkid={{userId}}></span></shiro:hasPermission>

            <shiro:hasPermission name="sysUser:projectSet">
                <span class="oper-handle iconfont icon-shezhi base-blue projectSet" title='配置负责项目'
                      data-pkid={{userId}}></span>
            </shiro:hasPermission>

        </td>
    </tr>
    {{/each}}
</script>

<!-- <script src="http://static.runoob.com/assets/jquery-validation-1.14.0/lib/jquery.js"></script>
<script src="http://static.runoob.com/assets/jquery-validation-1.14.0/dist/jquery.validate.min.js"></script> -->

<!--end新增与详情页面-->
<script type="text/javascript">
    $(function () {

        $.baseEvent({
            ctx: '${ctx}',
            param: ['userName', 'selDeptId', 'selPostId'],
            isPage: true,
            pageList_url: "/sysUser/pageList",
            form_url: '/sysUser/saveUser',
            data_list: '${ctx}/route/manage/sys/sys_userList',
            del_url: '/sysUser/delUser',
            findBy_url: '/sysUser/findUser',
            add_is_dialog: true
        });
        getDept();
        getRole();
        getProdeId();
        //	userFormVD();

        $("#datalist").on('click', '.init', function () {
            var userId = $(this).data('pkid');
            layer.confirm('你确要初始化密码吗？', {
                btn: ['确定', '取消']//按钮
            }, function () {
                var my = {
                    url: "${ctx}/sysUser/getInitPassword",
                    para: {id: userId},
                    callback: function (res) {
                        layer.msg(res.message);
                    }
                }
                $._NormalRequest(my);
            })
        });

        var treeObject = null;
        var deviceId = "";
        var openProjectSetPanel = null;
        var structureId = $("#structureId").val();
        var userId = null;

        $("#datalist").on("click", ".projectSet", function () {
            userId = $(this).data('pkid');
            openProjectSetPanel = layer.open({
                type: 1,
                shade: false,
                title: "<span class='dialog_title base-zb-info'>项目负责授权</span>",
                area: ['40%', '70%'],
                content: $('#projectSetPanel')
            });
            treeObject = $.fn.zTree.init($("#tree"), setting);
            deviceId = $(this).attr("data-pkid");
        })

        //------------------ztree-----------------
        //初始化ztree
        var setting = {
            view: {
                dblClickExpand: false,
                showLine: true,
                selectedMulti: false
            },
            check: {
                enable: true,
                chkStyle: "checkbox", //复选框
                chkboxType: {"Y": "ps", "N": "ps"}
                // chkboxType: { "Y" : "p", "N" : "ps" }
            },
            data: {
                simpleData: {
                    enable: true,
                    idKey: "id",
                    pIdKey: "pid",
                    rootPId: ""
                },
                key: {
                    title: "name",
                    name: "name"
                },
            },
            async: { //ztree异步请求数据
                enable: true,
                dataFilter: ajaxDataFilter, //预处理数据
                url: "${ctx}/atiProject/getProject", //请求action方法
                autoparam: ["data"]
            },
            callback: {
                //onClick : zTreeOnClick,
                // beforeClick: beforeClick,
                onCheck: onCheck,
                onAsyncSuccess: zTreeOnAsyncSuccess
                //异步加载完成调用
            }
        };

        /* 获取返回的数据，进行预操作 */
        function ajaxDataFilter(treeId, parentNode, responseData) {
            responseData = responseData.data;
            return responseData;
        };

        //数据加载完成以后 获取当前设备所有已选择的参数 进行反选
        function zTreeOnAsyncSuccess(event, treeId, msg) {

            treeObject.checkNode(treeId, !treeId.checked, null, true);
            //详情界面
            var my = {
                url: "${ctx}/atiProject/getProjectByManagerId",
                para: {
                    "managerId": userId
                },
                callback: function (res) {
                    res.data.map(function (v, i) {
                        console.log(v)
                        var node = treeObject.getNodeByParam("id", v.id);
                        treeObject.checkNode(node, true, true);
                        treeObject.updateNode(node);
                    })
                }
            }
            $._NormalRequest(my);
        }

        function onCheck(e, treeId, treeNode) {
            var checkedItems = '';
            var zTree = $.fn.zTree.getZTreeObj("tree");
            zTree.getChangeCheckedNodes().map(function (i, v) {
                if (i.isLast == 'true') {
                    checkedItems += i.id + ',';
                }
            });
            if (checkedItems) checkedItems = checkedItems.substr(0, checkedItems.length - 1);
            $("input[name='paramIds']").val(checkedItems);
        }

        $("#projectSetSave").on("click", function () {
            var checkedNodes = treeObject.getCheckedNodes(true);
            var updateNodes = [];
            //只拿到第三个节点
            var paramIds = "";
            for (var i = 0; i < checkedNodes.length; i++) {
                if(checkedNodes[i].isProject == '1'){
                    updateNodes.push(checkedNodes[i]);
                    paramIds += checkedNodes[i].id;
                    if (i <= checkedNodes.length - 1) {
                        paramIds += ",";
                    }
                }
            }
            if (updateNodes.length <= 0) {
                //提示用户要选择节点
                alertError("请选择对应的参数节点");
            } else {
                //准备参数
                //发送请求
                var updateNodesUrl = "${ctx}/atiProject/setProjectManager";
                $.post(updateNodesUrl, {managerId: userId, projects: paramIds}, function (data) {
                    if (data.success == 1) {
                        alertOk("更新成功")
                    } else {
                        alertError("更新失败")
                    }
                    //关闭窗口
                    layer.close(openProjectSetPanel);
                })

            }
        })

        //全选/反选
        $("#checkAll").click(function () {
            $("input[name='userItem']:checkbox").prop("checked", this.checked);
        });

        //批量删除
        $('#btn_del').on('click', function () {

            var ids = [];
            $("input[name='userItem']:checked").each(function () {
                ids.push($(this).attr("id"));
            });
            var userId = "";
            if (ids.length > 0) {
                userId = ids.join(",");
                layer.confirm('你确要删除该数据吗？', {
                    btn: ['确定', '取消']//按钮
                }, function () {
                    $.ajax({
                        url: '${ctx}/sysUser/delUser',
                        data: {ID: userId},
                        dataType: 'json',
                        success: function (res) {
                            if (res.success == '1') {
                                showOkTip("删除成功");
                                $('#btn_search').click();
                            }
                        },
                    });
                });
            } else {
                alertWarn("请选择要删除的数据！");
            }

        });

    });

    //查找角色
    function getRole() {
        var my = {
            url: "${ctx}/sysRole/queryAll",
            callback: function (res) {
                for (var i = 0; i < res.data.length; i++) {
                    $("#roleIds").append(
                        "<option value='" + res.data[i].roleId + "'>"
                        + res.data[i].name + "</option>");
                }
            }
        }
        $._NormalRequest(my);
    }

    //查找部门
    function getDept() {
        var my = {
            url: "${ctx}/sysDept/findTopList",
            callback: function (res) {
                for (var i = 0; i < res.data.length; i++) {
                    $(".sysDeptIds").append(
                        "<option value='" + res.data[i].deptId + "'>"
                        + res.data[i].name + "</option>");
                }
            }
        }
        $._NormalRequest(my);
    }

    //查找岗位
    function getProdeId() {
        var my = {
            url: "${ctx}/sysProfession/findTopList",
            callback: function (res) {
                for (var i = 0; i < res.data.length; i++) {
                    $(".postId").append(
                        "<option value='" + res.data[i].professionId + "'>"
                        + res.data[i].name + "</option>");
                }
            }
        }
        $._NormalRequest(my);
    }


    //导出用户表格
    function exportExcel() {
        var ids = [];
        $("input[name='userItem']:checked").each(function () {
            ids.push($(this).attr("id"));
        });
        var userId = "";
        if (ids.length > 0) {
            userId = ids.join(",");
        }
        var productNum = $("#productNum").val();
        $("#exportProductNum").val(productNum);
        $("#exportUserId").val(userId);
        $("#exportUser").submit();

    };


    //导入用户数据
    layui.use('upload', function () {
        var $ = layui.jquery, upload = layui.upload;
        upload.render({
            elem: '#test8',
            url: '${ctx}/sysUser/importExport',
            method: "post",
            auto: false,
            bindAction: '#test9',
            accept: 'file',
            exts: 'xls|xlsx',
            done: function (res) {
                console.log(res);
                if (res.success == '1') {
                    showOkTip(res.message);
                } else {
                    alertError(res.message);
                }
            }
        });
    });


</script>
