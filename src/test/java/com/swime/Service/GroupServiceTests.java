package com.swime.Service;

import com.swime.domain.GroupVO;
import com.swime.service.GroupService;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import static org.junit.Assert.assertNotNull;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.swime.config.RootConfig.class})
@Log4j
public class GroupServiceTests {

    @Setter(onMethod_ = {@Autowired})
    private GroupService service;

    @Test
    public void testExist() {
        log.info(service);
        assertNotNull(service);
    }

    @Test
    public void testRegister() {
        GroupVO group = new GroupVO();

        group.setCategory("GRCA03");
        group.setName("새로운 모임 제목");
        group.setUserId("새로운 모임 id");
        group.setUserName("새로운 name");
        group.setPicture("새로운 모임 picture");
        group.setDescription("새로운 모임 description");
        group.setHeadcount(100L);
        group.setRating(3.5D);
        group.setSido("LODO01");
        group.setSigungu("LOGU15");
        group.setStatus("GRST01");
        group.setRegUserId("새로운 모임장 id");

        service.register(group);
        log.info("생성된 모임 번호: " + group.getSn());
    }

    @Test
    public void testGetList() {
        service.getList().forEach(group -> log.info(group));
    }

    @Test
    public void testGet() {
        log.info(service.get(22L));
    }

    @Test
    public void testDelete() {
        GroupVO group = new GroupVO();
        group.setSn(23L);
        group.setUpdUserId("삭제 id");

        log.info("REMOVE RESULT: " + service.remove(group));
    }

    @Test
    public void testUpdate() {
        GroupVO group = service.get(22L);

        if(group == null) {
            return;
        }

        group.setName("모임명만 수정");
        group.setUpdUserId("수정한 유저id");
        log.info("MODIFY RESULT: " + service.modify(group));
    }




}
