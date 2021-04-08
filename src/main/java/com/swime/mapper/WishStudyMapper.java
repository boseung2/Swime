package com.swime.mapper;

import com.swime.domain.StudyCriteria;
import com.swime.domain.StudyVO;
import com.swime.domain.WishStudyVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface WishStudyMapper {
    public List<StudyVO> getWishListWithPaging(StudyCriteria cri);

    public int insertWishStudy(WishStudyVO wish);

    public int deleteWishStudy(@Param("stdSn") Long stdSn, @Param("userId") String userId);
}
