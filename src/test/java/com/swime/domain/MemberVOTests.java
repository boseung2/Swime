package com.swime.domain;

import lombok.extern.log4j.Log4j;
import org.junit.Test;

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
}
