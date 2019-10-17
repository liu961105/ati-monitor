package com.dfmy.service.core.jdbc;

import java.io.IOException;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.CallableStatementCallback;
import org.springframework.jdbc.core.CallableStatementCreator;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;

import com.mchange.v2.c3p0.ComboPooledDataSource;


/**
 * JDBC数据库访问类
 * @author wang
 *
 */
@Service
public class JdbcUtil {

	private JdbcTemplate jdbcTemplate;

	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	/**
	 * 无返回值的存储过程
	 * @param procedureMethod :存储过程方法名
	 */
	public void executeNoReturnValue(String procedureMethod) {
		try {

			if (jdbcTemplate == null)	throw new Exception("JdbcTemplate 未实例化！"); 
			this.jdbcTemplate.execute("call " + procedureMethod);	
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 有返回值的存储过程（非结果集）
	 */
	public String executeReturnValue(final String  procedureMethod) {
		String result="";
		try {
			if (this.jdbcTemplate == null) throw new Exception("JdbcTemplate 未实例化!");
				 result=this.jdbcTemplate.execute(new CallableStatementCreator() {
					public CallableStatement createCallableStatement(Connection con)
							throws SQLException {
						   String storedProc = "{call "+procedureMethod+"}";  
			               CallableStatement cs = con.prepareCall(storedProc);   
			              // cs.registerOutParameter(1,OracleTypes.VARCHAR);// 注册输出参数的类型   
			               return cs;   
					}
				},new CallableStatementCallback<String>() {
					public String doInCallableStatement(CallableStatement cs)
							throws SQLException, DataAccessException {
							cs.execute();   
			               return cs.getString(1);// 获取输出参数的值 
					}
				});
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	/**
	 * 返回结果集的存储过程
	 * @return
	 */
	public List  executeReturnList(final String  procedureMethod)
	{
		List list=null;
		try {
			list=this.jdbcTemplate.execute(new CallableStatementCreator() {		
				public CallableStatement createCallableStatement(Connection con)
						throws SQLException {
					  String storedProc = "{call "+procedureMethod+"}";// 调用的sql   
		               CallableStatement cs = con.prepareCall(storedProc);   
		               //cs.registerOutParameter(1, OracleTypes.CURSOR);// 注册输出参数的类型   
		               return cs;   
				}
			},new CallableStatementCallback<List>() {
				public List<Map<String, Object>> doInCallableStatement(CallableStatement cs)
						throws SQLException, DataAccessException {
					  	cs.execute();   
		               ResultSet rs = (ResultSet) cs.getObject(1);// 获取游标值   
		               return  resultSetToList(rs);
		               
				}
			});
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	private  List<Map<String,Object>> resultSetToList(ResultSet rs) throws java.sql.SQLException {   
        if (rs == null)   
            return Collections.emptyList();   
        ResultSetMetaData md = rs.getMetaData();   
        int columnCount = md.getColumnCount(); 
        List<Map<String,Object>> list = new ArrayList<Map<String,Object>>();   
        Map<String, Object> rowData=null;   
        while (rs.next()) {   
         rowData = new HashMap<String, Object>(columnCount);   
         for (int i = 1; i <= columnCount; i++) {   
                 rowData.put(md.getColumnName(i), rs.getObject(i));   
         }   
         list.add(rowData);   
        }   
        rs.close();
        return list;   
}  
	/**
	 * 验证jdbc链接是否通过
	 * @param map
	 * @return 1 验证通过
	 * 		   0 验证失败
	 */		   
	public int verifyJDBC(Map<String, Object> map){
		if(!map.isEmpty()){
		String dataSourceName = map.get("dataSourceName").toString();
		String driverClass = map.get("driverClass").toString();
		String jdbcUrl = map.get("jdbcUrl").toString();
		String user = map.get("user").toString();
		String password = map.get("password").toString();
		final String  sql = "select count(*) from dual";
		ComboPooledDataSource dataSources;
		try {
			dataSources = DataSource.getDataSources(dataSourceName, driverClass, jdbcUrl, user, password);
			JdbcTemplate jdbcTemplate = new JdbcTemplate(dataSources);
			Integer queryForObject = jdbcTemplate.queryForObject(sql, Integer.class);
			return queryForObject;
		} catch (Exception e) {
			e.printStackTrace();
			return 0;
		}
		}else{
			return 0;
		}
		
		
	}
	
	/**
	 * 验证jdbc链接是否通过
	 * @param map
	 * @return 1 验证通过
	 * 		   0 验证失败
	 * 		  -1 ip验证失败
	 */	
	public static int isConnection(Map<String, Object> map){
		String driverClass = map.get("driverClass").toString();
		String jdbcUrl = map.get("jdbcUrl").toString();
		String user = map.get("user").toString();
		String password = map.get("password").toString();
		String ip = jdbcUrl;
		if(jdbcUrl.indexOf("@")!=-1){
			ip =jdbcUrl.substring(jdbcUrl.indexOf("@")+1,jdbcUrl.lastIndexOf(":")) ;
		}
		try {
			boolean reachable = InetAddress.getByName(ip).isReachable(3000);
			if(!reachable){
				return -1;
			}
		} catch (UnknownHostException e1) {
			e1.printStackTrace();
			return -1;
		} catch (IOException e1) {
			e1.printStackTrace();
			return -1;
		}
		Connection connection = null;
		try {
			Class.forName(driverClass);
			 connection = DriverManager.getConnection(jdbcUrl, user, password);
			if(connection!=null){
				connection.close();
				return 1;
			}else{
				return 0;
			}
			
		} catch (Exception e) {	
			e.printStackTrace();
			return 0;
		}finally{
			if(connection!=null){
				try {
					connection.close();
					return 1;
				} catch (SQLException e) {
					e.printStackTrace();
				}
				return 0;
			}
			
		}
	
		
		
	}
	
	public static void main(String[] args) {
//		 JdbcTemplate jdbcStatus = new JdbcTemplate(DataSource.getDataSources("Default"), true);
//			JdbcUtil jdbc=new JdbcUtil();
//			jdbc.setJdbcTemplate(jdbcStatus);
//			jdbc.executeNoReturnValue("PRO_SYS_ESB_QUANTITY('620102LDYY-20161009174558-03')");
		/*JdbcTemplate jdbcTemplate2 = new JdbcTemplate( DataSource.getDataSources("TOPIC_BUP", "oracle.jdbc.driver.OracleDriver", "jdbc:oracle:thin:@10.18.100.86:1521/TOPIC_BUP", "topic_bup", "topic_bup"));
		List<Map<String,Object>> lists = new ArrayList<Map<String,Object>>();
		lists = jdbcTemplate2.queryForList("select count(*) from dual");
		System.err.println(lists.toString());*/
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("driverClass", "oracle.jdbc.driver.OracleDriver");
		map.put("jdbcUrl", "jdbc:oracle:thin:@10.18.100.86:1521/TOPIC_BUP");
		map.put("user", "topic_bup");
		map.put("password", "topic_bup");
		int connection = JdbcUtil.isConnection(map);
		/*try {
			boolean reachable = InetAddress.getByName("10.18.100.11").isReachable(3000);
			System.out.println(reachable);
		} catch (UnknownHostException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}*/
			
	}
}
