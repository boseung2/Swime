package com.swime.Service;

import com.swime.domain.MemberHistoryVO;
import com.swime.domain.MemberVO;
import com.swime.service.GroupWishService;
import com.swime.service.MemberService;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.Date;
import java.util.List;

import static org.junit.Assert.assertNotNull;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.swime.config.RootConfig.class})
@Log4j
public class GroupWishServiceTests {

    @Setter(onMethod_ = @Autowired)
    private GroupWishService service;


    @Test
    public void getService() {
        log.info(service);
        assertNotNull(service);
    }

    

}
