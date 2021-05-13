package com.swime.domain;

import lombok.Data;
import lombok.extern.log4j.Log4j;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import javax.xml.soap.Text;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;
import java.util.concurrent.ConcurrentHashMap;

@Data
@Log4j
public class ChatRoomVO {
    private String id;
    private Map<String, WebSocketSession> sessions = new ConcurrentHashMap<>();

    public void registerSession(String userId, WebSocketSession session) {

        log.info("chatRoomVO > put 전 sessions = " + sessions);

        this.sessions.put(userId, session);

        log.info("chatRoomVO > put 완료 sessions = " + sessions);
    }

//    public void handleMessage(WebSocketSession session, ChatMessageVO chatMessage) throws Exception{
//
//        // 입장 메시지
//        if(chatMessage.getType() == MessageType.ENTER) {
//            sessions.put(chatMessage.getSenderId(), session);
//            log.info(chatMessage.getSenderId() + "님이 입장하셨습니다.");
//
//        }else if(chatMessage.getType() == MessageType.LEAVE) {
//            sessions.remove(chatMessage.getSenderId(), session);
//            log.info(chatMessage.getSenderId() + "님이 퇴장하셨습니다.");
//        }else {
//            // [송신자, 수신자, 내용, 보낸시간]
//            TextMessage msg = new TextMessage(chatMessage.getSenderId() + ","
//                    + chatMessage.getReceiverId() + "," + chatMessage.getContents() + ","
//                    + chatMessage.getSendDate());
//
//            log.info("채팅메시지 = " + msg.toString());
//            send(msg);
//        }
//    }
//
//    public void send(TextMessage msg) throws Exception{
//        for(WebSocketSession target : sessions.values()) {
//            target.sendMessage(msg);
//        }
//    }
}