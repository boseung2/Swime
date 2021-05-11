package com.swime.aop;

import lombok.extern.log4j.Log4j;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.ModelAndView;

import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

@Aspect
@Log4j
@Component
public class ExceptionAdvice {

//    @Around("execution(* com.swime.*Controller.*(..))")
//    public ModelAndView around(ProceedingJoinPoint pjp) {
//        ModelAndView mav = null;
//
//        try {
//            mav = (ModelAndView) pjp.proceed();
//        } catch(SQLException e){
//            mav = new ModelAndView("jsonView");
//            e.printStackTrace();
//            Map<String, Object> result = new HashMap<String, Object>();
//
//            result.put("result_cd", e.getErrCode());
//            result.put("result_msg", e.getMessage());
//
//            mav.addAllObjects(result);
//        } catch (Exception e) {
//            mav = new ModelAndView("jsonView");
//            e.printStackTrace();
//            Map<String, Object> result = new HashMap<String, Object>();
//
//            result.put("result_cd", 0);
//            result.put("result_msg", e.getMessage());
//
//            mav.addAllObjects(result);
//        }
//        return mav;
//    }
}
