package com.swime.mapper;

import com.swime.domain.MemberHistoryVO;
import com.swime.domain.MemberHistoryVOTests;
import com.swime.domain.MemberVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.omg.CORBA.PUBLIC_MEMBER;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;


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
//        MemberVO memberVO = mapper.read("asd123@naver.com");
        MemberVO memberVO = mapper.read("qwer3871@naver.com");
        Assert.assertNotNull(memberVO);
    }

    @Test
    public void dateFormat(){
//        MemberVO memberVO = mapper.read("asd123@naver.com");
        MemberVO memberVO = mapper.read("qwer2810@naver.com");
        SimpleDateFormat simpleDateFormat = new SimpleDateFormat("YYYY/MM/DD HH:MM:SS");
//        log.info(memberVO.getRegDate());
        String com = "2021/04/95 19:04:00";
//        log.info(simpleDateFormat.format(memberVO.getRegDate()));
        Assert.assertEquals(com, simpleDateFormat.format(memberVO.getRegDate()));
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
    public void updateTest(){
        int random = (int)(Math.random()*10000);
        MemberVO memberVO = mapper.read("qwer2392@naver.com");
        memberVO.setPassword("updatepassword" + random);
        memberVO.setName("이름변경" + random);
        memberVO.setBirth("2010312");
        memberVO.setLastLoginDate(new Date());
        memberVO.setEmailAuth(new Date());
        Assert.assertEquals(mapper.update(memberVO),1);
        log.info(memberVO.getEmailAuth());
    }

    @Test
    public void updateTest2(){
        int random = (int)(Math.random()*10000);
        MemberVO memberVO = mapper.read("qwer3568@naver.com");
        memberVO.setPassword("updatepassword" + random);
        memberVO.setName("이름변경" + random);
        if(memberVO.getLastLoginDate() == null) memberVO.setLastLoginDate(null);
        if(memberVO.getEmailAuth() == null) memberVO.setLastLoginDate(null);
        Assert.assertEquals(mapper.update(memberVO),1);
        log.info(memberVO.getEmailAuth());
    }

    @Test
    public void deleteTest(){
        int random = (int)(Math.random()*10000);
        MemberVO memberVO = new MemberVO();
        memberVO.setId("qwer" + random + "@naver.com");
        memberVO.setName("홍길동" + random);
        memberVO.setPassword("qwer" + random);
        Assert.assertEquals(mapper.insert(memberVO),1);
        Assert.assertEquals(mapper.delete("qwer" + random + "@naver.com"),1);
        Assert.assertNull(mapper.read("qwer" + random + "@naver.com"));
    }

    @Test
    public void getList(){
        mapper.getlist().forEach(log::info);
        Assert.assertNotNull(mapper.getlist());
    }

    @Test
    public void regHist2(){
        MemberHistoryVO vo = new MemberHistoryVO();
        MemberVO memberVO = mapper.read("qwer7044@naver.com");
        vo.setEmail(memberVO.getId());
        vo.setBefVal("asd");
        vo.setAftVal("zxc");
        vo.setUpdMtr("password");
        vo.setDescription("");
        vo.setReason("test01");
        vo.setUpdUserId("qwer7044@naver.com");
        mapper.registerHistory(vo);
    }

    @Test
    public void getHistList(){
        List<MemberHistoryVO> list = mapper.getHistory("qwer7044@naver.com");
        Assert.assertNotNull(list);
        list.forEach(log::info);
    }

    @Test
    public void insertKey(){
        mapper.insertKey("junit테스트","sad78ssasd");
    }

}
