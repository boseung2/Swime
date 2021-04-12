package com.swime.mapper;

import com.swime.domain.StudyCriteria;
import com.swime.domain.StudyVO;
import com.swime.domain.WishStudyVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.apache.commons.validator.routines.UrlValidator;
import org.junit.Test;
import org.junit.jupiter.api.DisplayName;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashSet;
import java.util.List;

import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertNull;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.swime.config.RootConfig.class})
@Log4j
public class StudyMapperTests {

    @Setter(onMethod_ = @Autowired)
    private StudyMapper mapper;

    @Test
    public void testGetList() {
        mapper.getList().forEach(study -> log.info(study));

        assertNotNull(mapper.getList());
        log.info(mapper.getList()); // 비어있으면 []
    }

    @Test
    public void testGetListWithPaging() {
        StudyCriteria cri = new StudyCriteria();
        cri.setPageNum(1);
        cri.setAmount(3);

        List<StudyVO> list = mapper.getListWithPaging(cri);

        list.forEach(study -> log.info(study.getSn()));

        assert(0 <= list.size() && list.size() <= 3);
    }

    @Test
    public void testGetListWithPaging2() {
        StudyCriteria cri = new StudyCriteria();
        cri.setPageNum(30);
        cri.setAmount(3);

        List<StudyVO> list = mapper.getListWithPaging(cri);

        list.forEach(study -> log.info(study.getSn()));

        assert(0 <= list.size() && list.size() <= 3);
    }

    @Test
    public void testGetListWithPaging3() {
        StudyCriteria cri = new StudyCriteria();
        cri.setPageNum(-1);
        cri.setAmount(3);

        List<StudyVO> list = mapper.getListWithPaging(cri);

        list.forEach(study -> log.info(study.getSn()));

        assert(list.size() == 0);
    }

    @Test
    public void testGetListWithPaging4() {
        StudyCriteria cri = new StudyCriteria();
        cri.setPageNum(0);
        cri.setAmount(0);

        List<StudyVO> list = mapper.getListWithPaging(cri);

        list.forEach(study -> log.info(study.getSn()));

        assert(list.size() == 0);
    }

    @Test
    public void testInsert() {
        StudyVO study = new StudyVO();
        study.setGrpSn(7);
        study.setRepresentation("hong4258@service.com");
        study.setName("스터디 만들기 테스트");
        study.setStartDate("2021-04-06");
        study.setEndDate("2021-04-06");
        study.setStartTime("2021-04-06 14:00:00");
        study.setEndTime("2021-04-06 16:00:00");
        study.setRepeatCycle("");
        study.setRepeatDay("");
        study.setInformation("스터디 만들기 테스트입니다.스터디 만들기 테스트입니다.스터디 만들기 테스트입니다.스터디 만들기 테스트입니다.");
        study.setOnOff("STOF02");
        study.setOnUrl("");
        study.setPlaceId("구글 place id");
        study.setExpense("5000원");
        study.setCapacity(20);

        assert (mapper.insert(study) == 1);
        log.info(study);
    }

    @Test(expected = Exception.class)
    public void testInsert2() {
        StudyVO study = new StudyVO();
        study.setGrpSn(7); // 비어있으면 에러
        study.setRepresentation("hong4258@service.com"); // 비어있으면 에러
        study.setName(""); // 비어있으면 에러
        study.setStartDate("2021-04-06"); // 비어있으면 에러
        study.setEndDate("2021-04-06"); // 비어있으면 에러
        study.setStartTime("14:00:00"); // 비어있으면 에러
        study.setEndTime("16:00:00"); // 비어있으면 에러
        study.setRepeatCycle("");
        study.setRepeatDay("");
        study.setInformation("스터디 만들기 테스트입니다.스터디 만들기 테스트입니다.스터디 만들기 테스트입니다.스터디 만들기 테스트입니다."); // 비어있으면 에러
        study.setOnOff("STOF02");
        study.setOnUrl("");
        study.setPlaceId("구글 place id");
        study.setExpense("5000원");
        study.setCapacity(20); // 비어있으면 에러

        mapper.insert(study);
    }

