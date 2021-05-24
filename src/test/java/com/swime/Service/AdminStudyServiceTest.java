package com.swime.Service;


import com.swime.domain.AdminStudyCriteria;
import com.swime.domain.AdminStudyPageDTO;
import com.swime.service.AdminStudyService;
import com.swime.service.BoardService;
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
public class AdminStudyServiceTest {

    @Setter(onMethod_ = {@Autowired})
    private AdminStudyService service;

    @Test
    public void testGetTotalStudyList() {
        AdminStudyCriteria cri = new AdminStudyCriteria(1, 10);

        AdminStudyPageDTO adminStudyPageDTO = service.getTotalStudyList(cri);

        log.info(adminStudyPageDTO.getStudyList());
        log.info(adminStudyPageDTO.getStudyCnt());

    }

    @Test
    public void testGetFutureStudyList() {
        AdminStudyCriteria cri = new AdminStudyCriteria(1, 10);

        service.getFutureStudyList(cri).forEach(study -> log.info(study));
    }

    @Test
    public void testGetPastStudyList() {
        AdminStudyCriteria cri = new AdminStudyCriteria(1, 10);

        service.getPastStudyList(cri).forEach(study -> log.info(study));
    }

    @Test
    public void tetDeletedStudy() {
        AdminStudyCriteria cri = new AdminStudyCriteria(1, 10);

        service.getDeletedStudy(cri).forEach(study -> log.info(study));
    }

}
