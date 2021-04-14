package com.swime.mapper;

import com.swime.domain.GroupCriteria;
import com.swime.domain.GroupRatingVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface GroupRatingMapper {

    public int insert(GroupRatingVO groupRating);

    public int insertSelectKey(GroupRatingVO groupRating);

    public GroupRatingVO read(Long sn);

    public List<GroupRatingVO> getList(Long grp_sn);

    public List<GroupRatingVO> getListWithPaging(@Param("grpSn") Long grpSn, @Param("cri") GroupCriteria cri);

    public int update(GroupRatingVO groupRating);

    public int delete(Long sn);

    // 그룹번호로 해당 그룹 평균 평점을 구한다.
    public double getRatingByGrpSn(Long grpSn);

    // 그룹 번호로 해당 그룹 평점 개수를 센다.
    public long getRatingCountByGrpSn(Long grpSn);

    // 후기 번호로 해당 그룹번호를 구한다.
    public Long getGrpSnBySn(Long sn);

}
