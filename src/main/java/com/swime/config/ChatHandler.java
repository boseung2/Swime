package com.swime.config;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.swime.domain.ChatMessageVO;
import com.swime.domain.ChatRoomVO;
import com.swime.service.ChatRoomService;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;
import java.util.concurrent.ConcurrentHashMap;

@Log4j
public class ChatHandler extends TextWebSocketHandler {

    @Setter(onMethod_ = {@Autowired})
    ChatRoomService chatRoomService;

    // 현재 존재하는 채팅방
    Map<String, ChatRoomVO> rooms = new ConcurrentHashMap<>();


    // 클라이언트가 서버로 연결시
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {

        log.info("웹소켓 연결됨");

        // 현재 rooms에 없는 채팅방 가져와서 넣어주기
        List<ChatRoomVO> chatRoomList= chatRoomService.getRoomList();

        for(int i= 0; i < chatRoomList.size(); i++) {

            if(!rooms.containsKey(chatRoomList.get(i))) {
                rooms.put(UUID.randomUUID().toString(), chatRoomList.get(i));
            }
        }
    }

    // 클라이언트가 Data 전송시
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {

        // 메시지 출력
        String msg = message.getPayload();
        log.info("ChatHandler session = " + session + ", message = " + msg);

        ChatMessageVO chatMessage = new ObjectMapper().readValue(msg, ChatMessageVO.class);
        ChatRoomVO chatRoom = rooms.get(chatMessage.getChatRoomId());

        // rooms map에서 받은 chatRoom을 가지고 메시지를 처리한다.
        chatRoom.handleMessage(session, chatMessage);

    }

    @Override
    public void handleTransportError(WebSocketSession session, Throwable exception) throws Exception {
        log.info(session.getPrincipal().getName() + " 익셉션 발생 : + " + exception.getMessage());
    }

    // 로그 메시지
    public void log(String logMsg) {
        System.out.println(new Date() + " : " + logMsg);
    }
}
