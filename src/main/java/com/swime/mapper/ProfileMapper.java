package com.swime.mapper;


import com.swime.domain.GroupVO;
import com.swime.domain.ProfileCriteria;
import com.swime.domain.StudyVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ProfileMapper {

    GroupVO read(@Param("sn") Long sn, @Param("id") String id);

    List<GroupVO> ownerList(String id);

    List<GroupVO> joinList(String id);

    List<GroupVO> wishList(String id);

    List<GroupVO> ownerListWithPaging(@Param("id") String id, @Param("cri") ProfileCriteria cri);

    List<GroupVO> joinListWithPaging(@Param("id") String id, @Param("cri") ProfileCriteria cri);

    List<GroupVO> wishListWithPaging(@Param("id") String id, @Param("cri") ProfileCriteria cri);

    int ownerListCount(String id);

    int joinListCount(String id);

    int wishListCount(String id);

    List<StudyVO> makeStudyList(@Param("id") String id, @Param("cri") ProfileCriteria cri);

    int makeStudyCount(String id);



}
