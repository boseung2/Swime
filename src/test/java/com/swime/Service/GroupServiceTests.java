package com.swime.Service;

import com.swime.domain.GroupCriteria;
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

        group.setCategory("GRCA05");
        group.setName("새로운 모임 제목");
        group.setUserId("jungbs3726@naver.com");
        group.setPicture("새로운 모임 picture.png");
        group.setDescription("새로운 모임 description");
        group.setInfo("새로운 모임 정보 infoinfofinfonofinfoifnofino");
        group.setSido("LOSI01");
        group.setSigungu("LOGU15");
        group.setRegUserId("jungbs3726@naver.com");

        service.register(group);
        log.info("생성된 모임 번호: " + group.getSn());
    }

    @Test
    public void testGet() {
        log.info(service.get(117L));
    }

    @Test
    public void testGetListWithPaging() {
        service.getListWithPaging(new GroupCriteria(1, 6)).forEach(group -> log.info(group));
    }

    @Test
    public void testModify() {
        GroupVO group = service.get(117L);

        if(group == null) {
            return;
        }

        group.setName("어떻게 수정되는거지?");
        group.setUserId("수정한 유저id");
        log.info("MODIFY RESULT: " + service.modify(group));
    }

    @Test
    public void testRemove() {
        GroupVO group = new GroupVO();
        group.setSn(102L);
        group.setUserId("삭제 id");

        log.info("REMOVE RESULT: " + service.remove(group));
    }

}
