package com.swime.mapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.swime.config.RootConfig.class, com.swime.config.SecurityConfig.class})
@Log4j
public class AdminDashBoardTests {

    @Setter(onMethod_ = @Autowired)
    private AdminDashBoardMapper mapper;

    @Test
    public void countUser(){
        log.info(mapper.countTodayUserRegister());
        log.info(mapper.countTodayGroupRegister());
        log.info(mapper.countTodayStudyRegister());
    }
}
