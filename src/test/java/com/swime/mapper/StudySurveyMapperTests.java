package com.swime.mapper;

import com.swime.domain.StudySurveyVO;
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
public class StudySurveyMapperTests {

    @Setter(onMethod_ = @Autowired)
    private StudySurveyMapper mapper;

    @Test
    public void testGetList() {
        mapper.getList(89L).forEach(survey -> log.info(survey));
    }

    @Test
    public void testInsert() {
        StudySurveyVO survey = new StudySurveyVO();
        survey.setStdSn(84L);
        survey.setQuestionSn(1);
        survey.setQuestion("매주 나오셔야하는데 각오한마디 부탁드립니다.");

        log.info("INSERT COUNT : " + mapper.insert(survey));
    }

    @Test
    public void testDelete() {
        log.info("DELETE COUNT : " + mapper.delete(84L));
    }
}
