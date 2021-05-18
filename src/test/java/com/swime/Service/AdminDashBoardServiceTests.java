package com.swime.Service;

import com.swime.service.AdminDashBoardService;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.swime.config.RootConfig.class})
@Log4j
public class AdminDashBoardServiceTests {

    @Setter(onMethod_ = {@Autowired})
    AdminDashBoardService service;

    @Test
    public void getService(){
        Assert.assertNotNull(service);
    }

    @Test
    public void test(){
        Integer[] result = service.countUserRegisterByParam(2021,5);
        Arrays.stream(result).forEach(x->log.info(x));
    }

    @Test
    public void test1(){
        Integer[] result = service.getVisitCountByTime(2021,5,8);
        Arrays.stream(result).forEach(x->{
            if(x!=null) log.info(x);
        });
    }

    @Test
    public void cookieTime(){

        Calendar cal = Calendar.getInstance();
        int h = cal.get(Calendar.HOUR_OF_DAY);
        int m = cal.get(Calendar.MINUTE);
        int s = cal.get(Calendar.SECOND);



        log.info(String.format("현재시간은 %d:%d:%d 입니다", h, m, s));
        log.info((h*60*60)+(m*60)+s);
        log.info(60*60*24);
        int now = (h*60*60)+(m*60)+s;
        int day = 60*60*24;
        log.info(day-now);
    }


}
