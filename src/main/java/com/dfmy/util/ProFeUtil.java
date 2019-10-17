package com.dfmy.util;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import com.dfmy.entity.sys.SysProfession;



public class ProFeUtil {
	/** 
     * 遍历岗位树，得到所有的岗位列表，并修改了名称以表示层次 
     * @param topList 
     * @return 
     */  
    public static List<SysProfession> getAllProFes(List<SysProfession> topList){  
        List<SysProfession> list = new ArrayList<SysProfession>();  
        walkProFeTrees(topList,"┣",list);  
        return list;  
    }  
    /** 
     * 遍历岗位树，把遍历出来的岗位都放到指定的集合中 
     * @param topList 
     * @param string 
     * @param list 
     */  
    private static void walkProFeTrees(Collection<SysProfession> topList,String prefix, List<SysProfession> list) {  
        for(SysProfession top : topList){  
            //顶点  
        	SysProfession copy = new SysProfession();//  
            copy.setProfessionId(top.getProfessionId());  
            copy.setName(prefix+top.getName());  
            list.add(copy);  
            //子树  
            walkProFeTrees(top.getChildProfession(),"　"+prefix, list);  
        }  
    }  
}
