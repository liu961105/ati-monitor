package com.dfmy.service.sys;

import java.net.SocketException;
import java.util.List;

import org.springframework.data.domain.Page;

import com.dfmy.entity.sys.SysProfession;
/**
 * 岗位接口
 * @author zhangjl
 *
 */
public interface SysProfessionService {
	/**
	 * 保存、更新工种
	 * @param user
	 * @return
	 */
	SysProfession saveProfession(SysProfession user);
	/**
	 * 查询单个用户
	 * @param userId
	 * @return
	 */
	SysProfession findProfession(String userId);
	
	/**
	 * 删除用户
	 * @param userId
	 */
	void deleteProfession(String userId);
	
	/**
	 * 分页查询
	 * @param pageNumber
	 * @param pageSize
	 * @return
	 */
	Page<SysProfession> pageList(int pageNumber,int pageSize,String sortColom,final SysProfession user) throws SocketException;
	
	/**
	 * 查询用户
	 * @param user
	 * @return
	 */
	SysProfession findByName(String Name);
	
	
	List<SysProfession> findTopList();
	
	/**
	 * 根据岗位名获取岗位
	 * @param bm
	 * @return
	 */
	SysProfession findProfeByName(String bm);
	
	/**
	 * 用户登录
	 * @param userName
	 * @param password
	 * @return
	 */
	//SysProfession login(String userName, String password);
	
	/**
	 * 根据部门主键查询
	 * @param deptId
	 * @return
	 */
	List<SysProfession> findByDeptId(String deptId);
}
