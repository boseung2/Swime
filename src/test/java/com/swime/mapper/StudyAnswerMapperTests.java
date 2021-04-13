package com.swime.mapper;

import com.swime.domain.StudyAnswerVO;
import com.swime.domain.StudyCriteria;
import com.swime.domain.StudyParamVO;
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
public class StudyAnswerMapperTests {

    @Setter(onMethod_ = @Autowired)
    private StudyAnswerMapper mapper;

    @Test
    public void testGet() {
        StudyParamVO param = new StudyParamVO();
        param.setStdSn(82L);
        param.setUserId("aaa@naver.com");

        List<StudyAnswerVO> list = mapper.get(param);

        for(StudyAnswerVO li : list) {
            assert (li.getStdSn() == 82L);
            assert ("aaa@naver.com".equals(li.getUserId()));
        }

        assert (list.get(list.size()-1).getQuestionSn() == list.size());
    }

    @Test
    public void testInsert() {
        StudyParamVO param = new StudyParamVO();
        param.setStdSn(84L);
        param.setUserId("jiho@naver.com");

        List<StudyAnswerVO> list = mapper.get(param);

        for(StudyAnswerVO li : list) {
            if(li.getQuestionSn() == 1L) return; // 해당 질문이 이미 있으면 리턴
        }

        StudyAnswerVO answer = new StudyAnswerVO();
        answer.setStdSn(84L);
        answer.setUserId("jiho@naver.com");
        answer.setQuestionSn(1L);

        // survey에서 가져오기
        answer.setQuestion("이 스터디는 자바 기초지식을 요구합니다. 기초지식이 있나요?");
        answer.setAnswer("네. 학교에서 배웠습니다.");

        assert(mapper.insert(answer) == 1);
    }

    @Test
    public void testDelete() {
        StudyParamVO param = new StudyParamVO();
        param.setStdSn(84L);
        param.setUserId("jiho@naver.com");

        assert (mapper.delete(param) == 1);
        assert (mapper.get(param).size() == 0);
    }
}
