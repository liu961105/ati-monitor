package com.dfmy.service.sys;

import java.net.SocketException;
import java.util.List;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.data.domain.Page;

import com.dfmy.entity.sys.SysUser;
/**
 * 系统用户接口
 * @author zhangjl
 *
 */
public interface SysUserService {
	/**
	 * 保存、更新用户
	 * @param user
	 * @return
	 */
	SysUser saveUser(SysUser user);
	/**
	 * 查询单个用户
	 * @param userId
	 * @return
	 */
	SysUser findUser(String userId);
	
	/**
	 * 删除用户
	 * @param userId
	 */
	void deleteUser(String userId);
	
	/**
	 * 分页查询
	 * @param pageNumber
	 * @param pageSize
	 * @return
	 */
	Page<SysUser> pageList(int pageNumber,int pageSize,String sortColom,final SysUser user,String deptId,String selpostid) throws SocketException;
	
	/**
	 * 查询用户
	 * @param user
	 * @return
	 */
	SysUser findByUserName(String userName);
	
	/**
	 * 用户登录
	 * @param userName
	 * @param password
	 * @return
	 */
	SysUser login(String userName, String password);
	
	/**
	 * 根据部门查询用户
	 * @return
	 */
	List<SysUser> findUserBydeptId(String iD);
	
	/**
	 * 查询所有用户
	 * @return
	 */
	List<SysUser> findAll();
	
	/**
	 * 导出用户表格
	 * @param userList
	 * @return
	 */
	HSSFWorkbook exportExcel(List<SysUser> userList);
	
	/**
	 * 根据工号查询用户
	 * @param gh
	 * @return
	 */
	SysUser getUserByGh(String gh);
}
