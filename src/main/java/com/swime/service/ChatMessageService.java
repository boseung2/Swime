package com.swime.service;

import com.swime.domain.ChatMessageVO;
import com.swime.domain.ChatRoomVO;

import java.util.List;

public interface ChatMessageService {

    // 채팅메시지 등록
    public void registerMsg(ChatMessageVO msg);

    // 해당 채팅방의 채팅 메시지 불러오기
    public List<ChatMessageVO> getMsg(String chatRoomId);

}