    @Test
    public void testInsert3() {
        String result = "";

        try{
            StudyVO study = new StudyVO();
            study.setGrpSn(7);
            study.setRepresentation("hong4258@service.com");
            study.setName("30자까지만 들어갈 수 있어요30자까지만 들어갈 수 있어"); //30자까지 가능
            study.setStartDate("2021-04-06");
            study.setEndDate("2021-04-06");
            study.setStartTime("14:00:00");
            study.setEndTime("16:00:00");
            study.setRepeatCycle("");
            study.setRepeatDay("");
            study.setInformation("스터디 만들기 테스트입니다.스터디 만들기 테스트입니다.스터디 만들기 테스트입니다.스터디 만들기 테스트입니다."); // 400자까지 가능
            study.setOnOff("STOF02");
            study.setOnUrl("");
            study.setPlaceId("구글 place id");
            study.setExpense("5000원"); // 10자까지 가능
            study.setCapacity(20); // 99까지 가능

            mapper.insert(study);
        }catch (Exception e) {
            result = "제목 30자 초과";
            log.info(result);
        }

        assert("제목 30자 초과".equals(result) == true);
    }

    @Test(expected = Exception.class)
    public void testInsert4() {
        StudyVO study = new StudyVO();
        study.setGrpSn(7);
        study.setRepresentation("hong4258@service.com");
        study.setName("스터디 만들기 테스트");
        study.setStartDate("날짜"); // 날짜형식이 이상하게 들어오는 경우
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

        mapper.insert(study);
    }

    @Test(expected = Exception.class)
    public void testInsert4_2() {
        StudyVO study = new StudyVO();
        study.setGrpSn(7);
        study.setRepresentation("hong4258@service.com");
        study.setName("스터디 만들기 테스트");
        study.setStartDate("2021-04-31"); // 날짜형식이 이상하게 들어오는 경우
        study.setEndDate("2021-04-31");
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

        mapper.insert(study);
    }

    @Test(expected = Exception.class)
    public void testInsert5() {
        StudyVO study = new StudyVO();
        study.setGrpSn(7);
        study.setRepresentation("hong4258@service.com");
        study.setName("스터디 만들기 테스트");
        study.setStartDate("2021-04-06");
        study.setEndDate("2021-04-06");
        study.setStartTime("2021-04-06 14:00:00");
        study.setEndTime("16:00:00"); // 시간이 이상하게 들어오는 경우
        study.setRepeatCycle("");
        study.setRepeatDay("");
        study.setInformation("스터디 만들기 테스트입니다.스터디 만들기 테스트입니다.스터디 만들기 테스트입니다.스터디 만들기 테스트입니다.");
        study.setOnOff("STOF02");
        study.setOnUrl("");
        study.setPlaceId("구글 place id");
        study.setExpense("5000원");
        study.setCapacity(20);

        mapper.insert(study);
    }

    @Test(expected = Exception.class)
    public void testInsert5_2() {
        StudyVO study = new StudyVO();
        study.setGrpSn(7);
        study.setRepresentation("hong4258@service.com");
        study.setName("스터디 만들기 테스트");
        study.setStartDate("2021-04-06");
        study.setEndDate("2021-04-06");
        study.setStartTime("2021-04-06 14:00:00");
        study.setEndTime("2021-04-06 14:89:00"); // 시간이 이상하게 들어오는 경우
        study.setRepeatCycle("");
        study.setRepeatDay("");
        study.setInformation("스터디 만들기 테스트입니다.스터디 만들기 테스트입니다.스터디 만들기 테스트입니다.스터디 만들기 테스트입니다.");
        study.setOnOff("STOF02");
        study.setOnUrl("");
        study.setPlaceId("구글 place id");
        study.setExpense("5000원");
        study.setCapacity(20);

        mapper.insert(study);
    }

