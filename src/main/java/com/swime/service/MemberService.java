package com.swime.service;


import com.swime.domain.MemberHistoryVO;
import com.swime.domain.MemberVO;

import java.util.List;
import java.util.Map;

public interface MemberService {

    MemberVO get(String id);

    boolean register(MemberVO vo);

    boolean modify(MemberVO vo, MemberHistoryVO hvo);

    boolean remove(String id, MemberHistoryVO hvo);

    List<MemberVO> getlist();

    boolean checkIdPw(MemberVO vo);

    boolean registerHistory(MemberVO vo);

    boolean registerHistory(MemberVO vo, MemberHistoryVO hvo);

    List<MemberHistoryVO> getHistList(String id);
}
