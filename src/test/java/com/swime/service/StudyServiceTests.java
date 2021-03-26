package com.swime.service;

import com.swime.domain.StudyVO;
import com.swime.mapper.StudyMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import static org.junit.Assert.assertNotNull;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes ={com.swime.config.RootConfig.class})
@Log4j
public class StudyServiceTests {

    @Setter(onMethod_=@Autowired)
    private StudyService service;

    @Test
    public void testExist(){

        log.info(service);
        assertNotNull(service);
    }

    @Test
    public void testRegister(){

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

        service.register(study);

        log.info("생성된 스터디 번호 : " + study.getNum());

    }

    @Test
    public void testGetList(){

        service.getList().forEach(study -> log.info(study));

    }

    @Test
    public void testGet(){

        log.info(service.get(21L));
    }

    @Test
    public void testDelete(){

        log.info("REMOVE RESULT : " + service.remove(32L));
    }
}
