package com.swime.mapper;

import com.swime.domain.ChatMessageVO;
import com.swime.domain.ChatRoomVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ChatMessageMapper {

    public void insertMsg(ChatMessageVO msg);

    public List<ChatMessageVO> getMsg(String chatRoomId);
}
