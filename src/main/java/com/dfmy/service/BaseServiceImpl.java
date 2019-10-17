package com.dfmy.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;

import com.dfmy.util.Page;
import com.dfmy.util.StringHelper;

public class BaseServiceImpl {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	/**
	 * @Title: getPageBySqlForListMap
	 * @Description: TODO(根据SQL查询数据并返回一个List<Map<String,Object>>,将其封装为 Page)
	 * @param sql: 查询 sql 语句
	 * @param pageNo: 起始页
	 * @param pageSize: 每页显示条数
	 * @param values : 参数
	 * @return Page
	 */
	public Page<List<Map<String, Object>>> getPageBySql(final String sql, final int pageNo,
	    final int pageSize, final Object... values) {

		final String countSql = "select count(*) from (" +sql
			+ ") as b";
		final long totalCount = this.getCountBySql(countSql, values);
		if (totalCount < 1) {
		    return new Page();
		} else {
		    final int startIndex = Page.getStartOfPage(pageNo, pageSize);
		    final String querySql = StringHelper.getString(
		    		sql," limit " ,startIndex,",",pageSize
		    		);
		    List<Map<String,Object>> list = this.jdbcTemplate.queryForList(querySql,values);
		    return new Page<List<Map<String, Object>>>(startIndex,pageNo, totalCount, pageSize, list);
		}
    }
	
	
	/**
     * 
     * 根据sql查询数据总数 <br/>
     * 
     * @author HT
     * @param sql
     * @param values
     * @return
     */
    public Long getCountBySql(final String sql, final Object... values) {
    	return jdbcTemplate.queryForObject(sql, Long.class, values);
    }

}
