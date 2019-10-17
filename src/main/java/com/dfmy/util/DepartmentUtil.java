package com.dfmy.util;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import com.dfmy.entity.sys.SysDept;

public class DepartmentUtil {
	/** 
     * 遍历部门树，得到所有的部门列表，并修改了名称以表示层次 
     * @param topList 
     * @return 
     */  
    public static List<SysDept> getAllDepartments(List<SysDept> topList){  
        List<SysDept> list = new ArrayList<SysDept>();  
        walkDepartmentTrees(topList,"┣",list);  
        return list;  
    }  
    /** 
     * 遍历部门树，把遍历出来的部门都放到指定的集合中 
     * @param topList 
     * @param string 
     * @param list 
     */  
    private static void walkDepartmentTrees(Collection<SysDept> topList,String prefix, List<SysDept> list) {  
        for(SysDept top : topList){  
            //顶点  
        	SysDept copy = new SysDept();//  
            copy.setDeptId(top.getDeptId());  
            copy.setName(prefix+top.getName());  
            list.add(copy);  
            //子树  
            walkDepartmentTrees(top.getChildDept(),"　"+prefix, list);  
        }  
    }  
}
