package com.swime.mapper;

import com.swime.domain.StudyCriteria;
import com.swime.domain.StudyParamVO;
import com.swime.domain.StudyVO;
import com.swime.domain.WishStudyVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface WishStudyMapper {
    // 사용자가 찜한 스터디 목록을 페이징처리해서 리턴
    public List<StudyVO> getList(@Param("cri") StudyCriteria cri, @Param("userId") String userId);

    // 해당 사용자가 해당 스터디를 찜했는지 안했는지 기록을 리턴
    public WishStudyVO get(StudyParamVO param);

    public int insert(WishStudyVO wish);

    public int delete(StudyParamVO param);
}
