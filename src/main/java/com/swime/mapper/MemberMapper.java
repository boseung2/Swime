package com.swime.mapper;


import com.swime.domain.MemberVO;

public interface MemberMapper {

    MemberVO read(String id);

    int insert(MemberVO vo);

    int update(MemberVO vo);

    int delete(String id);

    MemberVO readwithdate(String id);

}
