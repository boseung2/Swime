package com.swime.Service;

import com.swime.domain.StudyCriteria;
import com.swime.domain.StudyVO;
import com.swime.domain.WishStudyVO;
import com.swime.service.StudyService;
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
        study.setName("스터디 만들기 서비스 테스트");
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
        study.setParticipants(0);
        study.setStatus("STST01");

        service.register(study);

        log.info("생성된 게시물의 번호: " + study.getSn());
    }

    @Test
    public void testGetList() {
        service.getList().forEach(study -> log.info(study));
    }

    @Test
    public void testGetListWithPaging() {
        StudyCriteria cri = new StudyCriteria();
        cri.setPageNum(3);
        cri.setAmount(3);

        service.getList(cri).forEach(study -> log.info(study));
    }

    @Test
    public void testGet() {
        log.info(service.get(61L));
    }

    @Test
    public void testModify() {
        StudyVO study = service.get(61L);

        if(study == null) {
            return;
        }

        study.setName("제목 수정수정합니다.");
        log.info("MODIFY COUNT: " + service.modify(study));
    }

    @Test
    public void testRemove() {
        log.info("DELETE COUNT: " + service.remove(61L));
    }

    @Test
    public void testWish() {
        WishStudyVO wish = new WishStudyVO();
        wish.setStdSn(82L);
        wish.setUserId("aaa@naver.com");

        log.info("INSERT COUNT : " + service.wish(wish));
    }

    @Test
    public void testCancelWish() {
        log.info("DELETE COUNT : " + service.cancelWish(82L, "aaa@naver.com"));
    }
}
