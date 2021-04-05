package com.swime.mapper;

import com.swime.domain.MemberVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.sql.Date;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.swime.config.RootConfig.class})
@Log4j
public class MemberMapperTests {

    @Setter(onMethod_ = @Autowired)
    MemberMapper mapper;

    @Test
    public void getMapper(){
        log.info(mapper);
        Assert.assertNotNull(mapper);
    }

    @Test
    public void readTest(){
        MemberVO memberVO = mapper.read("asd123@naver.com");
        log.info(memberVO);
    }

    @Test
    public void insertTest() {
        int random = (int)(Math.random()*10000);
        MemberVO memberVO = new MemberVO();
        memberVO.setId("qwer" + random + "@naver.com");
        memberVO.setName("홍길동" + random);
        memberVO.setPassword("qwer" + random);
        Assert.assertEquals(mapper.insert(memberVO),1);
    }

    @Test
    public void readWithdate(){
//        MemberVO memberVO = mapper.readwithdate("qwer7521@naver.com");
//        log.info(memberVO);
        log.info(mapper.readwithdate("qwer7521@naver.com").getEmailAuth());
    }

    @Test
    public void updateTest(){
        int random = (int)(Math.random()*10000);
        MemberVO memberVO = mapper.read("qwer7521@naver.com");
        memberVO.setPassword("updatepassword" + random);
        memberVO.setName("이름변경" + random);
        memberVO.setBirth(new Date(2010,3,12));
        memberVO.setLastLoginDate(new Date(2021,4,5));
        memberVO.setEmailAuth(new Date(2021,4,5));
        Assert.assertEquals(mapper.update(memberVO),1);
    }
}
