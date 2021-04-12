package com.swime.mapper;

import com.swime.domain.StudySurveyVO;

import java.util.List;

public interface StudySurveyMapper {

    // 해당 스터디의 질문들 가져오기
    public List<StudySurveyVO> getList(long stdSn);

    // 해당 스터디에 질문 등록하기
    public int insert(StudySurveyVO survey);

    // 해당 스터디의 모든 질문 지우기
    public int delete(long stdSn);
}
