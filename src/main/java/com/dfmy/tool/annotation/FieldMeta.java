package com.dfmy.tool.annotation;

import java.lang.annotation.Documented;
import java.lang.annotation.Inherited;
import java.lang.annotation.Retention;
import java.lang.annotation.Target;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.ElementType;

/**
 * 数据表字段注解定义
 * @author wang
 */
@Retention(RetentionPolicy.RUNTIME) 
@Target({ElementType.FIELD,ElementType.METHOD})
@Inherited
@Documented
public @interface  FieldMeta {
	
	/**
	 * 表字段名称
	 * @return
	 */
	String fieldName () default "";
	

}
