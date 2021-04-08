package com.swime.mapper;

import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.swime.config.RootConfig.class, com.swime.config.SecurityConfig.class})
@Log4j
public class AuthMapperTests {

    @Setter(onMethod_ = @Autowired)
    private AuthMapper mapper;

    private int random = (int)(Math.random()*10000);

    @Test
    public void getmapper(){
        Assert.assertNotNull(mapper);
    }

    @Test
    public void insert(){
        Assert.assertTrue(mapper.insert("asd@naver.com","ADMIN") == 1);
        Assert.assertTrue(mapper.insert("asd@naver.com","MEMBER") == 1);
        Assert.assertTrue(mapper.insert("asd22@naver.com","MEMBER") == 1);
    }

    @Test
    public void delete(){
        Assert.assertTrue(mapper.insert(random + "asd@naver.com","ADMIN") == 1);
        Assert.assertTrue(mapper.delete(random + "asd@naver.com","ADMIN") == 1);
    }
}
