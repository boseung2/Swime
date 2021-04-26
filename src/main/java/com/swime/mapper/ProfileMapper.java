package com.swime.mapper;


import com.swime.domain.GroupVO;
import com.swime.domain.ProfileCriteria;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ProfileMapper {

    GroupVO read(@Param("sn") Long sn, @Param("id") String id);

    List<GroupVO> ownerList(String id);

    List<GroupVO> joinList(String id);

    List<GroupVO> wishList(String id);

    List<GroupVO> ownerListWithPaging(@Param("id") String id, @Param("cri") ProfileCriteria cri);
    List<GroupVO> joinListWithPaging(@Param("id") String id, @Param("cri") ProfileCriteria cri);

//    List<GroupVO> joinList(String id);
//
//    List<GroupVO> wishList(String id);



}
