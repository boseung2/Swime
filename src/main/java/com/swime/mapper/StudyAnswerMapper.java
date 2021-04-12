package com.swime.mapper;

import com.swime.domain.StudyAnswerVO;
import com.swime.domain.StudyCriteria;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface StudyAnswerMapper {

    // 해당 스터디, 해당 유저의 답변 가져오기
    public List<StudyAnswerVO> get(StudyCriteria cri);

    public int insert(StudyAnswerVO answer);

    // 스터디장이 멤버를 승인/거부하면 해당 스터디의 해당유저의 답변을 모두 삭제
    public int delete(StudyCriteria cri);
}
