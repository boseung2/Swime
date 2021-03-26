package com.swime.mapper;


import com.swime.domain.StudyVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.TestConstructor;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes ={com.swime.config.RootConfig.class})
@Log4j
public class StudyMapperTests {

    @Setter(onMethod_=@Autowired)
    private StudyMapper mapper;

    @Test
    public void testGetList(){
        mapper.getList().forEach(study -> log.info(study));
//        List list = mapper.getList();
//        log.info(list);
    }

    @Test
    public void testInsert(){
        StudyVO study = new StudyVO();
        study.setName("리액트 스터디 모임");
        study.setStartTime("2021/03/26 16:00");
        study.setEndTime("2021/03/26 18:00");
        study.setExp("10000");
        study.setCap(10);
        study.setInfo("리액트 스터디 모임에 오신걸 환영합니다.");
        study.setRep("이민재");
        study.setGrpNum(22L);
        study.setStdPlcNum(22L);

        mapper.insert(study);

        log.info(study);
    }

    @Test
    public void testInsertSelectKey(){
        StudyVO study = new StudyVO();
        study.setName("리액트 스터디 모임");
        study.setStartTime("2021/03/26 16:00");
        study.setEndTime("2021/03/26 18:00");
        study.setExp("10000");
        study.setCap(10);
        study.setInfo("리액트 스터디 모임에 오신걸 환영합니다.");
        study.setRep("이민재");
        study.setGrpNum(22L);
        study.setStdPlcNum(22L);

        mapper.insertSelectKey(study);

        log.info(study);
    }

    @Test
    public void testRead(){

        StudyVO study = mapper.read(6L);
        log.info(study);

    }

    @Test
    public void testDelete(){
        log.info("DELETE COUNT : " + mapper.delete(30L));
    }


}
