package com.swime.service;

import com.swime.domain.GroupRatingCriteria;
import com.swime.domain.GroupRatingVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface GroupRatingService {

    int register(GroupRatingVO groupRating);

    List<GroupRatingVO> getListWithPaging(@Param("grpSn") Long grpSn, @Param("cri") GroupRatingCriteria cri);

    int modify(GroupRatingVO groupRating);

    int delete(Long sn);

}
