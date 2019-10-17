package com.dfmy.service.core.jdbc;

import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import com.mchange.v2.c3p0.ComboPooledDataSource;

/**
 * 数据库连接池
 * @author zhangjl
 */
public class DataSource {


	public  static Map<String,ComboPooledDataSource> mapPools=new HashMap<String, ComboPooledDataSource>();
	
	//获取默认数据源池
		public static ComboPooledDataSource getDataSources(String dataSourceName)
		{
			 ComboPooledDataSource cpds;  
				if(mapPools.get(dataSourceName)==null)
				{
					cpds= new ComboPooledDataSource(true);
					try {
						Properties para=  getParam();
						cpds.setDataSourceName("Default");
						cpds.setDriverClass(para.getProperty("c3p0.driverClass"));
						 cpds.setJdbcUrl( para.getProperty("c3p0.jdbcUrl") );
					     cpds.setUser(para.getProperty("c3p0.user"));                                  
					     cpds.setPassword(para.getProperty("c3p0.password"));  
					     cpds.setCheckoutTimeout(Integer.parseInt(para.getProperty("c3p0.checkoutTimeout").toString()));
					     cpds.setMinPoolSize(Integer.parseInt(para.getProperty("c3p0.minPoolSize").toString()));
					     cpds.setMaxPoolSize(Integer.parseInt(para.getProperty("c3p0.maxPoolSize").toString()));
					     cpds.setInitialPoolSize(Integer.parseInt(para.getProperty("c3p0.initialPoolSize").toString()));
					     cpds.setAcquireIncrement(Integer.parseInt(para.getProperty("c3p0.acquireIncrement").toString()));
					     cpds.setMaxIdleTime(Integer.parseInt(para.getProperty("c3p0.maxIdleTime").toString()));
					     cpds.setMaxStatements(Integer.parseInt(para.getProperty("c3p0.maxStatements").toString()));
					     cpds.setMaxStatementsPerConnection(Integer.parseInt(para.getProperty("c3p0.maxStatementsPerConnection").toString()));
					     mapPools.put(dataSourceName, cpds);
					     
					} catch (Exception e) {
						e.printStackTrace();
					}
					return cpds;
				}
				else
				{
					return mapPools.get(dataSourceName);
				}
			
		}
	//获取指定参数数据源池
	public static ComboPooledDataSource getDataSources(String dataSourceName,String driverClass,String jdbcUrl,String user,String password)
	{
		 ComboPooledDataSource cpds;  
		if(mapPools.get(dataSourceName)==null)
		{
			cpds= new ComboPooledDataSource(true);
			try {
				Properties para=  getParam();
				cpds.setDriverClass(driverClass);
				 cpds.setJdbcUrl(jdbcUrl);
			     cpds.setUser(user);                                  
			     cpds.setPassword(password);  
			     cpds.setCheckoutTimeout(Integer.parseInt(para.getProperty("c3p0.checkoutTimeout").toString()));
			     cpds.setMinPoolSize(Integer.parseInt(para.getProperty("c3p0.minPoolSize").toString()));
			     cpds.setMaxPoolSize(Integer.parseInt(para.getProperty("c3p0.maxPoolSize").toString()));
			     cpds.setInitialPoolSize(Integer.parseInt(para.getProperty("c3p0.initialPoolSize").toString()));
			     cpds.setAcquireIncrement(Integer.parseInt(para.getProperty("c3p0.acquireIncrement").toString()));
			     cpds.setMaxIdleTime(Integer.parseInt(para.getProperty("c3p0.maxIdleTime").toString()));
			     cpds.setMaxStatements(Integer.parseInt(para.getProperty("c3p0.maxStatements").toString()));
			     cpds.setMaxStatementsPerConnection(Integer.parseInt(para.getProperty("c3p0.maxStatementsPerConnection").toString()));
			     mapPools.put(dataSourceName, cpds);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return cpds;
		}
		else
		{
			return mapPools.get(dataSourceName);
		}
	}

	//获取默认配置信息
	public static Properties getParam()
	{
		Properties prop = new Properties();
		try {
				InputStream stream =DataSource.class.getResourceAsStream("c3p0.properties");
		        if(stream!=null )
		        {
		        	 prop.load(stream);
		        }
		        stream.close();
		} catch (Exception e) {
			   e.printStackTrace();
		}
	    return prop;
	}
}
