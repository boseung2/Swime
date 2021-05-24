package com.swime.mapper;

import com.swime.domain.*;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.swime.config.RootConfig.class})
@Log4j
public class AdminStudyMapperTests {

    @Setter(onMethod_ = @Autowired)
    private AdminStudyMapper mapper;

    @Test
    public void testGetTotalStudyList() {
        AdminStudyCriteria cri = new AdminStudyCriteria(1, 10);

        mapper.getTotalStudyList(cri).forEach(study -> log.info(study));

    }

    @Test
    public void testGetTotalCnt() {
        log.info(mapper.getTotalCnt());
    }

    @Test
    public void testGetFutureStudyList() {
        AdminStudyCriteria cri = new AdminStudyCriteria(1, 10);

        mapper.getFutureStudyList(cri).forEach(study -> log.info(study));
    }

    @Test
    public void testGetPastStudyList() {
        AdminStudyCriteria cri = new AdminStudyCriteria(1, 10);

        mapper.getPastStudyList(cri).forEach(study -> log.info(study));
    }

    @Test
    public void tetDeletedStudy() {
        AdminStudyCriteria cri = new AdminStudyCriteria(1, 10);

        mapper.getDeletedStudy(cri).forEach(study -> log.info(study));
    }
}
