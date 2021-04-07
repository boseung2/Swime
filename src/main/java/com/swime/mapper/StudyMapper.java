package com.swime.mapper;

import com.swime.domain.StudyCriteria;
import com.swime.domain.StudyVO;
import com.swime.domain.WishStudyVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface StudyMapper {
    public List<StudyVO> getList();

    public List<StudyVO> getListWithPaging(StudyCriteria cri);

    public int insert(StudyVO study);

    public int insertSelectKey(StudyVO study);

    public StudyVO read(Long sn);

    public int update(StudyVO study);

    public int delete(Long sn);

    public List<StudyVO> getWishListWithPaging(StudyCriteria cri);

    public int insertWishStudy(WishStudyVO wish);

    public int deleteWishStudy(@Param("stdSn") Long stdSn, @Param("userId") String userId);

}
