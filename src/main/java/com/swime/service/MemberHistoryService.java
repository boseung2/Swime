package com.swime.service;


import com.swime.domain.MemberVO;

public interface MemberHistoryService {
    boolean registerHistory(MemberVO vo, String updUserId, String description);
}
