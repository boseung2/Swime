package com.swime.mapper;


import com.swime.domain.MemberVO;

import java.util.List;

public interface MemberMapper {

    MemberVO read(String id);

    int insert(MemberVO vo);

    int update(MemberVO vo);

    int delete(String id);

    List<MemberVO> getlist();

}
