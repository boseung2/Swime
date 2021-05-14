package com.swime.mapper;

import com.swime.domain.DashBoardLangVO;
import com.swime.domain.DashBoardLocaleVO;
import com.swime.domain.DashBoardModalDataVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

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
    @Test
    public void date(){
        log.info(mapper.test(2031,03, 12));
        log.info(mapper.test(2021,5, 7));
        log.info(mapper.countUserRegisterByParam(2021,5, 7));
    }

    @Test
    public void visit1(){
        int t1 = mapper.getVisitCount();
        mapper.visitCountUp();
        int t2 = mapper.getVisitCount();

        Assert.assertTrue(t1 < t2);
        int a = mapper.getVisitCountByTime(2021,5,8,20);
        log.info(a);
    }

    @Test
    public void tag(){
        List<DashBoardLangVO> list = mapper.getDashBoardLang();

        Assert.assertNotNull(list);
        list.forEach(log::info);
    }

    @Test
    public void locale(){
        List<DashBoardLocaleVO> list = mapper.getDashBoardLocale();

        Assert.assertNotNull(list);
        list.forEach(log::info);
    }

    @Test
    public void getTodayUserRegister(){
        List<DashBoardModalDataVO> list = mapper.todayUserRegister();
        Assert.assertNotNull(list);
        list.forEach(log::info);

    }

    @Test
    public void getTodayGroupRegister(){
        List<DashBoardModalDataVO> list = mapper.todayGroupRegister();
        Assert.assertNotNull(list);
        list.forEach(log::info);

    }

    @Test
    public void getTodayStudyRegister(){
        List<DashBoardModalDataVO> list = mapper.todayStudyRegister();
        Assert.assertNotNull(list);
        list.forEach(log::info);

    }

    @Test
    public void testDate2(){
        mapper.test2();
        log.info(mapper.test2());
    }
}
