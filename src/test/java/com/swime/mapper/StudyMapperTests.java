package com.swime.mapper;

import com.swime.domain.StudyCriteria;
import com.swime.domain.StudyVO;
import com.swime.domain.WishStudyVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

import static org.junit.Assert.assertNotNull;

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
        cri.setPageNum(1);
        cri.setAmount(0);

        List<StudyVO> list = mapper.getListWithPaging(cri);

        list.forEach(study -> log.info(study.getSn()));

        assert(0 <= list.size() && list.size() <= 3);
    }

    @Test
    public void testInsert() {
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
        study.setStatus("STST01");

        assert (mapper.insert(study) == 1);
        log.info(study);
    }

    @Test
    public void testInsert2() {
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
        study.setStatus("STST01");

        assert (mapper.insert(study) == 1);
    }

    @Test
    public void testInsertSelectKey() {
        StudyVO study = new StudyVO();
        study.setGrpSn(7);
        study.setRepresentation("jiho@gmail.com");
        study.setName("스터디 만들기 테스트2");
        study.setStartDate("2021-04-06");
        study.setEndDate("2021-04-06");
        study.setStartTime("14:00:00");
        study.setEndTime("16:00:00");
        study.setRepeatCycle("");
        study.setRepeatDay("");
        study.setInformation("스터디 만들기 테스트2입니다.스터디 만들기 테스트2입니다.스터디 만들기 테스트2입니다.");
        study.setOnOff("STOF02");
        study.setOnUrl("");
        study.setPlaceId("구글 place id");
        study.setExpense("5000원");
        study.setCapacity(20);
        study.setStatus("STST01");

        mapper.insertSelectKey(study);

        log.info(study);
    }

    @Test
    public void testGet() {
        StudyVO study = mapper.get(41L);

        log.info(study);
    }

    @Test
    public void testDelete(){
        log.info("DELETE COUNT: " + mapper.delete(42L));
    }

    @Test
    public void testUpdate() {
        StudyVO study = new StudyVO();
        study.setSn(41L);
        study.setName("스터디 수정 테스트");
        study.setStartDate("2021-04-07");
        study.setEndDate("2021-04-07");
        study.setStartTime("14:00:00");
        study.setEndTime("17:00:00");
        study.setRepeatCycle("");
        study.setRepeatDay("");
        study.setInformation("스터디 수정 테스트");
        study.setOnOff("STOF01");
        study.setOnUrl("http://www.zoom.meeting/1");
        study.setPlaceId("");
        study.setExpense("");
        study.setCapacity(10);

        log.info("UPDATE COUNT: " + mapper.update(study));
    }

    @Test
    public void testEndStudy() {
        log.info("UPDATE COUNT : " + mapper.endStudy(46L, "STST03"));
    }
}