    @Test(expected = Exception.class)
    public void testInsert6() {
        StudyVO study = new StudyVO();
        study.setGrpSn(7);
        study.setRepresentation("hong4258@service.com");
        study.setName("스터디 만들기 테스트");
        study.setStartDate("2021-04-06");
        study.setEndDate("2021-04-30");
        study.setStartTime("2021-04-06 14:00:00");
        study.setEndTime("2021-04-06 16:00:00");
        study.setRepeatCycle("STCY01");
        study.setRepeatDay("월,화,수,목,금,토,일,월"); // 13자 이하
        study.setInformation("스터디 만들기 테스트입니다.스터디 만들기 테스트입니다.스터디 만들기 테스트입니다.스터디 만들기 테스트입니다.");
        study.setOnOff("STOF02");
        study.setOnUrl("");
        study.setPlaceId("구글 place id");
        study.setExpense("5000원");
        study.setCapacity(20);

        assert (mapper.insert(study) == 1);
        log.info(study);
    }

    @Test
    public void testInsert7() {
        StudyVO study = new StudyVO();
        study.setGrpSn(7);
        study.setRepresentation("hong4258@service.com");
        study.setName("스터디 만들기 테스트");
        study.setStartDate("2021-04-06");
        study.setEndDate("2021-04-30");
        study.setStartTime("2021-04-06 14:00:00");
        study.setEndTime("2021-04-06 16:00:00");
        study.setRepeatCycle("STCY01");
        study.setRepeatDay("월,화,수,목,금,토,일");
        study.setInformation("스터디 만들기 테스트입니다.스터디 만들기 테스트입니다.스터디 만들기 테스트입니다.스터디 만들기 테스트입니다.");
        study.setOnOff("STOF02");
        study.setOnUrl("");
        study.setPlaceId("구글 place id");
        study.setExpense("5000원");
        study.setCapacity(20);

        assert (mapper.insert(study) == 1);
        log.info(study);
    }

    // insert와 동일
    @Test
    public void testInsertSelectKey() {
        StudyVO study = new StudyVO();
        study.setGrpSn(7);
        study.setRepresentation("jiho@gmail.com");
        study.setName("스터디 만들기 테스트2");
        study.setStartDate("2021-04-06");
        study.setEndDate("2021-04-06");
        study.setStartTime("2021-04-06 14:00:00");
        study.setEndTime("2021-04-06 16:00:00");
        study.setRepeatCycle("");
        study.setRepeatDay("");
        study.setInformation("스터디 만들기 테스트2입니다.스터디 만들기 테스트2입니다.스터디 만들기 테스트2입니다.");
        study.setOnOff("STOF02");
        study.setOnUrl("");
        study.setPlaceId("구글 place id");
        study.setExpense("5000원");
        study.setCapacity(20);

        assert (mapper.insertSelectKey(study) == 1);
    }

    @Test
    public void testInsertSelectKey2() {
        StudyVO study = new StudyVO();
        study.setSn(309); // 이미 있는 sn을 등록해도 알아서 다음 값으로 insert 해준다.
        study.setGrpSn(7);
        study.setRepresentation("qwer8159@naver.com");
        study.setName("스터디만들기 테스트");
        study.setStartDate("2021-04-06");
        study.setEndDate("2021-04-30");
        study.setStartTime("2021-04-06 14:50:00");
        study.setEndTime("2021-04-06 17:00:00");
        study.setRepeatCycle("STCY01");
        study.setRepeatDay("월,수,금");
        study.setInformation("스터디 만들기 테스트2입니다.스터디 만들기 테스트2입니다.스터디 만들기 테스트2입니다.");
        study.setOnOff("STOF01");
        study.setOnUrl("http://www.naver.com");
        study.setPlaceId("");
        study.setExpense("5000원");
        study.setCapacity(20);

        assert (mapper.insertSelectKey(study) == 1);
    }


