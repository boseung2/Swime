package com.swime.Service;

import com.swime.domain.*;
import com.swime.service.StudyService;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.jcp.xml.dsig.internal.dom.DOMSubTreeData;
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
public class StudyServiceTests {
    @Setter(onMethod_ = @Autowired)
    private StudyService service;

    @Test
    public void testExist() {
        log.info(service);
        assertNotNull(service);
    }

    @Test
    public void testRegister() {
        StudyVO study = new StudyVO();
        study.setGrpSn(7);
        study.setRepresentation("hong4258@service.com");
        study.setName("스터디 만들기 테스트");
        study.setStartDate("2021-04-06");
        study.setEndDate("2021-04-06");
        study.setStartTime("14:00:00");
        study.setEndTime("16:00:00");
        study.setRepeatCycle("");
        study.setRepeatDay("");
        study.setInformation("스터디 만들기 테스트입니다.스터디 만들기 테스트입니다.스터디 만들기 테스트입니다.스터디 만들기 테스트입니다.");
        study.setOnOff("STOF02");
        study.setOnUrl("");
        study.setPlaceId("구글 place id");
        study.setExpense("5000원");
        study.setCapacity(20);

        service.register(study, new ArrayList<>());

        assert(service.get(study.getSn()) != null);
    }

    @Test
    public void testRegister2() {
        int[] grpNum = {222, 437, 98, 157, 221, 438, 256, 439, 457, 156};
        String[] userEmail = {"qwer8203@naver.com",
                "qwer9234@naver.com",
                "qwer6786@naver.com",
                "qwer7290@naver.com",
                "qwer3568@naver.com",
                "qwer5368@naver.com",
                "qwer5935@naver.com",
                "qwer2810@naver.com",
                "qwer4052@naver.com",
                "hong7073@service.com"};

        for(int i = 0; i < grpNum.length; i++) {
            StudyVO study = new StudyVO();
            study.setGrpSn(grpNum[i]);
            study.setRepresentation(userEmail[i]);
            study.setName("스터디 만들기 테스트" + i);
            study.setStartDate("2021-04-01");
            study.setEndDate("2021-04-" + (10+i));
            study.setStartTime("14:00:00");
            study.setEndTime("16:00:00");
            study.setRepeatCycle("STCY01");
            study.setRepeatDay("화,수");
            study.setInformation("스터디 만들기 테스트입니다.스터디 만들기 테스트입니다.스터디 만들기 테스트입니다.스터디 만들기 테스트입니다.");
            study.setOnOff("STOF02");
            study.setOnUrl("");
            study.setPlaceId("신촌 포텐 스터디 카페");
            study.setExpense("5000원");
            study.setCapacity(20);

            service.register(study, new ArrayList<>());
            assert(service.get(study.getSn()) != null);
        }

    }

    @Test
    public void testGetList() {
        List<StudyVO> list = service.getList(222);

        for (StudyVO li : list) {
            assert ("STST01".equals(li.getStatus()) || "STST03".equals(li.getStatus()));
        }
    }

    @Test
    public void testGetListWithPaging() {
        StudyCriteria cri = new StudyCriteria();
        cri.setPageNum(1);
        cri.setAmount(3);

        GroupStudyListDTO groupStudyListDTO = service.getList(cri, 222);

        List<StudyVO> list = groupStudyListDTO.getList();
        list.forEach(study -> log.info(study));
        log.info(groupStudyListDTO.getCount());

        for (StudyVO li : list) {
            assert ("STST01".equals(li.getStatus()) || "STST03".equals(li.getStatus()));
        }
        assert (0 <= list.size() && list.size() <= 3);
    }

    @Test
    public void testGetPastListWithPaging() {
        StudyCriteria cri = new StudyCriteria();
        cri.setPageNum(1);
        cri.setAmount(3);

        GroupStudyListDTO groupStudyListDTO = service.getPastList(cri, 1040);

        List<StudyVO> list = groupStudyListDTO.getList();
        list.forEach(study -> log.info(study));
        log.info(groupStudyListDTO.getCount());

        for (StudyVO li : list) {
            assert ("STST01".equals(li.getStatus()) || "STST03".equals(li.getStatus()));
        }
        assert (0 <= list.size() && list.size() <= 3);
    }

    @Test
    public void testCountStudy() {
        assert (service.countStudy(222) == 2);
    }

    @Test
    public void testGet() {
        StudyVO study = service.get(307L);

        assert (study != null && study.getSn() == 307);
    }

    @Test
    public void testModify() {
        StudyVO study = service.get(366L);

        if (study == null) return;

        study.setName("제목 수정수정합니다.");

        service.modify(study, new ArrayList<>());
        assert ("제목 수정수정합니다.".equals(service.get(366L).getName()));
    }

    @Test
    public void testEndStudy() {
        StudyParamVO param = new StudyParamVO();
        param.setStdSn(307L);

        assert (service.endStudy(param) == 1);
        assert ("STST03".equals(service.get(307L).getStatus()));
    }

    @Test
    public void testRemove() {
        StudyParamVO param = new StudyParamVO();
        param.setStdSn(307L);

        assert (service.remove(param) == 1);
        assert (service.get(307L) == null);
    }
}
