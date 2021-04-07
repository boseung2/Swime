package com.swime.mapper;


import com.swime.domain.GroupWishVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.swime.config.RootConfig.class})
@Log4j
public class GroupWishMapperTests {

    @Setter(onMethod_ = @Autowired)
    GroupWishMapper mapper;

    @Test
    public void getMapper(){
        Assert.assertNotNull(mapper);
    }

    @Test
    public void insert(){
        int random = (int)(Math.random() * 10) + 1;
        GroupWishVO vo = new GroupWishVO();
        vo.setGrpSn((long)random);
        vo.setUserId(random + "rla123@naver.com");
        Assert.assertEquals(mapper.insert(vo), 1);
    }

    @Test
    public void delete(){
        int random = (int)(Math.random() * 10000) + 1;
        log.info(random);
        GroupWishVO vo = new GroupWishVO();
        vo.setGrpSn((long)random);
        vo.setUserId(random + "rla123@naver.com");
        Assert.assertEquals(mapper.insert(vo), 1);
        Assert.assertEquals(mapper.delete(random + "rla123@naver.com"),1);
    }

    @Test
    public void readbyid(){
        List<GroupWishVO> vo = mapper.readByid("5rla123@naver.com");
        Assert.assertNotNull(vo);
        vo.forEach(log::info);
    }

    @Test
    public void readbyGroupSn(){
        List<GroupWishVO> vo = mapper.readByGroupSn(5L);
        Assert.assertNotNull(vo);
        vo.forEach(log::info);
    }
}
