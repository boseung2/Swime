package com.swime.Service;

import com.swime.domain.GroupCriteria;
import com.swime.domain.GroupVO;
import com.swime.service.GroupService;
import com.swime.service.ProfileService;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.ArrayList;
import java.util.List;

import static org.junit.Assert.assertNotNull;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.swime.config.RootConfig.class, com.swime.config.SecurityConfig.class})
@Log4j
public class ProfileServiceTests {

    @Setter(onMethod_ = {@Autowired})
    private ProfileService service;

    final private String id = "tht1234551@gmail.com";

    @Test
    public void getService(){
        Assert.assertNotNull(service);
    }

    @Test
    public void getOwnerList(){
        List<GroupVO> list = service.getOwnerGroupList(id);
        Assert.assertNotNull(list);
        list.forEach(log::info);
    }

    @Test
    public void readTest(){
        GroupVO groupVO = service.read(678L, id);
        Assert.assertNotNull(groupVO);
        log.info(groupVO);
    }
}
