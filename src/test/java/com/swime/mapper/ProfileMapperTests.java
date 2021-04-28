package com.swime.mapper;

import com.swime.domain.AuthVO;
import com.swime.domain.GroupVO;
import com.swime.domain.ProfileCriteria;
import com.swime.domain.StudyVO;
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
@ContextConfiguration(classes = {com.swime.config.RootConfig.class, com.swime.config.SecurityConfig.class})
@Log4j
public class ProfileMapperTests {

    @Setter(onMethod_ = @Autowired)
    private ProfileMapper mapper;

    final String id = "tht1234551@gmail.com";

    final ProfileCriteria profileCriteria = new ProfileCriteria();

    @Test
    public void getMapper(){
        Assert.assertNotNull(mapper);
    }

    @Test
    public void getOwnerList(){
        List<GroupVO> list = mapper.ownerList(id);
        Assert.assertNotNull(list);
        list.forEach(log::info);
    }

    @Test
    public void readTest(){
        GroupVO groupVO = mapper.read(678L, id);
        Assert.assertNotNull(groupVO);
        log.info(groupVO);
    }

    @Test
    public void joinList(){
        List<GroupVO> list = mapper.joinList(id);
        Assert.assertNotNull(list);
        list.forEach(log::info);
    }

    @Test
    public void joinListWithPaging(){
        List<GroupVO> list = mapper.joinListWithPaging(id, profileCriteria);
        Assert.assertNotNull(list);
        list.forEach(log::info);
    }

    @Test
    public void joinTotal(){
        int count = mapper.joinListCount(id);
        log.info(count);
    }

    @Test
    public void ownerListWithPaging(){
        List<GroupVO> list = mapper.ownerListWithPaging(id, profileCriteria);
        Assert.assertNotNull(list);
        list.forEach(log::info);
    }

    @Test
    public void wishListWithPaging(){
        List<GroupVO> list = mapper.wishListWithPaging(id, profileCriteria);
        Assert.assertNotNull(list);
        list.forEach(log::info);
    }

    @Test
    public void ownerTotal(){
        int count = mapper.ownerListCount(id);
        log.info(count);
    }

    @Test
    public void wishTotal(){
        int count = mapper.wishListCount(id);
        log.info(count);
    }

    @Test
    public void makeStudy(){
        List<StudyVO> list = mapper.makeStudyList(id, profileCriteria);
        list.forEach(log::info);
    }

    @Test
    public void makeStudy2(){
        List<StudyVO> list = mapper.makeStudyList(id, new ProfileCriteria(2,6));
        list.forEach(log::info);
    }
}
