package com.dfmy.controller.sys;

import java.io.File;
import java.io.OutputStream;
import java.net.SocketException;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.subject.Subject;
import org.jeecgframework.poi.excel.ExcelImportUtil;
import org.jeecgframework.poi.excel.entity.ImportParams;
import org.jeecgframework.poi.excel.entity.result.ExcelImportResult;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.dfmy.controller.common.BaseController;
import com.dfmy.entity.ResultEntity;
import com.dfmy.entity.sys.SysDept;
import com.dfmy.entity.sys.SysProfession;
import com.dfmy.entity.sys.SysRole;
import com.dfmy.entity.sys.SysUser;
import com.dfmy.service.sys.SysDeptService;
import com.dfmy.service.sys.SysLogService;
import com.dfmy.service.sys.SysProfessionService;
import com.dfmy.service.sys.SysUserService;
import com.dfmy.util.EncryptionUtil;
import com.dfmy.util.FileUtil;
import com.dfmy.util.StringHelper;
import com.dfmy.util.TimeHelper;

/**
 * 系统用户管理
 *
 */

@Controller
@RequestMapping("sysUser")
public class SysUserController extends BaseController {
	@Resource
	private SysUserService sysUserService;
	
	@Resource
	private SysProfessionService prodesv;
	
	@Resource
	private SysDeptService deptsv;
	
	@Resource
	private SysLogService sysLogService;
	//private BaseInfoService baseInfoService;
	
	/**
	 * 分页用户列表
	 * 
	 * @return
	 */
	@RequiresPermissions("sysUser:pageList")
	@RequestMapping("pageList")
	@ResponseBody
	private ResultEntity pageList(@RequestParam(value = "pageCurrent", defaultValue = "1") String pageCurrent,SysUser user,String selDeptId,String selPostId) {
		ResultEntity res = new ResultEntity();
		try {
			Page<SysUser> userPage = sysUserService.pageList(Integer.parseInt(pageCurrent), PAGESIZE, "createtime",user,selDeptId,selPostId);
			if (userPage.getTotalPages() > 0) {
				res.setData(userPage);
				res.setMessage(GET_SUCCESS);
				res.setSuccess(SUCCESS);
			} else {
				res.setMessage(IS_NULL);
				res.setSuccess(NULL);
			}
		} catch(SocketException e){
			e.printStackTrace();
			res.setMessage("网络异常:"+e.getMessage());
			res.setSuccess(ERROR);
		}catch (Exception e) {
			e.printStackTrace();
			res.setMessage(GET_ERROR + ":" + e.getMessage());
			res.setSuccess(ERROR);
		}
		return res;
	}
	
