package com.dfmy.controller.index;

import java.net.SocketException;

import javax.annotation.Resource;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;
import org.apache.shiro.subject.Subject;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.dfmy.controller.common.BaseController;
import com.dfmy.entity.ResultEntity;
import com.dfmy.entity.index.IndexRemind;
import com.dfmy.service.index.IndexRemindService;
import com.dfmy.util.TimeHelper;

/**
 * 事务提醒管理
 */

@Controller
@RequestMapping("indexRemind")
public class IndexRemindController extends BaseController {
	@Resource
	private IndexRemindService remindservce;
	
	/**
	 * 分页列表
	 * 
	 * @return
	 */
	//@RequiresPermissions("IndexRemind:pageList")
	@RequestMapping("pageList")
	@ResponseBody
	private ResultEntity pageList(@RequestParam(value = "pageCurrent", defaultValue = "1") String pageCurrent,IndexRemind user) {
		ResultEntity res = new ResultEntity();
		Subject subject = SecurityUtils.getSubject();
		Session session = subject.getSession();
		System.out.println(subject.getPrincipal());
		try {
			Page<IndexRemind> userPage = remindservce.pageList(Integer.parseInt(pageCurrent), PAGESIZE, "createTime",user);
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
	 * 保存
	 * @param user
	 * @return
	 */
	@RequestMapping("saveIndexRemind")
	@ResponseBody
	public ResultEntity saveUser(IndexRemind user){
		ResultEntity res = new ResultEntity();
		//Subject currentUser = SecurityUtils.getSubject();
		String msg = "";
		try {
			user.setCreateTime(TimeHelper.getCurrentTime());
			remindservce.saveIndexRemind(user);
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
	 * 删除
	 * @param user
	 * @return
	 */
	@RequestMapping("delIndexRemind")
	@ResponseBody
	public ResultEntity delUser(String ID){
		ResultEntity res = new ResultEntity();
		IndexRemind IndexRemind = null;
		String msg = "";
		try {
			IndexRemind = remindservce.findIndexRemind(ID);
			if(IndexRemind != null){
				remindservce.deleteIndexRemind(ID);
				res.setMessage(DELETE_SUCCESS);
				res.setSuccess(SUCCESS);
			}else{
				res.setMessage(DELETE_ERROR);
				res.setSuccess(ERROR);
			}
		} catch (Exception e) {
			e.printStackTrace();
			msg = e.getMessage();
			res.setMessage(DELETE_ERROR + ":" +msg);
			res.setSuccess(ERROR);
		} 
		return res;
	}
	
	/**
	 * 查询单个
	 * @param user
	 * @return
	 */
	@RequestMapping("findIndexRemind")
	@ResponseBody
	public ResultEntity findUser(String ID){
		ResultEntity res = new ResultEntity();
		try {
			res.setData(remindservce.findIndexRemind(ID));
			res.setMessage(GET_SUCCESS);
			res.setSuccess(SUCCESS);
		} catch (Exception e) {
			e.printStackTrace();
			res.setMessage(GET_ERROR + ":" + e.getMessage());
			res.setSuccess(ERROR);
		}
		return res;
	}
	
	
	@RequestMapping("/equ_rs")
	public String getEquRsPage(){
		return "/manage/equipment/equ_rs";
	}

}
