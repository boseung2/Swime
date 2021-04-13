package com.swime.util;

import lombok.extern.log4j.Log4j;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.swime.config.RootConfig.class, com.swime.config.SecurityConfig.class})
@Log4j
public class MakeRandomValueTests {

    @Test
    public void test(){
        String key = new MakeRandomValue().MakeAuthKey();
        Assert.assertNotNull(key);
        Assert.assertEquals(key.length(),20);
        log.info(key);
    }
}
