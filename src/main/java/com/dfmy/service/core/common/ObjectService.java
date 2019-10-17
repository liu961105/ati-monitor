package com.dfmy.service.core.common;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Service;

import com.dfmy.entity.AttributeEntity;
import com.dfmy.entity.Constant;
import com.dfmy.entity.ObjectEntity;
import com.dfmy.util.Page;
import com.dfmy.util.PageUtils;
import com.dfmy.util.StringHelper;

/**
 * 对象操作服务
 * @author zhangjl
 */
@Service
public class ObjectService implements IService {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	@Autowired
	private  NamedParameterJdbcTemplate namedParameterJdbcTemplate;

	/**
	 * 根据主键查询对象
	 * @throws Exception
	 */
	public Map<String, Object>  queryObject(String objectId, String dataId)throws Exception{
		if(StringUtils.isEmpty(dataId))
		{
			throw new Exception("业务数据唯一标识为空值！");
		}
		ObjectEntity oe = getObjectMetaInfo(objectId);
		String querySql = "SELECT " ;
		for (AttributeEntity ae : oe.getAttributes()) {
			querySql+=ae.getColumnName() +" AS " + ae.getNameEn() +",";
		}
		querySql = StringUtils.stripEnd(querySql, ",") + " FROM " +oe.getTableName();
		querySql+= " WHERE "+Constant.DATAID+"=?";
		return 	jdbcTemplate.queryForMap(querySql, dataId);
		
	}
	/**
	 * 根据唯一自定义编号查询对象
	 * @throws Exception
	 */
	public Map<String, Object>  queryObject(String objectId, String dataId,String uniqField)throws Exception{

		if(StringUtils.isEmpty(dataId))
		{
			throw new Exception("业务数据唯一标识为空值！");
		}
		ObjectEntity oe = getObjectMetaInfo(objectId);
		String querySql = "SELECT " ;
		for (AttributeEntity ae : oe.getAttributes()) {
			querySql+=ae.getColumnName() +" AS " + ae.getNameEn() +",";
		}
		querySql = StringUtils.stripEnd(querySql, ",") + " FROM " +oe.getTableName();
		querySql+= " WHERE "+uniqField+"=?";
		return 	jdbcTemplate.queryForMap(querySql, dataId);
		
	}
	public List<Map<String, Object>>  queryList(String objectId, Map<String, Object> requestVal)throws Exception{

		ObjectEntity oe = getObjectMetaInfo(objectId);
		List<String> paras=new ArrayList<String>();
		String querySql = "SELECT " ;
		for (AttributeEntity ae : oe.getAttributes()) {
			querySql+=ae.getColumnName() +" AS " + ae.getNameEn() +",";
		}
		querySql = StringUtils.stripEnd(querySql, ",") + " FROM " +oe.getTableName() +" WHERE 1=1 ";
		//查询参数
		for (Map.Entry req : requestVal.entrySet()) {
			if(!req.getKey().toString().equals("sid") && !req.getKey().toString().equals("ts")){
				paras.add((String)req.getValue());
				querySql+= " AND "+req.getKey()+" like ?";
			}
		}
		return jdbcTemplate.queryForList(querySql,paras.toArray());
	}
	