    // testGet을 위한 함수들
    private boolean isSameDate(StudyVO study) {
        return (study.getStartDate()).equals(study.getEndDate());
    }

    private boolean validateDays(String repeatDay) {
        ArrayList<String> arrayList = new ArrayList<>(Arrays.asList(new String[]{"월", "화", "수", "목", "금", "토", "일"}));

        // arrayList에 포함되는 값을 담을 set (중복제거)
        HashSet<String> result = new HashSet<>();

        // 반복요일을 ,로 쪼개서 배열에 담는다.
        String[] dayList = repeatDay.split(",");

        // 해당 값이 월~일에 포함되면 set에 넣는다.
        for(String day : dayList) {
            if(arrayList.contains(day)) {
                result.add(day);
            }
        }

        //dayList의 길이와 result의 길이가 같으면 월~일요일 값을 중복없이 제대로 받아온 것
        return result.size() == dayList.length;
    }

    private boolean isOnline(StudyVO study) {
        return "STOF01".equals(study.getOnOff());
    }

    private boolean isValidUrl(String url) { // 유효한 url인지 확인
        UrlValidator urlValidator = new UrlValidator(new String[]{"http","https"});
        log.info("===============================isValid : " + urlValidator.isValid(url));
        return urlValidator.isValid(url);
    }

    @Test
    public void testGet() {
        StudyVO study = mapper.get(368L);

        if(study != null) {
            // 1. 시작일자와 종료일자가 같으면 반복주기와 반복 요일이 null이어야 한다.
            if(isSameDate(study)){
                assert (study.getRepeatCycle() == null && study.getRepeatDay() == null);

            }else {
                // 2. 시작일자와 종료일자가 다른 경우
                String repeactCycle = study.getRepeatCycle();
                String repeatDay = study.getRepeatDay();

                // 2-1. 반복주기가 null이 아니면 STCY01/STCY02/STCY03 중 하나여야한다.
                if(repeactCycle != null) {
                    assert ("STCY01".equals(repeactCycle) || "STCY02".equals(repeactCycle) || "STCY03".equals(repeactCycle));
                }

                // 2-2. 반복요일이 null이 아니면 데이터를 ,로 split한 값이 중복없이 월~일 요일중에 하나여야한다.
                if(repeatDay != null) {
                    assert (validateDays(repeatDay));
                }
            }

            // 3. 온라인일 경우 온라인링크가 null이 아니고 url 형식이 유효하며, 장소 id가 null인지 확인
            if(isOnline(study)) {
                String url = study.getOnUrl();

                log.info("============================url : " + url);
                assert (url != null && isValidUrl(url) && study.getPlaceId() == null);
            }else {
                // 4. 오프라인일 경우 장소id가 null이 아니고, 온라인 링크가 null인지 확인

                assert (study.getPlaceId() != null && study.getOnUrl() == null);
            }
        }

        log.info(study);
    }

    // insert와 동일
    @Test
    public void testUpdate() {
        StudyVO study = new StudyVO();
        study.setSn(312L);
        study.setName("스터디 수정 테스트");
        study.setStartDate("2021-04-07");
        study.setEndDate("2021-04-07");
        study.setStartTime("2021-04-07 14:30:00");
        study.setEndTime("2021-04-07 18:30:00");
        study.setRepeatCycle("");
        study.setRepeatDay("");
        study.setInformation("스터디 수정 테스트");
        study.setOnOff("STOF01");
        study.setOnUrl("http://www.zoom.meeting/1");
        study.setPlaceId("");
        study.setExpense("");
        study.setCapacity(10);

        assert (mapper.update(study) == 1);
    }

    @Test
    public void testUpdateStatus(){
        assert (mapper.updateStatus(307L, "STST03") == 1);
        assert ("STST03".equals(mapper.get(307L).getStatus()));
    }
}
