package com.swime.mapper;

import com.swime.domain.GroupCriteria;
import com.swime.domain.GroupVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.swime.config.RootConfig.class})
@Log4j
public class GroupMapperTests {

    @Setter(onMethod_ = @Autowired)
    private GroupMapper mapper;

    @Test
    public void testInsert() {
        GroupVO group = new GroupVO();

        group.setCategory("GRCA02");
        group.setName("테스트제목");
        group.setUserId("테스트 id");
        group.setUserName("테스트 name");
        group.setPicture("테스트 picture");
        group.setDescription("테스트 description");
        group.setInfo("테스트 모임정보");
        group.setSido("LODO01");
        group.setSigungu("LOGU02");
        group.setRegUserId("테스트 id");

        mapper.insert(group);
        log.info(group);
    }

    @Test
    public void testInsertSelectKey() {
        GroupVO group = new GroupVO();

        group.setCategory("GRCA02");
        group.setName("테스트제목");
        group.setUserId("테스트 id");
        group.setUserName("테스트 name");
        group.setPicture("테스트 picture");
        group.setDescription("테스트 description");
        group.setInfo("테스트 모임정보");
        group.setSido("LODO01");
        group.setSigungu("LOGU02");
        group.setRegUserId("테스트 id");

        mapper.insertSelectKey(group);
        log.info(group);
    }

    @Test
    public void testRead() {
        GroupVO group = mapper.read(70L);
        log.info(group);
    }

    @Test
    public void testGetList() {
        mapper.getList().forEach(group -> log.info(group));
    }

    @Test
    public void testPaging() {
        GroupCriteria cri = new GroupCriteria();
        List<GroupVO> list = mapper.getListWithPaging(cri);
        list.forEach(group -> log.info(group));
    }

    @Test
    public void testPaging2() {
        GroupCriteria cri = new GroupCriteria();
        cri.setPageNum(1);
        cri.setAmount(6);
        List<GroupVO> list = mapper.getListWithPaging(cri);
        list.forEach(group -> log.info(group.getSn()));
    }

    @Test
    public void testUpdate() {
        GroupVO group = new GroupVO();
        group.setSn(24L);
        group.setCategory("GRCA02");
        group.setName("수정된 이름");
        group.setUserId("수정된 id");
        group.setUserName("수정된 name");
        group.setPicture("수정된 picture");
        group.setDescription("수정된 description");
        group.setHeadcount(10L);
        group.setRating(4.5D);
        group.setSido("LODO01");
        group.setSigungu("LOGU02");
        group.setStatus("GRST01");
        group.setUpdUserId("수정 user id");

        int count = mapper.update(group);
        log.info("UPDATE COUNT: " + count);
    }

    @Test
    public void testDelete() {
        GroupVO group = new GroupVO();
        group.setSn(23L);
        group.setUpdUserId("삭제 id");

        int count = mapper.delete(group);
        log.info("DELETE COUNT: " + count);
    }


}
