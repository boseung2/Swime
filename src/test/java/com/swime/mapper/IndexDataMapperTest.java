package com.swime.mapper;

import com.swime.domain.GroupVO;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.swime.config.RootConfig.class, com.swime.config.SecurityConfig.class})
@Log4j
public class IndexDataMapperTest {

    @Setter(onMethod_ = @Autowired)
    IndexDataMapper indexDataMapper;

    @Test
    public void getMapper(){
        Assert.assertTrue(indexDataMapper != null);
    }

    @Test
    public void test1(){
        List<GroupVO> list = indexDataMapper.test(1,6);
        Assert.assertTrue(list != null);

        list.forEach(log::info);
    }
}