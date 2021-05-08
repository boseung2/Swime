package com.swime.service;

import com.swime.domain.*;

import java.util.List;

public interface StudySurveyService {
    //설문 리스트 반환
    public List<StudySurveyVO> getSurveyList(long stdSn);

    // 설문 등록
    public int registerSurvey(StudySurveyVO survey);

    // 설문 삭제
    public int removeSurvey(long stdSn);
}
