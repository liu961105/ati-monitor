package com.dfmy.controller.sys;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.IncorrectCredentialsException;
import org.apache.shiro.authc.LockedAccountException;
import org.apache.shiro.authc.UsernamePasswordToken;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dfmy.controller.common.BaseController;
import com.dfmy.entity.ResultEntity;
import com.dfmy.entity.basedata.AtiProjectStructure;
import com.dfmy.entity.sys.SysUser;
import com.dfmy.service.basedata.AtiProjectStructureService;
import com.dfmy.service.sys.SysLogService;
import com.dfmy.service.sys.SysUserService;
import com.dfmy.springaop.SystemLog;
import com.dfmy.util.EncryptionUtil;

/**
 * 用户登录管理
 *
 */
@Controller
public class LoginController extends BaseController{
	@Resource
	private SysUserService sysUserService;
	@Resource
	private SysLogService sysLogService;
	@Autowired
	private AtiProjectStructureService atiProjectStructureService;
	/**
	 * 登录
	 * @return
	 */
	@RequestMapping("sysLogin")
	@ResponseBody
	@SystemLog(module="系统管理",methods="日志管理-系统登录")
	public ResultEntity login(SysUser user,HttpServletRequest req,String kaptchaCode ){
		ResultEntity res = new ResultEntity();
		String msg = "";
		Session session = null;
		Subject currentUser = null;
		req.getSession().setAttribute("userName", user.getUserName());
		try{
			String kaptchaExpected = (String)req.getSession().getAttribute(com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY);  
			if(StringUtils.isNotBlank("kaptchaExpected") && !kaptchaExpected.equals(kaptchaCode)){
				res.setMessage("验证码错误");
				res.setSuccess(ERROR);
			}else{
				if(user !=null){
					/*if ("admin".equals(user.getUserName())) {
						res.setMessage("您无权限登录");
						res.setSuccess(ERROR);
					} else {*/
						currentUser = SecurityUtils.getSubject();
						//SecurityUtils.getSubject().getSession().setTimeout(36000000);
						System.out.println(currentUser.getSession().getTimeout());
						UsernamePasswordToken token  = new UsernamePasswordToken(user.getUserName(),EncryptionUtil.Md5Hash(user.getPassword(),"gzgyy"));
						currentUser.login(token);
						session=currentUser.getSession();
						if(session!=null){ 
							res.setData(session);
							res.setMessage("登录成功");
							res.setSuccess(SUCCESS);
						}else{
							res.setMessage("登录失败");
							res.setSuccess(ERROR);
						}
					//}
				}else{
					res.setMessage("登录失败");
					res.setSuccess(ERROR);
				}
			}
			
		}catch(LockedAccountException e){
			msg = e.getMessage();
			res.setMessage("此账号已锁定，请联系管理员。");
			res.setSuccess(ERROR);
		}catch(IncorrectCredentialsException e){
			e.printStackTrace();
			msg = e.getMessage();
			res.setMessage("用户名或密码错误");
			res.setSuccess(ERROR);
		}catch(Exception e){
			msg = e.getMessage();
			e.printStackTrace();
			res.setMessage("登录失败，请联系管理员。");
			res.setSuccess(ERROR);
		}
		return res;
	}
	
	@RequestMapping("unauthorized")
	public String unauthorized(){
		return "unauthorized";
	}
	
	/**
	 * 退出登录
	 * @return
	 */
	@RequestMapping("logout")
	@ResponseBody
	public ResultEntity logout(){
		ResultEntity res = new ResultEntity();
		try{
			Subject currentUser = SecurityUtils.getSubject();
			currentUser.logout();
			res.setMessage(OPERATE_SUCCESS);
			res.setSuccess(SUCCESS);
		}catch(Exception e){
			res.setMessage(OPERATE_ERROR);
			res.setSuccess(ERROR);
		}
		return res;
	}
	
	@RequestMapping("login")
	public String login(){
		return "login";
	}
	
	/**
	 * 登录成功进入主页
	 * @return
	 */
	@RequestMapping("sysIndex")
	public String index(String strucType,String strucTypeName,Model model){
		Subject currentUser = SecurityUtils.getSubject();
		try{
			String structureId = "";
			model.addAttribute("strucTypeCode", strucType);
			model.addAttribute("strucTypeName", strucTypeName);
			AtiProjectStructure structure = atiProjectStructureService.findByCode(strucType);
			if (structure !=null) {
				structureId = structure.getId();
			}
			model.addAttribute("structureId", structureId);	
			if(StringUtils.isNotBlank((String)currentUser.getPrincipal())){
				model.addAttribute("crruser","newuser");
				if (StringUtils.isNotBlank(strucType)) {
					return "manage/base_top";
				} else {
					return "manage/nav_index";
				}
			}else{
				return "redirect:login";
			}
		}catch(Exception e){
			return "manage/index";
		}
	}
	
	/**
	 * 
	 * @return
	 */
	@RequestMapping("getUserInfo")
	@ResponseBody
	public ResultEntity getUser(HttpServletRequest req){
		ResultEntity res = new ResultEntity();
		try{
			Subject currentUser = SecurityUtils.getSubject();
			String userName = (String)currentUser.getPrincipal();
			SysUser sysUser = sysUserService.findByUserName(userName);
			req.getSession().setAttribute("userCode", sysUser.getUserId());
			res.setData(sysUser);
			res.setMessage(OPERATE_SUCCESS);
			res.setSuccess(SUCCESS);
		}catch(Exception e){
			res.setMessage(OPERATE_ERROR);
			res.setSuccess(ERROR);
		}
		return res;
	}
}
