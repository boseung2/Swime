package com.swime.service;


import com.swime.domain.GroupVO;
import com.swime.domain.MemberHistoryVO;
import com.swime.domain.MemberVO;
import com.swime.domain.ProfileCriteria;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ProfileService {

    GroupVO read(@Param("sn") Long sn, @Param("id") String id);

    List<GroupVO> getOwnerGroupList(String id);

    List<GroupVO> getJoinGroupList(String id);

    List<GroupVO> getWishGroupList(String id);

    List<GroupVO> ownerListWithPaging(@Param("id") String id, @Param("cri") ProfileCriteria cri);

    List<GroupVO> joinListWithPaging(@Param("id") String id, @Param("cri") ProfileCriteria cri);

    List<GroupVO> wishListWithPaging(@Param("id") String id, @Param("cri") ProfileCriteria cri);

    int ownerListCount(String id);

    int joinListCount(String id);

    int wishListCount(String id);
}
