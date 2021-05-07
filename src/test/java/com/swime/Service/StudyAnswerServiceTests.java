package com.swime.Service;

import com.swime.domain.*;
import com.swime.service.StudyAnswerService;
import com.swime.service.StudyService;
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
public class StudyAnswerServiceTests {
    @Setter(onMethod_ = @Autowired)
    private StudyAnswerService service;

    @Test
    public void testGetAnswer() {
        StudyParamVO param = new StudyParamVO();
        param.setStdSn(82L);
        param.setUserId("aaa@naver.com");

        List<StudyAnswerVO> list = service.getAnswer(param);

        for(StudyAnswerVO li : list) {
            assert (li.getStdSn() == 82L);
            assert ("aaa@naver.com".equals(li.getUserId()));
        }

        assert (list.get(list.size()-1).getQuestionSn() == list.size());
    }

    @Test
    public void testRegisterAnswer() {
        StudyAnswerVO answer = new StudyAnswerVO();
        answer.setStdSn(223L);
        answer.setUserId("aaa@naver.com");
        answer.setQuestionSn(1);
        answer.setQuestion("해당 스터디는 상황에따라 조금 더 진행될 수도 있는데 괜찮으십니까?");
        answer.setAnswer("네. 괜찮습니다.");

        List<StudyAnswerVO> answers = new ArrayList<>();
        answers.add(answer);

        StudyParamVO param = new StudyParamVO();
        param.setStdSn(223L);
        param.setUserId("aaa@naver.com");

        int before=  service.getAnswer(param).size();

        String result = "";

        try {
            service.registerAnswers(answers);
            result =  "success";
        }catch (Exception e) {
            result =  "fail";
        }

        assert("success".equals(result));

        if("success".equals(result)) assert(service.getAnswer(param).size() > before);
        if("fail".equals(result)) assert (service.getAnswer(param).size() == before);
    }

    @Test
    public void testRemoveAnswer() {
        StudyAnswerVO answer = new StudyAnswerVO();
        answer.setStdSn(84L);
        answer.setUserId("ffff@naver.com");
        answer.setQuestionSn(1);
        answer.setQuestion("해당 스터디는 상황에따라 조금 더 진행될 수도 있는데 괜찮으십니까?");
        answer.setAnswer("네. 괜찮습니다.");

        List<StudyAnswerVO> answers = new ArrayList<>();
        answers.add(answer);

        service.registerAnswers(answers);

        StudyParamVO param = new StudyParamVO();
        param.setStdSn(84L);
        param.setUserId("ffff@naver.com");

        assert (service.removeAnswer(param) == 1);
        assert(service.getAnswer(param).size() == 0);
    }
}
