package com.swime.mapper;

import com.swime.domain.StudyAnswerVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface StudyAnswerMapper {

    // 해당 스터디, 해당 유저의 답변 가져오기
    public List<StudyAnswerVO> get(@Param("stdSn") long stdSn, @Param("userId") String userId);

    public int insert(StudyAnswerVO answer);

    public int delete(@Param("stdSn") long stdSn, @Param("userId") String userId);
}
