package com.swime.Service;

import com.swime.domain.MemberVO;
import com.swime.mapper.MemberMapper;
import com.swime.service.MemberHistoryService;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.swime.config.RootConfig.class})
@Log4j
public class MemberHistoryServiceTest {


    @Setter(onMethod_ = @Autowired)
    MemberHistoryService memberHistoryService;
    @Setter(onMethod_ = @Autowired)
    MemberMapper memberMapper;

    @Test
    public void getMappers(){
        Assert.assertNotNull(memberHistoryService);
        Assert.assertNotNull(memberMapper);
    }

    @Test
    public void get(){
        MemberVO memberVO = memberMapper.read("qwer9386@naver.com");
        Assert.assertNotNull(memberVO);
        memberHistoryService.registerHistory(memberVO,"qwer9386@naver.com", null);
    }
}
