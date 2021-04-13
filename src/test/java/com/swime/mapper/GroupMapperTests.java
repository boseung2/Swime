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
@ContextConfiguration(classes = {com.swime.config.RootConfig.class, com.swime.config.SecurityConfig.class})
@Log4j
public class GroupMapperTests {

    @Setter(onMethod_ = @Autowired)
    private GroupMapper mapper;

    @Test
    public void testInsertSelectKey() {
        GroupVO group = new GroupVO();

        group.setCategory("GRCA02");
        group.setName("아녕하세요");
        group.setUserId("jungbs3726@naver.com");
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
        GroupVO group = mapper.read(256L);
        log.info(group);
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
        GroupVO group = mapper.read(98L);
        group.setCategory("GRCA02");
        group.setName("수정된 이름");
        group.setUserId("boseung@naver.com");
        group.setPicture("수정된 picture");
        group.setDescription("수정된 description");
        group.setSido("LODO01");
        group.setSigungu("LOGU02");
        group.setStatus("GRST01");
        int count = mapper.update(group);
        log.info("UPDATE COUNT: " + count);
    }

    @Test
    public void testUpdateInfo() {
        GroupVO group = new GroupVO();
        group.setSn(96L);
        group.setInfo("update test info info info info info fino");

        int count = mapper.updateInfo(group);
        log.info("UPDATE COUNT: " + count);
    }

    @Test
    public void testDelete() {
        GroupVO group = new GroupVO();
        group.setSn(102L);
        group.setUserId("boseung@naver.com");

        int count = mapper.delete(group);
        log.info("DELETE COUNT: " + count);
    }

}
