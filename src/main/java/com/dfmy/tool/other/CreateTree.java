package com.dfmy.tool.other;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import com.dfmy.tool.other.TreeEntity.Node;

/**
 * 创建区划医疗机构树
 * @author wang
 */
public class CreateTree {

	public static String getTree(List dataList,String pId)
	{
		HashMap nodeList = new HashMap();
		// 根节点
		Node root = null;
		for (Iterator it = dataList.iterator(); it.hasNext();) {
			Map dataRecord = (Map) it.next();
			Node node = new TreeEntity().new Node();
			node.pkID = (String) dataRecord.get("PKID");
			node.id = (String) dataRecord.get("ID");
			node.name = (String) dataRecord.get("TEXT");
			node.pId = (String) dataRecord.get("PARENTID");
			node.icon=(String) dataRecord.get("ICON");
			node.temp_name=(String) dataRecord.get("TEMP_NAME");
			node.pageUrl=(String) dataRecord.get("PAGE_URL");
			node.dataUrl=(String) dataRecord.get("DATA_URL");
			node.showRight=(String) dataRecord.get("SHOW_RIGHT");
			node.showLocation = (String)dataRecord.get("SHOW_LOACTION");
			node.outPage=(String)dataRecord.get("OUTURL");
			node.order = (String)dataRecord.get("ZB_ORDER");
			nodeList.put(node.id, node);
		}
		Set entrySet = nodeList.entrySet();
		try {
			for (Iterator it = entrySet.iterator(); it.hasNext();) {
				Node node = (Node) ((Map.Entry) it.next()).getValue();
				if ( node.id.equals(pId)) {
					root = node;
					root.pId="000000";
				} else {
					((Node) nodeList.get(node.pId)).addChild(node);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		root.sortChildren();
		return root.toTreeString();
	}
	
}
