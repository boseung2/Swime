package com.swime.service;

import com.swime.domain.ChatMessageVO;
import com.swime.mapper.ChatMessageMapper;
import com.swime.mapper.ChatRoomMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Log4j
@Service
public class ChatMessageServiceImpl implements ChatMessageService {
    @Setter(onMethod_ = @Autowired)
    private ChatMessageMapper mapper;

    @Override
    public void registerMsg(ChatMessageVO msg) {
        mapper.insertMsg(msg);
    }

    @Override
    public List<ChatMessageVO> getMsg(String chatRoomId) {
        return mapper.getMsg(chatRoomId);
    }

    @Override
    public List<ChatMessageVO> getUnreadMsg(String senderId, String receiverId) {
        return mapper.getUnreadMsg(senderId, receiverId);
    }

    @Override
    public void readMsg(long sn) {
        mapper.readMsg(sn);
    }

    @Override
    public ChatMessageVO getTotalUnreadMsg(String userId) {
        return mapper.getTotalUnreadMsg(userId);
    }
}
