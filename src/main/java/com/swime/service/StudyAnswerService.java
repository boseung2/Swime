package com.swime.service;

import com.swime.domain.*;

import java.util.List;

public interface StudyAnswerService {
    
    // 답변 가져오기
    public List<StudyAnswerVO> getAnswer(StudyParamVO param);

    // 답변들을 등록하고 해당 멤버를 검토중인 상태로 등록 또는 수정
    public void registerAnswers(List<StudyAnswerVO> answers);
    
    // 답변 삭제
    public int removeAnswer(StudyParamVO param);
}
