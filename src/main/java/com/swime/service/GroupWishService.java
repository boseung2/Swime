package com.swime.service;


import com.swime.domain.GroupWishVO;
import com.swime.domain.MemberHistoryVO;
import com.swime.domain.MemberVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface GroupWishService {

    boolean register(GroupWishVO vo);

    GroupWishVO read(GroupWishVO vo);

    boolean delete(GroupWishVO vo);

    List<GroupWishVO> getByGroupSn(long grpSn);

    List<GroupWishVO> getByid(String id);

    boolean remove(@Param("id") String id, @Param("grpSn") long grpSn);

}
