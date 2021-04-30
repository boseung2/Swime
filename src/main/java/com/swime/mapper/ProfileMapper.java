package com.swime.mapper;


import com.swime.domain.*;
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

    List<StudyVO> beforeStudyList(@Param("id") String id, @Param("cri") ProfileCriteria cri);

    int beforeStudyCount(String id);

    List<StudyVO> afterStudyList(@Param("id") String id, @Param("cri") ProfileCriteria cri);

    int afterStudyCount(String id);

    List<StudyVO> wishStudyList(@Param("id") String id, @Param("cri") ProfileCriteria cri);

    int wishStudyCount(String id);

    List<BoardVO> writeContentsList(@Param("id") String id, @Param("cri") ProfileCriteria cri);

    int writeContentsCount(String id);

    List<ReplyVO> writeReplyList(@Param("id") String id, @Param("cri") ProfileCriteria cri);

    int writeReplyCount(String id);

}
