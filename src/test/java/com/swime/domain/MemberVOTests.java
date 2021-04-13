package com.swime.domain;

import lombok.extern.log4j.Log4j;
import org.junit.Test;

import java.util.Date;

@Log4j
public class MemberVOTests {
    @Test
    public void VO(){
        MemberVO memberVO = new MemberVO();
        memberVO.setId("qwe123@naver.com");
        memberVO.setName("홍길동");
        memberVO.setPassword("qwe123");
        log.info(memberVO);

    }

    @Test
    public void dateTest(){
        MemberVO memberVO = new MemberVO();
        memberVO.setLastLoginDate(new Date());
        log.info(memberVO.getLastLoginDate());
    }
}
