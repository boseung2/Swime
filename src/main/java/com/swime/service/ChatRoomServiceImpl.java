package com.swime.service;

import com.swime.domain.*;
import com.swime.mapper.ChatMessageMapper;
import com.swime.mapper.ChatRoomMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Log4j
@Service
    public class ChatRoomServiceImpl implements ChatRoomService {
    @Setter(onMethod_ = @Autowired)
    private ChatRoomMapper mapper;

    @Setter(onMethod_ = @Autowired)
    private ChatMessageMapper msgMapper;

    @Override
    public List<ChatRoomVO> getRoomList() {
        return mapper.getRoomList();
    }

    @Override
    public List<ChatAttendVO> getRoomListById(String userId) {
        return mapper.getRoomListById(userId);
    }

    @Transactional
    @Override
    public void registerRoom(String id, ChatMessageVO msg) {

        // 채팅방 생성
        mapper.insertRoom(id);

        // 해당 id를 가진 채팅방에 송신자와 수신자를 등록
        mapper.insertAttendant(id, msg.getSenderId());
        mapper.insertAttendant(id, msg.getReceiverId());

        // 채팅 메시지를 등록
        msg.setChatRoomId(id);
        msgMapper.insertMsg(msg);

    }

    @Override
    public String getOldChatRoom(String me, String you) {
        return mapper.getOldChatRoom(me, you);
    }
}
