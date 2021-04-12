package com.swime.mapper;

import com.swime.domain.StudyListVO;
import com.swime.domain.StudySurveyVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.swime.config.RootConfig.class})
@Log4j
public class StudySurveyMapperTests {

    @Setter(onMethod_ = @Autowired)
    private StudySurveyMapper mapper;

    @Test
    public void testGetList() {
        List<StudySurveyVO> list = mapper.getList(82L);

        for(StudySurveyVO li : list) {
            assert (li.getStdSn() == 82L);
        }
    }

    @Test
    public void testInsert() {
        List<StudySurveyVO> list = mapper.getList(84L);

        for(StudySurveyVO li : list) {
            if(li.getQuestionSn() == 1L) return; // 이미 있으면 return
        }

        StudySurveyVO survey = new StudySurveyVO();
        survey.setStdSn(84L);
        survey.setQuestionSn(1);
        survey.setQuestion("매주 나오셔야하는데 각오한마디 부탁드립니다.");

        assert(mapper.insert(survey) == 1);
    }

    @Test
    public void testDelete() {
        if(mapper.getList(84L).size() == 0) return;

        assert(mapper.delete(84L) == 1);
        assert (mapper.getList(84L).size() == 0);
    }
}
