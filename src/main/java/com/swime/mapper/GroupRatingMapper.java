package com.swime.mapper;

import com.swime.domain.GroupRatingCriteria;
import com.swime.domain.GroupRatingVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface GroupRatingMapper {

    public int insert(GroupRatingVO groupRating);

    public int insertSelectKey(GroupRatingVO groupRating);

    public GroupRatingVO read(Long sn);

    public List<GroupRatingVO> getList(Long grp_sn);

    public List<GroupRatingVO> getListWithPaging(@Param("grpSn") Long grpSn, @Param("cri") GroupRatingCriteria cri);

    public int update(GroupRatingVO groupRating);

    public int delete(Long sn);



}
