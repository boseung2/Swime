package com.swime.mapper;

import com.swime.domain.StudyAnswerVO;
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
        mapper.get(82L, "aaa@naver.com").forEach(answer -> log.info(answer));
    }

    @Test
    public void testInsert() {
        StudyAnswerVO answer = new StudyAnswerVO();
        answer.setStdSn(84L);
        answer.setUserId("jiho@naver.com");
        answer.setQuestionSn(1L);
        answer.setQuestion("이 스터디는 자바 기초지식을 요구합니다. 기초지식이 있나요?");
        answer.setAnswer("네. 학교에서 배웠습니다.");

        log.info("INSERT COUNT : " + mapper.insert(answer));
    }

    @Test
    public void testDelete() {
        log.info("DELETE COUNT : " + mapper.delete(84L, "jiho@naver.com"));
    }
}
