package com.swime.mapper;

import com.swime.domain.StudyAnswerVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface StudyAnswerMapper {

    public List<StudyAnswerVO> get(@Param("stdSn") long stdSn, @Param("userId") String userId);

    public int insert(StudyAnswerVO answer);

    public int delete(@Param("stdSn") long stdSn, @Param("userId") String userId);
}
