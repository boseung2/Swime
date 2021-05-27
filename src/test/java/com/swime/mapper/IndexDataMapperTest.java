package com.swime.mapper;

import com.swime.domain.GroupVO;
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
public class IndexDataMapperTest {

    @Setter(onMethod_ = @Autowired)
    IndexDataMapper mapper;

    @Test
    public void getMapper(){
        Assert.assertTrue(mapper != null);
    }

    @Test
    public void test1(){
        List<GroupVO> list = mapper.popularGroupList(1,6);
        Assert.assertTrue(list != null);

        list.forEach(log::info);
    }

    @Test
    public void testPopularStuddyList(){
        List<StudyVO> list = mapper.popularStudyList(1,6);
        Assert.assertTrue(list != null);

        list.forEach(log::info);
    }

    @Test
    public void test2(){
        mapper.timeTest();
        mapper.setSessionTime();
        mapper.timeTest();
    }
}