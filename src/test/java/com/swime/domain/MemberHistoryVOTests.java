package com.swime.domain;

import lombok.extern.log4j.Log4j;
import org.junit.Test;


@Log4j
public class MemberHistoryVOTests {
    @Test
    public void VO(){
        MemberHistoryVO vo = new MemberHistoryVO();
        vo.setEmail("");
        vo.setBefVal("");
        vo.setAftVal("");
        vo.setUpdMtr("");
        vo.setDescription("");
        vo.setReason("");
        vo.setUpdUserId("");
        log.info(vo);
    }
}
