package com.swime.Service;

import com.swime.domain.GroupWishVO;
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
@ContextConfiguration(classes = {com.swime.config.RootConfig.class, com.swime.config.SecurityConfig.class})
@Log4j
public class GroupWishServiceTests {

    @Setter(onMethod_ = @Autowired)
    private GroupWishService service;


    @Test
    public void getService() {
        log.info(service);
        assertNotNull(service);
    }

    @Test
    public void register(){
        int random = (int)(Math.random() * 10) + 1;
        GroupWishVO vo = new GroupWishVO();
        vo.setGrpSn((long)random);
        vo.setUserId(random + "rla123@naver.com");
        Assert.assertTrue(service.register(vo));
    }

    @Test
    public void delete(){
        int random = (int)(Math.random() * 10000) + 1;
        log.info(random);
        GroupWishVO vo = new GroupWishVO();
        vo.setGrpSn((long)random);
        vo.setUserId(random + "rla123@naver.com");
        Assert.assertTrue(service.register(vo));
        Assert.assertTrue(service.remove(random + "rla123@naver.com", (long)random));
    }

    @Test
    public void readbyid(){
        List<GroupWishVO> vo = service.getByid("5rla123@naver.com");
        Assert.assertNotNull(vo);
        vo.forEach(log::info);
    }

    @Test
    public void readbyGroupSn(){
        List<GroupWishVO> vo = service.getByGroupSn(5L);
        Assert.assertNotNull(vo);
        vo.forEach(log::info);
    }
}
