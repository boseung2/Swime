package com.swime.service;

import com.swime.domain.GroupCriteria;
import com.swime.domain.GroupRatingPageDTO;
import com.swime.domain.GroupRatingVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface GroupRatingService {

    int register(GroupRatingVO groupRating);

    public GroupRatingVO get(Long sn);

    List<GroupRatingVO> getListWithPaging(@Param("grpSn") Long grpSn, @Param("cri") GroupCriteria cri);

    GroupRatingPageDTO getListPage(GroupCriteria cri, Long grpSn);

    int modify(GroupRatingVO groupRating);

    int delete(Long sn);

}
