package com.dfmy.tool.container;

import java.util.concurrent.CopyOnWriteArrayList;


/**
 * 容器管理-动态加载管理组件
 * @author wang
 *
 */
public class ContainerManager {
	
	private final static CopyOnWriteArrayList<AbstractComponent> registeredComponent = new CopyOnWriteArrayList<AbstractComponent>();
    
	public static void registerComponent(AbstractComponent ac){
		
		registeredComponent.add(ac);
		
	}


}
