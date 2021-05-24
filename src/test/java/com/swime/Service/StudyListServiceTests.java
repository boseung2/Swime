package com.swime.Service;

import com.swime.domain.*;
import com.swime.service.StudyListService;
import com.swime.service.StudyService;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.ArrayList;
import java.util.List;

import static org.junit.Assert.assertNotNull;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.swime.config.RootConfig.class})
@Log4j
public class StudyListServiceTests {
    @Setter(onMethod_ = @Autowired)
    private StudyListService service;

    @Test
    public void testGetAttendList() {
        List<StudyListVO> list = service.getAttendantList(307L);
        if (list.size() == 0) return;

        for(StudyListVO li : list) {
            assert (li.getStdSn() == 307L);
        }
    }

    @Test
    public void testGetAttendListWithPaging() {
        StudyCriteria cri = new StudyCriteria(1, 3);

        List<StudyListVO> list = service.getAttendantList(cri, 307L);
        if (list.size() == 0) return;

        for(StudyListVO li : list) {
            assert (li.getStdSn() == 307L);
        }
        assert (0 <= list.size() && list.size() <= 3);
    }

    @Test
    public void testGetWaitingList() {
        List<StudyListVO> list = service.getWaitingList(308L);
        if (list.size() == 0) return;

        for(StudyListVO li : list) {
            assert (li.getStdSn() == 308L);
        }
    }

    @Test
    public void testGetWaitingListWithPaging() {
        StudyCriteria cri = new StudyCriteria(1, 3);

        List<StudyListVO> list = service.getWaitingList(cri, 308L);
        if (list.size() == 0) return;

        for(StudyListVO li : list) {
            assert (li.getStdSn() == 308L);
        }
        assert (0 <= list.size() && list.size() <= 3);
    }

    @Test
    public void testGetBanList() {
        List<StudyListVO> list = service.getBanList(1747L);
        if (list.size() == 0) return;

        for(StudyListVO li : list) {
            assert (li.getStdSn() == 1747L);
        }
    }

    @Test
    public void testGetStudiesOfGroup() {
        service.getStudiesOfGroup(720, "test1@naver.com").forEach(study -> log.info(study));

    }

    @Test
    public void testGetNoRatingStudies() {
        service.getStudiesOfGroup(1240, "wlgh52725@gmail.com").forEach(study -> log.info(study));

    }

    @Test
    public void testRegisterAttendant() {
        StudyParamVO param = new StudyParamVO();
        param.setStdSn(561L);
        param.setUserId("hong7073@service.com");
        param.setStatus("STUS01");

        if(service.getAttendant(param) != null) return;

        assert (service.registerAttendant(param) == 1);
        assert (service.getAttendant(param) != null);
    }

    @Test
    public void testRegisterAttendant2() {
        StudyParamVO param = new StudyParamVO();
        param.setStdSn(561L);
        param.setUserId("qwer5935@naver.com");
        param.setStatus("STUS01");

        if(service.getAttendant(param) != null) return;

        assert (service.registerAttendant(param) == 1);
        assert (service.getAttendant(param) != null);
    }

    @Test
    public void testModifyAttendant() {
        StudyParamVO param = new StudyParamVO();
        param.setStdSn(561L);
        param.setUserId("hong7073@service.com");
        param.setStatus("STUS02");

        service.modifyAttendant(param);

        assert ("STUS02".equals(service.getAttendant(param).getStatus()));
    }

    @Test
    public void testRemoveAttendant() {
        StudyParamVO param = new StudyParamVO();
        param.setStdSn(561L);
        param.setUserId("hong7073@service.com");

        assert (service.removeAttendant(param) == 1);
    }

    @Test
    public void testGetAttendant() {
        StudyParamVO param = new StudyParamVO();
        param.setStdSn(41L);
        param.setUserId("hong2841@service.com");

        StudyListVO list = service.getAttendant(param);
        assert (list != null && list.getStdSn() == 41L && "hong2841@service.com".equals(list.getUserId()));

    }

    @Test
    public void testCountAttendants() {
        assert (service.countAttendants(82L) >= 0);
    }
}
