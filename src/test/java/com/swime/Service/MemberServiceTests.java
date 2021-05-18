package com.swime.Service;

import com.swime.domain.AdminUserCriteria;
import com.swime.domain.MemberDTO;
import com.swime.domain.MemberHistoryVO;
import com.swime.domain.MemberVO;
import com.swime.mapper.MemberMapper;
import com.swime.service.MemberService;
import com.swime.service.MemberServiceImpl;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.Date;
import java.util.List;
import java.util.Map;

import static org.junit.Assert.assertNotNull;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.swime.config.RootConfig.class, com.swime.config.SecurityConfig.class})
@Log4j
public class MemberServiceTests {

    @Setter(onMethod_ = @Autowired)
    private MemberService service;

    @Setter(onMethod_ = @Autowired)
    private PasswordEncoder passwordEncoder;


    @Test
    public void getService() {
        log.info(service);
        log.info(passwordEncoder);
        assertNotNull(service);
        assertNotNull(passwordEncoder);
    }


    @Test
    public void get(){
        Assert.assertNotNull(service.get("asd123@naver.com"));
    }

    @Test
    public void testRegister() {

        MemberVO memberVO = new MemberVO();
        int random = (int)(Math.random() * 10000);

        memberVO.setId("hong" + random + "@service.com");
        memberVO.setName("서비스" + random);
        memberVO.setPassword("service" + random);

        Assert.assertTrue(service.register(memberVO));
    }

    @Test
    public void testModify(){
        MemberVO memberVO = service.get("hong5584@service.com");
        memberVO.setPassword("modifypassword");
        memberVO.setBirth("2010312");
        memberVO.setLastLoginDate(new Date());
        memberVO.setEmailAuth(new Date());

        MemberHistoryVO hvo = new MemberHistoryVO();

        Assert.assertTrue(service.modify(memberVO, hvo));
    }

    @Test
    public void changePw(){
        MemberVO memberVO = service.get("hong5584@service.com");
        memberVO.setPassword("modifypassword");
        MemberHistoryVO hvo = new MemberHistoryVO();
        Assert.assertTrue(service.modify(memberVO, hvo));
    }
    
    @Test
    public void testDelete(){
        MemberVO memberVO = new MemberVO();
        int random = (int)(Math.random() * 10000);

        memberVO.setId("hong"+ random+"@service.com");
        memberVO.setName("삭제테스트" + random);
        memberVO.setPassword("service" + random);
        service.register(memberVO);
        memberVO.setStatus("USST03");
        MemberHistoryVO hvo = new MemberHistoryVO();
        hvo.setEmail("hong"+ random+"@service.com");
        Assert.assertTrue(service.remove("hong"+ random+"@service.com", hvo));
    }

    @Test
    public void testGetlist(){
        List<MemberVO> list = service.getlist();
        Assert.assertNotNull(list);
        list.forEach(log::info);
    }

    @Test
    public void histResult(){
        MemberVO before = service.get("qwer7044@naver.com");
        MemberVO after = service.get("qwer7044@naver.com");
        after.setId("qwer7044@naver.com");
        after.setName("차단된 유저1");
        after.setPassword("qdfgswe123");
        after.setStatus("USST05");

        MemberHistoryVO vo = new MemberHistoryVO();
        vo.setEmail("qwer7044@naver.com");
        vo.setDescription("서비스테스트중");
        vo.setReason("test01");
        vo.setUpdUserId("형진");

        service.registerHistory(after,vo);
    }

    @Test
    public void getHistList(){
        List<MemberHistoryVO> list = service.getHistList("qwer7044@naver.com");
        list.forEach(log::info);
    }

    @Test
    public void getAlluser(){
        MemberDTO dto = service.selectAllMember(new AdminUserCriteria());
        log.info(dto.getCount());
        dto.getList().forEach(log::info);
    }

}