	/**
	 * 保存用户
	 * @param user
	 * @return
	 */
	@RequestMapping("saveUser")
	@ResponseBody
	public ResultEntity saveUser(SysUser user,String roleIds,String sysDeptIds,String userImgNotChangePath,HttpServletRequest req){
		ResultEntity res = new ResultEntity();
		Subject currentUser = SecurityUtils.getSubject();
		String msg = "";
		try {
				if(!StringUtils.isNoneBlank(user.getUserId())){
					SysUser checkUser = sysUserService.findByUserName(user.getUserName());
					if(checkUser!=null){
						res.setMessage("此用户已存在，不能重复添加。");
						res.setSuccess(ERROR);
						return res;
					}
					
				}
				
				if(StringUtils.isNotBlank(userImgNotChangePath)){
					user.setUserImg(userImgNotChangePath);
				}

				
				if(StringUtils.isNotBlank(roleIds)){
					//设置角色
					String[] arryRole = roleIds.split(",");
					List<SysRole> rs = new ArrayList<SysRole>();
					for(String roleId:arryRole){
						SysRole role = new SysRole();
						role.setRoleId(roleId);
						rs.add(role);
					}
					user.setRoles(rs);
				}
				if(StringUtils.isNotEmpty(sysDeptIds)){
					//设置部门
					SysDept dept = deptsv.findDept(sysDeptIds);
					dept.setDeptId(sysDeptIds);
					user.setSysDept(dept);
					user.setDeptName(dept.getName());
				}
				
				if(StringUtils.isNotEmpty(user.getPostId())){
					//设置岗位
					SysProfession prode = prodesv.findProfession(user.getPostId());
					String postNameString=prode.getName();
					user.setPostName(postNameString);
				}
				
				
				if(StringUtils.isNotBlank(user.getUserId())){
					user.setUpdatetime(TimeHelper.getCurrentTime());
					user.setUpdateuser((String)currentUser.getPrincipal());
					
				}else{
					user.setCreatetime(TimeHelper.getCurrentTime());
					user.setCreateuser((String)currentUser.getPrincipal());
				}
				user.setIsVisual("1");
				//用户密码不可逆加密
				user.setPassword(EncryptionUtil.Md5Hash("111111", "gzgyy"));
				//用户密码不可逆加密
				//user.setPassword(EncryptionUtil.Md5Hash(user.getPassword(), "gzgyy"));
				//保存用户
				sysUserService.saveUser(user);
				res.setMessage(OPERATE_SUCCESS);
				res.setSuccess(SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			msg = e.getMessage();
			res.setMessage(OPERATE_ERROR + ":" + msg);
			res.setSuccess(ERROR);
		}
		return res;
	}
	
	
	/**
	 * 删除用户
	 * @param user
	 * @return
	 */
	@RequestMapping("delUser")
	@ResponseBody
	public ResultEntity delUser(String ID){
		ResultEntity res = new ResultEntity();
		SysUser sysUser = null;
		String msg = "";
		try {
			String[] ids = ID.split(",");
			for (int i = 0; i < ids.length; i++) {
				sysUser = sysUserService.findUser(ID);
				if(sysUser != null){
					sysUserService.deleteUser(ids[i]);
				}
			}
			res.setMessage(DELETE_SUCCESS);
			res.setSuccess(SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			msg = e.getMessage();
			res.setMessage(DELETE_ERROR + ":" +msg);
			res.setSuccess(ERROR);
		} 
		return res;
	}
	
	/**
	 * 查询单个用户
	 * @param user
	 * @return
	 */
	@RequestMapping("findUser")
	@ResponseBody
	public ResultEntity findUser(String ID){
		ResultEntity res = new ResultEntity();
		try {
			res.setData(sysUserService.findUser(ID));
			res.setMessage(GET_SUCCESS);
			res.setSuccess(SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			res.setMessage(GET_ERROR + ":" + e.getMessage());
			res.setSuccess(ERROR);
		}
		return res;
	}

	/**
	 * 查询单个用户
	 * @param user
	 * @return
	 */
	@RequestMapping("findCurrentUser")
	@ResponseBody
	public ResultEntity findUser(){
		ResultEntity res = new ResultEntity();
		try {
			Subject subject = SecurityUtils.getSubject();
			res.setData(sysUserService.findByUserName(subject.getPrincipal().toString()));
			res.setMessage(GET_SUCCESS);
			res.setSuccess(SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			res.setMessage(GET_ERROR + ":" + e.getMessage());
			res.setSuccess(ERROR);
		}
		return res;
	}
	
	
	/**
	 * 根据部门查询用户
	 * @param user
	 * @return
	 */
	@RequestMapping("findUserBydeptId")
	@ResponseBody
	public ResultEntity findUserBydeptId(String ID){
		ResultEntity res = new ResultEntity();
		try {
			res.setData(sysUserService.findUserBydeptId(ID));
			res.setMessage(GET_SUCCESS);
			res.setSuccess(SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			res.setMessage(GET_ERROR + ":" + e.getMessage());
			res.setSuccess(ERROR);
		}
		return res;
	}
	
	
	
	/**
	 * 初始化密码
	 * @param userName
	 * @return
	 */
	@RequestMapping("getInitPassword")
	@ResponseBody
	public ResultEntity getInitPassword(String id){
		ResultEntity res = new ResultEntity();
		try {
			SysUser sysUser = sysUserService.findUser(id);
			sysUser.setPassword(EncryptionUtil.Md5Hash("111111", "gzgyy"));
			sysUserService.saveUser(sysUser);
			res.setData(sysUser);
			res.setMessage("密码初始化成功");
			res.setSuccess(SUCCESS);
		}catch(Exception e){
			e.printStackTrace();
			res.setMessage(DELETE_ERROR + ":" + e.getMessage());
			res.setSuccess(ERROR);
		}
		return res;
	}
	
	/**
	 * 根据用户名查询密码
	 * @param userName
	 * @return
	 */
	@RequestMapping("getUser")
	@ResponseBody
	public ResultEntity getUser(String userName,String password){
		ResultEntity res = new ResultEntity();
		try {
			if(StringUtils.isNotBlank(password)){
				SysUser sysUser = sysUserService.login(userName, EncryptionUtil.Md5Hash(password, "gzgyy"));
				if(sysUser==null){
					res.setMessage(GET_ERROR);
					res.setSuccess(NULL);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			res.setMessage(GET_ERROR + ":" + e.getMessage());
			res.setSuccess(ERROR);
		}
		return res;
	}
	
	/**
	 * 修改密码
	 * @param userName
	 * @return
	 */
	@RequestMapping("/updatePassword")
	@ResponseBody
	public ResultEntity updatePassword(String userName,String password1){
		ResultEntity res = new ResultEntity();
		try {
			SysUser sysUser = sysUserService.findByUserName(userName);
			if(sysUser!=null){
				sysUser.setPassword(EncryptionUtil.Md5Hash(password1, "gzgyy"));
				sysUserService.saveUser(sysUser);
				res.setData(sysUser);
				res.setMessage(UPDATE_SUCCESS);
				res.setSuccess(SUCCESS);
			}else{
				res.setMessage(UPDATE_ERROR);
				res.setSuccess(ERROR);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			res.setMessage(GET_ERROR + ":" + e.getMessage());
			res.setSuccess(ERROR);
		}
		return res;
	}
	
	
	/**
	 * 导出数据表格
	 * @param request
	 * @param response
	 */
	@RequestMapping(value="/exportExcel",method = RequestMethod.POST)
	public void exportExcel(HttpServletRequest request,HttpServletResponse response){
		new ResultEntity();
		List<SysUser> userList = new ArrayList<SysUser>();
		try {
			String userId = request.getParameter("userId");
			String deptid = request.getParameter("productNum");
			if(StringHelper.isNotBlack(userId)){
				String[] userIds = userId.split(",");
				for (int i = 0; i < userIds.length; i++) {
					SysUser user = sysUserService.findUser(userIds[i]);
					userList.add(user);
				}
			}else if(StringHelper.isNotBlack(deptid)){
				userList = (List<SysUser>) sysUserService.findUserBydeptId(deptid);
			}else{
				userList = sysUserService.findAll();
			}
			HSSFWorkbook wb = sysUserService.exportExcel(userList);
			String fileName = "用户表格";
			String fileNames = new String(fileName.getBytes("UTF-8"),"ISO8859-1")+ ".xls";
	        response.setContentType("application/vnd.ms-excel");    
	        response.setHeader("Content-disposition", "attachment;filename="+fileNames);
	        try {
	        	OutputStream ouputStream = response.getOutputStream();
	        	wb.write(ouputStream);
	        	ouputStream.flush(); 
		        ouputStream.close();
	        } catch (Exception e) {
	        	e.printStackTrace();
	        }
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}
	
	
	/**
	 * 导入用户数据
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value="/importExport",method = RequestMethod.POST)
	@ResponseBody
	public ResultEntity importExport(HttpServletRequest request, HttpServletResponse response){
		ResultEntity res = new ResultEntity();
		try {
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
			MultipartFile file = multipartRequest.getFile("file");
			File localfile = null;
			file.getInputStream();
			localfile = new File(file.getName());
			file.transferTo(localfile);
			
			response.setCharacterEncoding("utf-8");  //防止ajax接受到的中文信息乱码  
			ImportParams params = new ImportParams();
			params.setVerifyHanlder(new ExcelVerifyUserMsg());
			ExcelImportResult<UserImport> result = ExcelImportUtil.importExcelVerify(localfile,UserImport.class, params);
			String errorMsg="";//导入表格错误信息
			List<UserImport> userList = result.getList();
			for (int i = 0; i < userList.size(); i++) {
				if(!StringHelper.isNotBlack(userList.get(i).getErrorMsg())){
				
					Subject currentUser = SecurityUtils.getSubject();
					String longinUser = (String) currentUser.getPrincipal();
					UserImport user = userList.get(i);
					
					/*{"序号","工号（必填项）","真实姓名（必填项）","性别（必填项）","手机号码（必填项）","出生日期（必填项）","身份证号（必填项）","紧急联系人（必填项）","岗位（必填项）","入职日期（必填项）",
			        "是否缴纳社保（必填项）","是否缴纳公积金（必填项）","劳动合同签订日期（必填项）","劳动合同到期时间（必填项）","合同签订次数（必填项）",
			        "毕业院校","专业","毕业时间","学历","职称","是否党员（必填项）","是否团员（必填项）",
			        "在岗/离职状态（必填项）","离职原因","离职时间","备注"}*/
					
					//sysUserService.getUserByGh(user.getGh());
					
					if (sysUserService.getUserByGh(user.getGh()) == null) {
						//只导入不存在的用户
						
					SysUser newOrder = new SysUser();
					
					
					newOrder.setUserName(user.getGh());
					newOrder.setRolename(user.getYhm());
					newOrder.setDeptName(user.getBm());
					newOrder.setPrcdure(user.getGx());
					newOrder.setPostName(user.getGw());
					newOrder.setSex(user.getXb());
					newOrder.setBrithday(user.getCsrq());
					
					newOrder.setEducation(user.getXl());
					newOrder.setMajor(user.getZy());
					newOrder.setGraduateSchool(user.getByyx());
					newOrder.setGraduateTime(user.getBysj());
					newOrder.setIsStudent(user.getSxs());
					newOrder.setEduMode(user.getJdxs());
					
					newOrder.setMarStatus(user.getHyzt());
					newOrder.setFetStatus(user.getSyqk());
					newOrder.setMinority(user.getMz());
					newOrder.setIdcardno(user.getSfz());
					newOrder.setDomicile(user.getHkd());
					newOrder.setDmcType(user.getHb());
					
					
					newOrder.setJobstatus(user.getYgzt());
					newOrder.setIsRegular(user.getZzqk());
					newOrder.setRegularDate(user.getZzrq());
					newOrder.setPhoneNum(user.getLxdh());
					newOrder.setShoeSize(user.getXm());
					newOrder.setJoindate(user.getRzsj());

					
					newOrder.setSigncontractNum(user.getHtlx());
					newOrder.setContractSigningDate(user.getHtq());
					newOrder.setContractExpirationDate(user.getHtz());
					newOrder.setIsSocialsecurity(user.getSb());
					newOrder.setIsAccumulationfund(user.getGjj());
					
					
					newOrder.setSosJobdate(user.getShgl());
					newOrder.setLinkman(user.getJjlxr());
					newOrder.setLinkmanRtp(user.getJjlxrgx());
					
					newOrder.setIntroducer(user.getJsr());
					
					
					newOrder.setIsCommunist(user.getSfdy());
					newOrder.setIsMember(user.getZzmm());
					newOrder.setLeavingReasons(user.getLzyy());
					newOrder.setLeavingTime(user.getLzsj());
					newOrder.setRemark(user.getBz());
					
					newOrder.setSosRemark(user.getSbbz()); //社保备注
					newOrder.setLinkmanPhone(user.getLxrdh());//联系人电话
					
					if (StringUtils.isNotEmpty(user.getBm())) {
						//如果部门名称不为空
						if (deptsv.findDeptByName(user.getBm()) != null) {
							//如果有此部门
							SysDept dept=deptsv.findDeptByName(user.getBm());
							newOrder.setSysDept(dept);
						}
					}
					
					if (StringUtils.isNotEmpty(user.getGw())) {
						//如果岗位名称不为空
						if (prodesv.findProfeByName(user.getGw()) != null) {
							  //如果有此岗位
							SysProfession profe=prodesv.findProfeByName(user.getGw());
							newOrder.setPostId(profe.getProfessionId());
						}
					}
					/*user.getBm();
					user.getGw();*/
					
					/*{"序号","工号","姓名","部门","工序","岗位","性别","出生日期","年龄",
					  "学历","专业","毕业学校","毕业时间","是否实习生","就读形式",
					  "婚姻状态","生育情况","名族","身份证","户口所在地","户别",
					  "员工状态","转正情况","转正日期","联系电话","鞋码","入职时间",
					  "合同类型","合同起","合同止","社保","公积金","备注",
					  "社会工龄入职时间","紧急联系人","关系","联系电话","介绍人",
					  "是否党员（必填项）","政治面貌","离职原因","离职时间","备注"
					  }*/
					
					
					newOrder.setCreatetime(TimeHelper.getCurrentTime());
					newOrder.setCreateuser(longinUser);
					newOrder.setUpdatetime(TimeHelper.getCurrentTime());
					newOrder.setUpdateuser(longinUser);
					newOrder.setIsVisual("1");
					
					sysUserService.saveUser(newOrder);
					
					}
					
				}else{
					 errorMsg += "第"+(i+1)+"行错误:"+userList.get(i).getErrorMsg()+"</br>";
				}
			}	
				
			if(StringHelper.isNotBlack(errorMsg)){
				res.setSuccess(ERROR);
				res.setMessage("有部分信息未导入:</br>"+errorMsg);
			}else{
				res.setSuccess(SUCCESS);
				res.setMessage("导入成功！");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			res.setSuccess(ERROR);
			res.setMessage(GET_ERROR + ":" + e.getMessage());
		}
		return res;
		
	}
	
}
