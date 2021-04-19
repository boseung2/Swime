package com.swime.mapper;

import com.swime.domain.GroupAttendVO;
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
public class GroupAttendMapperTests {

    @Setter(onMethod_ = @Autowired)
    private GroupAttendMapper mapper;

    @Test
    public void testInsertSelectKey() {
        GroupAttendVO groupAttend = new GroupAttendVO();
        groupAttend.setGrpSn(630L);
        groupAttend.setUserId("boseung@naver.com");
        groupAttend.setGrpRole("GRRO02");
        groupAttend.setStatus("GRUS01");

        mapper.insertSelectKey(groupAttend);
    }

    @Test
    public void testGetList() {
        mapper.getList(630L).forEach(groupAttend -> log.info(groupAttend));
    }

    @Test
    public void testUpdate() {
        GroupAttendVO groupAttend = new GroupAttendVO();

        groupAttend.setSn(6);
        groupAttend.setGrpRole("GRRO02");
        groupAttend.setStatus("GRUS03");
        groupAttend.setUpdUserId("hong2841@service.com");

        int count = mapper.update(groupAttend);
        log.info("UPDATE COUNT : " + count);
    }

    @Test
    public void testGetAttendCountByGroupSn() {
        log.info("count: " + mapper.getAttendCountByGroupSn(100L));
    }
}
