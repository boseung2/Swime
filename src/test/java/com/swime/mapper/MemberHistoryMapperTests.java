package com.swime.mapper;

import com.swime.domain.MemberHistoryVO;
import com.swime.domain.MemberVO;
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
public class MemberHistoryMapperTests {

    @Setter(onMethod_ = @Autowired)
    MemberHistoryMapper mapper;

    @Setter(onMethod_ = @Autowired)
    MemberMapper memberMapper;

    @Test
    public void getMapper(){
        log.info(mapper);
        Assert.assertNotNull(mapper);
    }

    @Test
    public void insert(){
        MemberHistoryVO vo = new MemberHistoryVO();
        MemberVO memberVO = memberMapper.read("qwer7044@naver.com");
        vo.setBefVal(memberVO.getName());
        memberVO.setName("이력asd");
        vo.setAftVal(memberVO.getName());
        vo.setEmail(memberVO.getId());
        vo.setUpdMtr("name");
        vo.setReason("test01");
        vo.setDescription("이력테스트중");
        vo.setUpdUserId("qwer7044@naver.com");
        mapper.insert(vo);
    }

}
