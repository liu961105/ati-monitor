package com.dfmy.util;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import com.dfmy.entity.sys.SysParam;

public class ParamUtil {
	/** 
     * 遍历部门树，得到所有的部门列表，并修改了名称以表示层次 
     * @param topList 
     * @return 
     */  
    public static List<SysParam> getAllDepartments(List<SysParam> topList){  
        List<SysParam> list = new ArrayList<SysParam>();  
        walkDepartmentTrees(topList,"┣",list);  
        return list;  
    }  
    /** 
     * 遍历部门树，把遍历出来的部门都放到指定的集合中 
     * @param topList 
     * @param string 
     * @param list 
     */  
    private static void walkDepartmentTrees(Collection<SysParam> topList,String prefix, List<SysParam> list) {  
        for(SysParam top : topList){  
            //顶点  
        	SysParam copy = new SysParam();//  
            copy.setParamCode(top.getParamCode());  
            copy.setParamName(prefix+top.getParamName());  
            list.add(copy);  
            //子树  
            walkDepartmentTrees(top.getChildParam(),"　"+prefix, list);  
        }  
    }  
}

