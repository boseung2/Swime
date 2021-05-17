package com.swime.mapper;

import com.swime.domain.ChatMessageVO;
import com.swime.domain.ChatRoomVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ChatMessageMapper {

    public void insertMsg(ChatMessageVO msg);

    public List<ChatMessageVO> getMsg(String chatRoomId);

    // 해당 유저와의 채팅중 안읽은 메시지 반환
    public List<ChatMessageVO> getUnreadMsg(@Param("senderId") String senderId, @Param("receiverId") String receiverId);

    // 안읽은 메시지를 읽음처리
    public int readMsg(long sn);
}
