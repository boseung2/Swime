package com.swime.Service;

import com.swime.domain.GroupAttendVO;
import com.swime.service.GroupAttendService;
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
public class GroupAttendServiceTests {

    @Setter(onMethod_ = {@Autowired})
    private GroupAttendService service;

    @Test
    public void testExist() {
        log.info(service);
        assertNotNull(service);
    }

    @Test
    public void testAttend() {
        GroupAttendVO groupAttend = new GroupAttendVO();
        groupAttend.setGrpSn(196L);
        groupAttend.setUserId("boseung@naver.com");
        groupAttend.setGrpRole("GRRO02");
        groupAttend.setStatus("GRUS01");
        service.attend(groupAttend);
    }

    @Test
    public void testGetList() {
        log.info(service.getList(102L));
    }

    @Test
    public void testGetAttendCountByGroupSn() {
        service.getAttendCountByGroupSn(100L);
    }

    @Test
    public void testBan() {
        GroupAttendVO vo = new GroupAttendVO();
        vo.setGrpSn(316L);
        vo.setUserId("jungbs3726@naver.com");
        GroupAttendVO groupAttend = service.get(vo);
        service.ban(groupAttend);
    }

    @Test
    public void testGet() {
        GroupAttendVO groupAttend = new GroupAttendVO();
        groupAttend.setGrpSn(102L);
        groupAttend.setUserId("boseung@naver.com");

        service.get(groupAttend);
    }


}
