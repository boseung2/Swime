package com.swime.service;


import com.swime.domain.*;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ProfileService {

//    GroupVO read(@Param("sn") Long sn, @Param("id") String id);
//
//    List<GroupVO> getOwnerGroupList(String id);
//
//    List<GroupVO> getJoinGroupList(String id);
//
//    List<GroupVO> getWishGroupList(String id);
//
//    List<GroupVO> ownerListWithPaging(@Param("id") String id, @Param("cri") ProfileCriteria cri);
//
//    List<GroupVO> joinListWithPaging(@Param("id") String id, @Param("cri") ProfileCriteria cri);
//
//    List<GroupVO> wishListWithPaging(@Param("id") String id, @Param("cri") ProfileCriteria cri);
//
//    int ownerListCount(String id);
//
//    int joinListCount(String id);
//
//    int wishListCount(String id);

    GroupListDTO getMakeGroupListDTO(@Param("id") String id, @Param("cri") ProfileCriteria cri);
    GroupListDTO getJoinGroupListDTO(@Param("id") String id, @Param("cri") ProfileCriteria cri);
    GroupListDTO getWishGroupListDTO(@Param("id") String id, @Param("cri") ProfileCriteria cri);




    GroupStudyListDTO makeBoth(@Param("id") String id, @Param("cri") ProfileCriteria cri);

    GroupStudyListDTO beforeBoth(@Param("id") String id, @Param("cri") ProfileCriteria cri);

    GroupStudyListDTO afterBoth(@Param("id") String id, @Param("cri") ProfileCriteria cri);

    GroupStudyListDTO wishBoth(@Param("id") String id, @Param("cri") ProfileCriteria cri);



    GroupBoardPageDTO ContentsBoth(@Param("id") String id, @Param("cri") ProfileCriteria cri);

    ReplyPageDTO ReplyBoth(@Param("id") String id, @Param("cri") ProfileCriteria cri);


}
