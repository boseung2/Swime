package com.swime.mapper;

import com.swime.domain.StudyCriteria;
import com.swime.domain.StudyVO;
import com.swime.domain.WishStudyVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface WishStudyMapper {
    public List<StudyVO> getList(StudyCriteria cri);

    public int insert(WishStudyVO wish);

    public int delete(@Param("stdSn") Long stdSn, @Param("userId") String userId);
}
