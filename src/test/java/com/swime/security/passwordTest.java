package com.swime.security;

import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.swime.config.RootConfig.class, com.swime.config.SecurityConfig.class})
@Log4j
public class passwordTest {

    @Setter(onMethod_ = @Autowired)
    private PasswordEncoder passwordEncoder;

    @Test
    public void test(){
        String password = "123asd456!@";
        String encode = passwordEncoder.encode(password);
        log.info(encode);
        Assert.assertNotNull(encode);
        log.info("$2a$10$3Ni0ql2CQT5/tTV6tyO26eJ32sr/sRSw.8wCiDu/7u0NCEUhO7Zli".length()); // 60
    }
}
