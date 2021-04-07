package com.swime.mapper;

import com.swime.domain.StudySurveyVO;

import java.util.List;

public interface StudySurveyMapper {

    // 해당 스터디의 질문 가져오기
    public List<StudySurveyVO> getList(long stdSn);

    public int insert(StudySurveyVO survey);

    public int delete(long stdSn);
}
