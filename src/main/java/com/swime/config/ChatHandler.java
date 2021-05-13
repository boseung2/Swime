package com.swime.config;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.swime.domain.ChatMessageVO;
import com.swime.domain.ChatRoomVO;
import com.swime.domain.MessageType;
import com.swime.service.ChatRoomService;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;
import sun.plugin2.message.Message;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

@Log4j
public class ChatHandler extends TextWebSocketHandler {

    @Setter(onMethod_ = {@Autowired})
    ChatRoomService chatRoomService;

    // 현재 존재하는 채팅방
    static Map<String, ChatRoomVO> rooms;
    static {
        if(rooms == null)
            rooms = new ConcurrentHashMap<>();
    }

    // 방 말고 채팅자체에 접속한 유저
    Map<String, WebSocketSession> users = new ConcurrentHashMap<>();


    // 클라이언트가 서버로 연결시
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {

        log.info("채팅 웹소켓 연결됨");

        // 현재 rooms에 없는 채팅방 가져와서 넣어주기
        List<ChatRoomVO> chatRoomList= chatRoomService.getRoomList();

        for(int i= 0; i < chatRoomList.size(); i++) {

            if(!rooms.containsKey(chatRoomList.get(i))) {
                rooms.put(chatRoomList.get(i).getId(), chatRoomList.get(i));
            }
        }

        // 로그인 중이면서 채팅을 이용중인 유저를 users map에 저장
        if(session.getPrincipal() != null) {
            users.put(session.getPrincipal().getName(), session);
        }

        log.info("채팅 rooms = " + rooms);
        log.info("채팅 users = " + users);
    }

    // 클라이언트가 Data 전송시
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {

        // 메시지 출력
        String msg = message.getPayload();
        log.info("ChatHandler session = " + session + ", message = " + msg);

        ChatMessageVO chatMessage = new ObjectMapper().readValue(msg, ChatMessageVO.class);
        log.info("받은 메시지 = " + chatMessage);

        // 사용자가 로그인된 경우
        if(session.getPrincipal()!= null) {
            // 메시지 타입이 ENTER인 경우
            if(MessageType.ENTER.equals(chatMessage.getType())) {

                // 송신자 id
                String userId = chatMessage.getSenderId();

                // 채팅방 id
                String roomId = chatMessage.getChatRoomId();

                // rooms에서 해당 채팅방 가져오기
                ChatRoomVO room = rooms.get(roomId);

                // 해당 유저를 해당 채팅방의 세션리스트에 등록
                room.registerSession(userId, session);

                log.info(roomId + "의 sessions = " + rooms.get(roomId).getSessions());
                log.info("rooms = " + rooms);

            } else if(MessageType.CHAT.equals(chatMessage.getType())) { // 메시지 타입이 CHAT인 경우


            }
        }


    }

    // 연결 해제시
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {

        if(session.getPrincipal() != null && users.get(session.getPrincipal().getName()) != null) {
            String userId = session.getPrincipal().getName();

            // users 맵에서 삭제
            if(userId != null) {
                log.info(userId + "채팅 연결 종료됨");
                users.remove(userId);
                log.info("채팅 users = " + users);
            }

            // rooms맵에 해당 사용자의 세션이 있으면 삭제해줌

            // 해당 사용자가 속한 채팅방 불러오기
            List<ChatRoomVO> roomsOfUser = chatRoomService.getRoomsOfUser(userId);

            for(int i = 0; i < roomsOfUser.size(); i++) {

                String roomId = roomsOfUser.get(i).getId();

                // 해당 사용자가 속한 채팅방의 세션에 퇴장하는 유저가 있으면 삭제해주기
                Map<String, WebSocketSession> userSessions = rooms.get(roomId).getSessions();

                if (userSessions.containsKey(userId)) {
                    userSessions.remove(userId);

                    log.info(roomId + "에서 " + userId + "의 세션이 삭제되었습니다.");
                }
            }
        }

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
