package com.dfmy.service.index;

import java.net.SocketException;

import org.springframework.data.domain.Page;

import com.dfmy.entity.index.IndexRemind;


/**
 * 事物提醒接口
 * @author anix
 *
 */
public interface IndexRemindService {
	/**
	 * 保存、更新用户
	 * @param user
	 * @return
	 */
	IndexRemind saveIndexRemind(IndexRemind user);
	/**
	 * 查询单个用户
	 * @param userId
	 * @return
	 */
	IndexRemind findIndexRemind(String userId);
	
	/**
	 * 删除用户
	 * @param userId
	 */
	void deleteIndexRemind(String userId);
	
	/**
	 * 分页查询
	 * @param pageNumber
	 * @param pageSize
	 * @return
	 */
	Page<IndexRemind> pageList(int pageNumber,int pageSize,String sortColom,final IndexRemind user) throws SocketException;
	
	/**
	 * 查询用户
	 * @param user
	 * @return
	 */
	//IndexRemind findByIndexRemindName(String userName);
	
	/**
	 * 用户登录
	 * @param userName
	 * @param password
	 * @return
	 */
	//IndexRemind login(String userName, String password);
}
