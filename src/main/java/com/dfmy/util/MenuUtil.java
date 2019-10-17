package com.dfmy.util;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import com.dfmy.entity.sys.SysDept;
import com.dfmy.entity.sys.SysMenu;

public class MenuUtil {
	/** 
     * 遍历部门树，得到所有的部门列表，并修改了名称以表示层次 
     * @param topList 
     * @return 
     */  
    public static List<SysMenu> getAllDepartments(List<SysMenu> topList){  
        List<SysMenu> list = new ArrayList<SysMenu>();  
        walkDepartmentTrees(topList,"┣",list);  
        return list;  
    }  
    /** 
     * 遍历部门树，把遍历出来的部门都放到指定的集合中 
     * @param topList 
     * @param string 
     * @param list 
     */  
    private static void walkDepartmentTrees(Collection<SysMenu> topList,String prefix, List<SysMenu> list) {  
        for(SysMenu top : topList){  
            //顶点  
        	SysMenu copy = new SysMenu();//  
            copy.setMenuId(top.getMenuId());  
            copy.setName(prefix+top.getName());  
            list.add(copy);  
            //子树  
            walkDepartmentTrees(top.getChildMenu(),"　"+prefix, list);  
        }  
    }  
}
