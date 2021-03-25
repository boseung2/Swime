package com.swime.persistence;

import com.swime.domain.GroupVO;
import com.swime.mapper.GroupMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.security.acl.Group;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes={com.swime.config.RootConfig.class})
@Log4j
public class GroupMapperTests {

    @Setter(onMethod_ = @Autowired)
    private GroupMapper mapper;

    @Test
    public void testGetGroupList() {
        mapper.getGroupList().forEach(group -> log.info(group));
    }

    @Test
    public void testInsertGroup() {
        GroupVO group = new GroupVO();
        group.setName("자바의 정석");
        group.setCap(30);
        group.setInfo("자바의 정석 모임입니다.");
        group.setPic("https://maps.gstatic.com/mapfiles/place_api/icons/v1/png_71/cafe-71.png");
        group.setRep("임지호");
        group.setLangNum1("01");
        group.setRegn_sido("02");
        group.setRegn_sgg("07");

        mapper.insertGroup(group);

        log.info(group);
    }
}
