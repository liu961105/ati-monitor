package com.dfmy.service.core.jdbc;

import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.jdbc.core.JdbcTemplate;

import com.mchange.v2.c3p0.ComboPooledDataSource;

public class TestMain {

	public static void main(String[] args) {

		try {

			JdbcTemplate jdbcTemplate1 = new JdbcTemplate( DataSource.getDataSources("Default"));
			JdbcTemplate jdbcTemplate2 = new JdbcTemplate( DataSource.getDataSources("02", "oracle.jdbc.driver.OracleDriver", "jdbc:oracle:thin:@202.100.92.12:1521/qyyldb12", "dxcm_exch", "dxcm_exch"));
			List list = jdbcTemplate1.queryForList("select * from mc_map_code t");
			Iterator iterator = list.iterator();
			while (iterator.hasNext()) {
				Map map4book = (Map) iterator.next();
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
}