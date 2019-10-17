package com.dfmy.tool.other;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Iterator;
import java.util.List;

/**
 * 树对象
 * @author wang
 */
public class TreeEntity {
	
	 class Node {
			/**
			 * 主键
			 */
			public String pkID;
			/**
			 * 节点编号
			 */
			public String id;
			/**
			 * 节点内容
			 */
			public String name;
			/**
			 * 父节点编号
			 */
			public String pId;
			
			public String dataId;
			/**
			 * 指标图标
			 */
			public String icon;
			/**
			 * 页面
			 */
			public String pageUrl;
			/**
			 * 指标别名
			 */
			public String temp_name;
			/**
			 * 数据源
			 */
			public String dataUrl;
			/**
			 * 显示分类
			 */
			public String showRight;
			
			/**
			 * 显示位置
			 */
			public String showLocation;
			/**
			 * 嵌入页面地址
			 */
			public String outPage;
			/**
			 * 孩子节点列表
			 */
			public String order;
			
			
			private Children children = new Children();
			
			public String toTreeString() {
				String result = "{" + "pkID : '" + pkID + "'" + "," + "id : '" + id + "'" + ", text : '" + name+"'"+ ", icon : '" + icon +"'"+ ", pageUrl : '" + pageUrl +"'"+ ", temp_name : '" + temp_name +"'"+ ", dataUrl : '" + dataUrl +"'"+ ", showRight : '" + showRight +"'"+ ", showLocation : '" + showLocation +"',outPage:'"+outPage+"'";
				if(pId.equals("000000"))
				{
					//result += ", open : true" ;
				}
				if (children != null && children.getSize() != 0) {
					result += ", nodes : " + children.toTreeString();
					result += ", tags : " + children.getCount();
				} else {
					//result += ", leaf : true";
				}
				return result + "}";
			}
			// 兄弟节点横向排序
			public void sortChildren() {
				if (children != null && children.getSize() != 0) {
					children.sortChildren();
				}
			}
			// 添加孩子节点
			public void addChild(Node node) {
				this.children.addChild(node);
			}		
	 }	
	 class Children {
			private List list = new ArrayList();
			public int getSize() {
				return list.size();
			}
			public void addChild(Node node) {
				list.add(node);
			}
			// 拼接孩子节点的JSON字符串
			public String toTreeString() {
				String result = "[";
				for (Iterator it = list.iterator(); it.hasNext();) {
					result += ((Node) it.next()).toTreeString();
					result += ",";
				}
				result = result.substring(0, result.length() - 1);
				result += "]";
				return result;
			}
			
			public String getCount(){
				return "["+getSize()+"]";
			}
			// 孩子节点排序
			public void sortChildren() {
				// 对本层节点进行排序
				// 可根据不同的排序属性，传入不同的比较器，这里传入ID比较器
				Collections.sort(list, new NodeIDComparator());
				// 对每个节点的下一层节点进行排序
				for (Iterator it = list.iterator(); it.hasNext();) {
					((Node) it.next()).sortChildren();
				}
			}
		}
		/**
		 * 节点比较器
		 */
		class NodeIDComparator implements Comparator {
			// 按照节点编号比较
			public int compare(Object o1, Object o2) {		
				if(((Node) o1).order !=null){
					Long j1 =Long.parseLong(((Node) o1).order);
					Long j2 = Long.parseLong(((Node) o2).order==null?"1":((Node) o2).order);
					return (j1 < j2 ? -1 : (j1 == j2 ? 0 : 1));
				}
				return 1;
				
			}
	}
	
}
