package com.swime.service;


import com.swime.domain.GroupVO;
import com.swime.domain.MemberHistoryVO;
import com.swime.domain.MemberVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ProfileService {

    List<GroupVO> getOwnerGroupList(String id);

    GroupVO read(@Param("sn") Long sn, @Param("id") String id);

    List<GroupVO> getJoinList(String id);
}
