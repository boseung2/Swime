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
}