	/**
	 * 更新对象
	 */
	public void  updateObject(String objectId, Map<String, Object> requestVal)throws Exception{
		
		if(requestVal.get(Constant.DATAID) ==null ||requestVal.get(Constant.DATAID).equals("")){
			throw new Exception("没有传输记录的唯一更新条件！");
		}
		ObjectEntity oe = getObjectMetaInfo(objectId);
		String updateSql = "UPDATE  " +oe.getTableName() +" SET ";
		ArrayList paraSqls=new ArrayList();
		for (Map.Entry req : requestVal.entrySet()) {
			for (AttributeEntity ae : oe.getAttributes()) {
				if(!req.getKey().toString().equals(ae.getNameEn()) || ae.getColumnName().equals(Constant.TABLEPKID)) continue;
				updateSql += ae.getColumnName() + "=?,";
				paraSqls.add(req.getValue());
			}
		}
		updateSql = StringUtils.stripEnd(updateSql, ",") + " WHERE "+Constant.DATAID+"='"+requestVal.get(Constant.DATAID)+"'";
		jdbcTemplate.update(updateSql,paraSqls.toArray());
	}
	/**
	 * 根据主键查询删除对象
	 */
	public void deleteObject(String objectId, Map<String, Object> requestVal)throws Exception{
		if(requestVal.get(Constant.DATAID) ==null ||requestVal.get(Constant.DATAID).equals("")){
			throw new Exception("没有传输记录的唯一条件！");
		}
		ObjectEntity oe = getObjectMetaInfo(objectId);
		String deleteSql = "DELETE FROM  " +oe.getTableName() +"   WHERE  "+Constant.DATAID+"=?";
		jdbcTemplate.update(deleteSql,requestVal.get(Constant.DATAID));
	}
	/**
	 * 根据主键删除所有对象
	 */
	public boolean deleteAllObject(String objectId, Map<String, Object> requestVal)throws Exception{
		if(requestVal.get(Constant.DATAID) ==null ||requestVal.get(Constant.DATAID).equals("")){
			throw new Exception("没有传输记录的唯一条件！");
		}
		ObjectEntity oe = getObjectMetaInfo(objectId);
		String deleteSql = "delete  from "+oe.getTableName()+" k where k.index_no like (select t.index_no from "+oe.getTableName()+" t where t."+Constant.TABLEPKID+" =?)'%'";
		int amounts = jdbcTemplate.update(deleteSql,requestVal.get(Constant.DATAID));
		if(amounts>0){
			return true;
		}
		return false;
	}
	/**
	 * 保存对象
	 * @param objectId
	 * @param requestVal
	 */
	public String saveObject(String objectId, Map<String, Object> requestVal)throws Exception {
		if(requestVal.get(Constant.DATAID) !=null && requestVal.get(Constant.DATAID)!="")
		{
			updateObject(objectId,requestVal);
			return (String)requestVal.get(Constant.DATAID);
		}
		ObjectEntity oe = setObjectValue(requestVal, objectId);
		String pkId= UUID.randomUUID().toString().replace("-", "");
		Map<String,Object> parasVal=new HashMap<String,Object>();
		String sql = "INSERT INTO " + oe.getTableName();
		String fields = "(";
		String values = " VALUES(";
		for (Map.Entry req : requestVal.entrySet()) {
			for (AttributeEntity ae : oe.getAttributes()) {
				// 处理系统级字段
				if(parasVal.get(Constant.DATAID)== null){
					if (ae.getColumnName().equals(Constant.DATAID)) {
						fields += ae.getColumnName() + ",";
						values += ":"+ae.getColumnName()+",";
						parasVal.put(ae.getColumnName(), pkId);
					}
				}
				if(!req.getKey().toString().equals(ae.getNameEn())) continue;
				
				
				// 处理常规字段
				fields += ae.getColumnName() + ",";
				values += ":"+ae.getColumnName()+",";
				
				switch (ae.getColumnType()) {
				case "STRING":
				case "NUMBER":
					parasVal.put(ae.getColumnName(), ae.getValue());
					break;
				default:
					parasVal.put(ae.getColumnName(), ae.getValue());
					break;
				} 
			}
		}
		values = StringUtils.stripEnd(values, ",") + ")";
		fields = StringUtils.stripEnd(fields, ",") + ")";
		
		namedParameterJdbcTemplate.update(sql +fields+values, parasVal);
		return pkId;
	}

	/**
	 * 对象赋值
	 * @param map
	 * @param objectId
	 * @return
	 */
	public ObjectEntity setObjectValue(Map<String, Object> map, String objectId)
			throws Exception {
		ObjectEntity oe = getObjectMetaInfo(objectId);
		Object rem=null;
		if (oe != null && oe.getAttributes().size() > 0) {
			for (AttributeEntity ae : oe.getAttributes()) {
				rem=map.get(ae.getNameEn());
				if(rem!=null){
					ae.setValue(rem);
				}
			}
		}
		return oe;
	}

