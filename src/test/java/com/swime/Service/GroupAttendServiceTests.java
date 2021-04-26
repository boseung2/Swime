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
        groupAttend.setGrpSn(1040L);
        groupAttend.setUserId("jungbs3726@gmail.com");
        service.attend(groupAttend);
    }

    @Test
    public void testGetList() {
        log.info(service.getList(1040L));
    }

    @Test
    public void testGetListWithBan() {
        log.info(service.getListWithBan(1040L));
    }

    @Test
    public void testWithdraw() {
        GroupAttendVO groupAttend = new GroupAttendVO();
        groupAttend.setGrpSn(1040L);
        groupAttend.setUserId("jungbs3726@gmail.com");
        service.withdraw(groupAttend);
    }

    @Test
    public void testGetAttendCountByGroupSn() {
        service.getAttendCountByGroupSn(100L);
    }

    @Test
    public void testGet() {
        GroupAttendVO groupAttend = new GroupAttendVO();
        groupAttend.setGrpSn(102L);
        groupAttend.setUserId("boseung@naver.com");

        service.get(316L);
    }

    @Test
    public void testChangeLeader() {
        service.changeLeader(1275L);
    }


    @Test
    public void testChangeManager() {
        service.changeManager(1269L);
    }

    @Test
    public void testCancleManager() {
        service.cancelManager(1269L);
    }
    @Test
    public void testBan() {
        service.ban(1274L);
    }

    @Test
    public void testBanPermanent() {
        service.banPermanent(1273L);
    }

    @Test
    public void testCancleBan() {
        service.cancelBan(1273L);
    }






}
