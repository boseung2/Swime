package com.swime.service;


import com.swime.domain.MemberVO;

import java.util.List;

public interface MemberService {

    MemberVO get(String id);

    boolean register(MemberVO vo);

    boolean modify(MemberVO vo);

    boolean remove(String id);

    List<MemberVO> getlist();

}
