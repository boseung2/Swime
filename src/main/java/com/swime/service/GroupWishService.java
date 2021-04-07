package com.swime.service;


import com.swime.domain.GroupWishVO;
import com.swime.domain.MemberHistoryVO;
import com.swime.domain.MemberVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface GroupWishService {

    List<GroupWishVO> readByGroupSn(long grpSn);

    List<GroupWishVO> readByid(String id);

    boolean insert(GroupWishVO vo);

    boolean delete(@Param("id") String id, @Param("grpSn") long grpSn);

}
