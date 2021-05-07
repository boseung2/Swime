package com.swime.Service;

import com.swime.domain.*;
import com.swime.service.StudyService;
import com.swime.service.StudySurveyService;
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
public class StudySurveyServiceTests {
    @Setter(onMethod_ = @Autowired)
    private StudySurveyService service;

    @Test
    public void testGetSurveyList() {
        List<StudySurveyVO> list = service.getSurveyList(82L);

        for(StudySurveyVO li : list) {
            assert(li.getStdSn() == 82L);
        }
    }

    @Test
    public void testRegisterSurvey() {
        StudySurveyVO survey = new StudySurveyVO();
        survey.setStdSn(84L);
        survey.setQuestionSn(1);
        survey.setQuestion("각오한마디 부탁드립니다.");

        assert (service.registerSurvey(survey) == 1);
        assert (service.getSurveyList(84L).size() > 0);
    }

    @Test
    public void testRemoveSurvey() {
        assert (service.removeSurvey(84L) == 1);
        assert (service.getSurveyList(84L).size() == 0);
    }

}
