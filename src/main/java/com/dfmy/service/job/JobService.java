package com.dfmy.service.job;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.dfmy.tool.schedule.JobManager;
/**
 * 
 * @author zhangjl
 *
 */
@Service
public class JobService{
	@Resource
	private JdbcTemplate jdbcTemplate;
	
	/*
	 * param:主键，
	 * stopOrStart：启动或者停止的状态（1：启动，0：停止）
	 * */
	public int jobMag(String param,String stopOrStart){
		String[] params = param.split(",");
		int status=-1;
		for(String p_s:params){
			Map<String, Object> queryForMap = jdbcTemplate.queryForMap("SELECT * FROM SET_JOB WHERE PKID =?",p_s);
			String  job_object = (String)queryForMap.get("JOB_OBJECT");
			String  job_expression =(String)queryForMap.get("JOB_EXPRESSION"); 
			String  trigger_name = (String)queryForMap.get("TRIGGER_NAME");
			String  job_name = (String)queryForMap.get("JOB_NAME");
			String  trigger_group_name = (String)queryForMap.get("TRIGGER_GROUP_NAME");
			String  job_group_name = (String)queryForMap.get("JOB_GROUP_NAME");
			
			try {
				Object[] objs = {stopOrStart,p_s};
				Class cls = Class.forName(job_object);
				//JobManager.addJob("dd1","tr",cls,"*/10 * * * * ?");
				if(stopOrStart.equals("1")){//执行启动操作
					status = JobManager.addJob(job_name,trigger_name,cls,job_expression);
				}
				if(stopOrStart.equals("0")){//执行停止操作
					status =  JobManager.pauseJob(job_name,trigger_name,cls,job_expression);
				}
				updateJob(objs);
				
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			}
		}
		return status;
	}

	/**
	 * 更新启动状态
	 */
	public void updateJob(Object[] args){
		jdbcTemplate.update("update SET_JOB t set t.JOB_STATUS =? WHERE t.PKID=?", args);
	}

	/**
	 * 删除
	 * @param param
	 * @return
	 */
	public void deleteJob(String param) {
		String[] params = param.split(",");
		for(String p_s:params){
			jdbcTemplate.execute("delete from SET_JOB t where t.PKID='"+p_s+"'");
		}
	}
	/**
	 * 数据源删除
	 * @param param
	 */
	public void deleteDatasource(String param){
		String[] params = param.split(",");
		for(String p_s:params){
			jdbcTemplate.execute("delete from WAJUE_YLFYJG_SJYGL t where t.PKID='"+p_s+"'");
		}
	}
}
