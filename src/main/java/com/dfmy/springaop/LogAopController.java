package com.dfmy.springaop;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.Signature;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.dfmy.entity.ResultEntity;
import com.dfmy.entity.sys.SysLog;
import com.dfmy.service.sys.SysLogService;
import com.dfmy.util.GetIPUtil;

@Aspect
public class LogAopController {
	//注入service,用来将日志信息保存在数据库
    @Autowired
    private SysLogService sysLogService;
    
     //配置接入点,如果不知道怎么配置,可以百度一下规则
     //@Pointcut("execution(* com.dfmy.springaop.*.*(..))")
     @Pointcut("@annotation(com.dfmy.springaop.SystemLog)")
     private void controllerAspect(){}//定义一个切入点
 
     @Around("controllerAspect()")
     public Object around(ProceedingJoinPoint pjp) throws Throwable {
         //常见日志实体对象
         SysLog log = new SysLog(); 
         //获取登录用户账户
         HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
         Subject currentUser = SecurityUtils.getSubject();
         String userName = (String)currentUser.getPrincipal();
         //获取系统时间
         String time = new SimpleDateFormat("YYYY-MM-dd HH:mm:ss").format(new Date());
         //log.setDATA(time);
         log.setCreatetime(time);
         
         //获取系统ip,这里用的是我自己的工具类,可自行网上查询获取ip方法
         String ip = GetIPUtil.getIP(request);
         log.setIp(ip);
         
        //方法通知前获取时间,为什么要记录这个时间呢？当然是用来计算模块执行时间的
         long start = System.currentTimeMillis();
        // 拦截的实体类，就是当前正在执行的controller
        Object target = pjp.getTarget();
        // 拦截的方法名称。当前正在执行的方法
        String methodName = pjp.getSignature().getName();
        // 拦截的方法参数
        Object[] args = pjp.getArgs();
        // 拦截的放参数类型
        Signature sig = pjp.getSignature();
        MethodSignature msig = null;
        if (!(sig instanceof MethodSignature)) {
            throw new IllegalArgumentException("该注解只能用于方法");
        }
        msig = (MethodSignature) sig;
        Class[] parameterTypes = msig.getMethod().getParameterTypes();
        
        Object object = null;
        // 获得被拦截的方法
        Method method = null;
        try {
            method = target.getClass().getMethod(methodName, parameterTypes);
        } catch (NoSuchMethodException e1) {
            // TODO Auto-generated catch block
            e1.printStackTrace();
        } catch (SecurityException e1) {
            // TODO Auto-generated catch block
            e1.printStackTrace();
        }
        if (null != method) {
            // 判断是否包含自定义的注解，说明一下这里的SystemLog就是我自己自定义的注解
            if (method.isAnnotationPresent(SystemLog.class)) {
                SystemLog systemlog = method.getAnnotation(SystemLog.class);
                System.out.println(systemlog.module());
                System.out.println(systemlog.methods());
                log.setOper(systemlog.module());
                log.setBusinssName(systemlog.methods());
                try {
                    object = pjp.proceed();
                    String userSessionName = (String)request.getSession().getAttribute("userName");
                    log.setCreateuser(userSessionName);
                    long end = System.currentTimeMillis();
                    //将计算好的时间保存在实体中
                    log.setDescription(""+(end-start));
                    Field fi = object.getClass().getDeclaredField("success");
                    fi.setAccessible(true);
                    if(fi != null){
                    	if("1".equals(fi.get(object).toString())){
                    		log.setIsSuccess("执行成功！");
                    	}else {
                    		log.setIsSuccess("执行失败！");
                    	}
                    }
                    //保存进数据库
                    sysLogService.save(log);
                } catch (Throwable e) {
                	e.printStackTrace();
                	String userSessionName = (String)request.getSession().getAttribute("userName");
                    log.setCreateuser(userSessionName);
                    // TODO Auto-generated catch block
                    long end = System.currentTimeMillis();
                    log.setDescription(""+(end-start));
                    log.setIsSuccess("执行失败");
                    sysLogService.save(log);
                }
            } else {//没有包含注解
                object = pjp.proceed();
            }
        } else { //不需要拦截直接执行
            object = pjp.proceed();
        }
        return object;
     }

}
