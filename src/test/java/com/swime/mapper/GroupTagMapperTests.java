package com.swime.mapper;

import com.swime.domain.GroupTagVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.swime.config.RootConfig.class})
@Log4j
public class GroupTagMapperTests {

    @Setter(onMethod_ = @Autowired)
    private GroupTagMapper mapper;

    @Test
    public void testInsert() {
        GroupTagVO groupTag = new GroupTagVO();
        groupTag.setGrpSn(224L);
        groupTag.setName("GRTG05");

        mapper.insert(groupTag);
    }

    @Test
    public void testGetList() {
        mapper.getList(223L);
    }

    @Test
    public void testDelete() {
        GroupTagVO groupTag = new GroupTagVO();
        groupTag.setGrpSn(223L);
        groupTag.setName("GRTG03");

        mapper.delete(groupTag);
    }

}
