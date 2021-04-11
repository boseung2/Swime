package com.swime.Service;

import com.swime.domain.*;
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

//    @Test
//    public void testRegister() {
//        StudyVO study = new StudyVO();
//        study.setGrpSn(7);
//        study.setName("스터디 만들기 서비스 테스트");
//        study.setStartDate("2021-04-06");
//        study.setEndDate("2021-04-06");
//        study.setStartTime("14:00:00");
//        study.setEndTime("16:00:00");
//        study.setRepeatCycle("");
//        study.setRepeatDay("");
//        study.setInformation("스터디 만들기 테스트입니다.스터디 만들기 테스트입니다.스터디 만들기 테스트입니다.스터디 만들기 테스트입니다.");
//        study.setOnOff("STOF02");
//        study.setOnUrl("");
//        study.setPlaceId("구글 place id");
//        study.setExpense("5000원");
//        study.setCapacity(20);
//        study.setStatus("STST01");
//
//        service.register(study);
//
//        log.info("생성된 게시물의 번호: " + study.getSn());
//    }

    @Test
    public void testRegister() {
        StudyVO study = new StudyVO();
        study.setGrpSn(7);
        study.setRepresentation("txTest@naver.com");
        study.setName("트랜잭션테스트 참여명단 안만들어지면 스터디도 삭제돼야하는데..");
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
        study.setStatus("STST01");

        log.info("INSERT COUNT : " + service.register(study));

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
        log.info(service.get(41L));
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


    // WishStudy
    @Test
    public void testGetWishList() {
        StudyCriteria cri = new StudyCriteria();
        cri.setPageNum(1);
        cri.setAmount(3);
        cri.setUserId("asdf@naver.com");

        service.getWishList(cri).forEach(wish -> log.info(wish));
    }

    @Test
    public void testRegisterWish() {
        WishStudyVO wish = new WishStudyVO();
        wish.setStdSn(82L);
        wish.setUserId("aaa@naver.com");

        log.info("INSERT COUNT : " + service.registerWish(wish));
    }

    @Test
    public void testRemoveWish() {
        log.info("DELETE COUNT : " + service.removeWish(82L, "aaa@naver.com"));
    }

    //StudyList

    @Test
    public void testGetAttendList() {
        service.getAttendantList(307L).forEach(list -> log.info(list));
    }

    @Test
    public void testGetAttendListWithPaging() {
        StudyCriteria cri = new StudyCriteria();
        cri.setPageNum(1);
        cri.setAmount(3);

        service.getAttendantList(cri).forEach(list -> log.info(list));
    }

    @Test
    public void testRegisterAttendant() {
        StudyListVO list = new StudyListVO();
        list.setStdSn(41L);
        list.setUserId("hong2841@service.com");
        list.setStatus("STUS01");

        log.info("INSERT COUNT : " + service.registerAttendant(list));
    }

    @Test
    public void testModifyAttendant() {
        log.info("UPDATE COUNT : " + service.modifyAttendant(82L, "aaa@naver.com", "STST04"));
    }

    @Test
    public void testCountAttendants() {
        log.info("ATTEND COUNT : " + service.countAttendants(82L));
    }

    //StudySurvey
    @Test
    public void testGetSurveyList() {
        service.getSurveyList(82L).forEach(survey -> log.info(survey));
    }

    @Test
    public void testRegisterSurvey() {
        StudySurveyVO survey = new StudySurveyVO();
        survey.setStdSn(84);
        survey.setQuestionSn(1);
        survey.setQuestion("각오한마디 부탁드립니다.");

        log.info("INSERT COUNT : " + service.registerSurvey(survey));
    }

    @Test
    public void testRemoveSurvey() {
        log.info("DELETE COUNT : " + service.removeSurvey(84L));
    }

    //StudyAnswer
    @Test
    public void testGetAnswer() {
        service.getAnswer(82L, "aaa@naver.com").forEach(answer -> log.info(answer));
    }

    @Test
    public void testRegisterAnswer() {
        StudyAnswerVO answer = new StudyAnswerVO();
        answer.setStdSn(165L);
        answer.setUserId("jiho@naver.com");
        answer.setQuestionSn(1);
        answer.setQuestion("해당 스터디는 상황에따라 조금 더 진행될 수도 있는데 괜찮으십니까?");
        answer.setAnswer("네. 괜찮습니다.");

        log.info("REGISTER COUNT (가입못하는 경우 -1, 탈퇴에서 가입 1, update 성공 2) : " + service.registerAnswer(answer));
    }

    @Test
    public void testRemoveAnswer() {
        log.info("DELETE COUNT : " + service.removeAnswer(84L, "ffff@naver.com"));
    }
}
