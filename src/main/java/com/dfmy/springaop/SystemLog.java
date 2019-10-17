package com.dfmy.springaop;

import java.lang.annotation.*;
@Target({ElementType.PARAMETER, ElementType.METHOD})  
@Retention(RetentionPolicy.RUNTIME)  
@Documented 
public @interface SystemLog {
    String module()  default "";  
    String methods()  default ""; 
}