	/**
	 * 获得的对象元信息
	 */
	public ObjectEntity getObjectMetaInfo(String objectId) throws Exception {
		if(objectId==null){
			throw new Exception("对象ID参数为空！");
		}
		List<Map<String, Object>> objList = jdbcTemplate.queryForList("SELECT O.ID AS OID,O.OBJECT_CN ,O.OBJECT_EN,O.TABLE_NAME,O.PAGE_PATH,A.PKID AS AID,A.NAME_CN,A.NAME_EN,A.COLUMN_NAME,A.COLUMN_TYPE,A.COLUMN_SIZE,A.FK_OBJECT,A.IS_SYSFIELD FROM SYS_OBJECT O,SYS_OBJECT_ATTRIBUTE A WHERE A.FK_OBJECT=O.SID AND  O.ID=?",objectId);
		if (objList == null && objList.size() > 0) {
			throw new Exception("您查询的对象不存在！");
		}
		// 创建对象
		Map<String, Object> objMap = objList.get(0);
		ObjectEntity objE = new ObjectEntity();
		objE.setPkId((String) objMap.get("OID"));
		objE.setObjectCn((String) objMap.get("OBJECT_CN"));
		objE.setObjectEn((String) objMap.get("OBJECT_EN"));
		objE.setTableName((String) objMap.get("TABLE_NAME"));
		objE.setPagePath((String) objMap.get("PAGE_PATH"));
		// 创建对象属性
		List<AttributeEntity> attrList = new ArrayList<AttributeEntity>(objList.size());
		AttributeEntity attr = null;
		for (Map<String, Object> attrMap : objList) {
			attr = new AttributeEntity();
			attr.setPkID(attrMap.get("AID").toString());
			attr.setNameCn(attrMap.get("NAME_CN").toString());
			attr.setNameEn(attrMap.get("NAME_EN").toString());
			attr.setColumnName(attrMap.get("COLUMN_NAME").toString());
			attr.setColumnType(attrMap.get("COLUMN_TYPE").toString());
			attr.setColumnSize(attrMap.get("COLUMN_SIZE").toString());
			attr.setfKObject(attrMap.get("FK_OBJECT").toString());
			attr.setSystemField(attrMap.get("IS_SYSFIELD").toString().equals("1")? true : false);
			attrList.add(attr);
		}
		objE.setAttributes(attrList);
		return objE;
	}

	/**
	 * 获得对象属性元信息
	 */
	public List<AttributeEntity> getObjectAttributeMeta() throws Exception{
		return null;
	}
	
	/**
	 * 获得业务实体对象【根据主键已赋值】
	 * @param objectId
	 * @param pkID
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> getObjectValue(String objectId, String dataId)throws Exception	{
		
		Map<String, Object> map= queryObject(objectId,dataId);
		
		return map;
		
	}	

/**
 * 获得业务实体对象【根据自定义编号已赋值】
 * @param objectId
 * @param dataId
 * @param indexField
 * @return
 * @throws Exception
 */
	public Map<String, Object> getObjectValue(String objectId, String dataId,String uniqField)throws Exception	{
		
		Map<String, Object> map= queryObject(objectId,dataId,uniqField);
		
		return map;
		
	}	
	/**
	 * 查找是否存在相同的编号
	 * @param map
	 * @return 0 未找到
	 * 		   1 已找到
	 */		   
	public int selectId(Map<String, Object> map) throws Exception{
		if(!map.isEmpty()){
			String id = map.get("id").toString();
			if(StringUtils.isNotBlank(id)&&StringUtils.isNumeric(id)){
				String tableName = map.get("tableName").toString();	
				String sql = "select count(*) as count from "+tableName+" where index_no = '"+id+"'";
				List<Map<String, Object>> queryForList = jdbcTemplate.queryForList(sql);
				String co = queryForList.get(0).get("COUNT").toString();
				if(queryForList.isEmpty()||co.equals("0")){
					return 0;
				}
			}
		}
		return 1;
	}
	
	/**
	 * 获取公共分页列表
	 * @param objectId
	 * @param requestVal
	 * @return
	 * @throws Exception
	 */
	public Page<List<Map<String, Object>>>  queryPageList(String objectId, Map<String, Object> requestVal,PageUtils pageUtils)throws Exception{

		ObjectEntity oe = getObjectMetaInfo(objectId);
		List<String> paras=new ArrayList<String>();
		String querySql = "SELECT " ;
		for (AttributeEntity ae : oe.getAttributes()) {
			querySql+=ae.getColumnName() +" AS " + ae.getNameEn() +",";
		}
		querySql = StringUtils.stripEnd(querySql, ",") + " FROM " +oe.getTableName() +" WHERE 1=1 ";
		//查询参数
		for (Map.Entry req : requestVal.entrySet()) {
			
			if(!req.getKey().toString().equals("sid") && !req.getKey().toString().equals("ts") && !req.getKey().toString().equals("pageCurrent")){
				paras.add((String)req.getValue());
				querySql+= " AND "+req.getKey()+" like ?";
			}
		}
		return this.getPageBySql(querySql, pageUtils.getPageNo(), pageUtils.getPageSize(), paras.toArray());
	}
	
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
		    return new Page(startIndex,pageNo, totalCount, pageSize, list);
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
