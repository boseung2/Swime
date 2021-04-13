package com.swime.aop;

import lombok.extern.log4j.Log4j;
import org.aspectj.lang.annotation.After;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.springframework.stereotype.Component;

@Aspect
@Log4j
@Component
public class UpdateGroupAdvice {
    // GroupAttendService aop 테스트용
    @Before("execution(* com.swime.service.GroupAttendService*.*(..))")
    public void logBefore() {
        log.info("========================");
    }

}
