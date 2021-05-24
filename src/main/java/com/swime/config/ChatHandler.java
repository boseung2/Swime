package com.swime.config;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.swime.domain.ChatMessageVO;
import com.swime.domain.ChatRoomVO;
import com.swime.domain.MessageType;
import com.swime.service.ChatMessageService;
import com.swime.service.ChatRoomService;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.apache.ibatis.annotations.Mapper;
import org.mybatis.spring.annotation.MapperScan;
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

    @Setter(onMethod_ = {@Autowired})
    ChatMessageService chatMessageService;

    // 현재 존재하는 채팅방
    static Map<String, ChatRoomVO> rooms = new ConcurrentHashMap<>();

    // 방 말고 채팅자체에 접속한 유저
    Map<String, WebSocketSession> users = new ConcurrentHashMap<>();


    // 클라이언트가 서버로 연결시
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {

        log.info("채팅 웹소켓 연결됨");

        // 현재 rooms에 없는 채팅방 가져와서 넣어주기
        List<ChatRoomVO> chatRoomList= chatRoomService.getRoomList();

        for(int i= 0; i < chatRoomList.size(); i++) {

            if(!rooms.containsKey(chatRoomList.get(i).getId())) {
                rooms.put(chatRoomList.get(i).getId(), chatRoomList.get(i));
            }
        }

        // 로그인 중이면서 채팅을 이용중인 유저를 users map에 저장
        if(session.getPrincipal() != null) {
            users.put(session.getPrincipal().getName(), session);
        }

        log.info("연결 직후 채팅 rooms = " + rooms);
        log.info("연결 직후 채팅 users = " + users);
    }

    // 클라이언트가 Data 전송시
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {

        // 메시지 출력
        String msg = message.getPayload();
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

                // 해당 방에 다른 세션이 있으면 다른 세션에게 메시지 리로드하라고 알림
                Map<String, WebSocketSession> userSessions = rooms.get(roomId).getSessions();

                if(!userSessions.isEmpty()) {
                    for(WebSocketSession target : userSessions.values()) {
                        target.sendMessage(new TextMessage("reload chatMsg"));
                    }
                }
                
                // rooms의 해당 채팅방의 session에 userId를 추가
                rooms.get(roomId).getSessions().put(userId, session);

                log.info("입장 직후 rooms = " + rooms);
                log.info("입장 직후 해당방의 세션 = " + rooms.get(roomId).getSessions());
                log.info("입장 직후 채팅 users = " + users);

            } else if(MessageType.CHAT.equals(chatMessage.getType())) { // 메시지 타입이 CHAT인 경우

                // 해당 채팅방
                ChatRoomVO room = rooms.get(chatMessage.getChatRoomId());
                // 해당 채팅방의 세션맵
                Map<String, WebSocketSession> userSession = room.getSessions();

                // 1. 상대방 session이 해당 room에 존재하면 chatMessage의 status : 읽음 / 존재하지 않으면 안읽음
                if(userSession.containsKey(chatMessage.getReceiverId())) {
                    chatMessage.setStatus("MSST01"); // 읽음
                }else {
                    chatMessage.setStatus("MSST02"); // 안읽음
                }

                // 2. 해당 메시지를 db에 저장
                chatMessageService.registerMsg(chatMessage);

                // 3. 해당 채팅방의 세션에 메시지 전달
                for(WebSocketSession target : userSession.values()) {

                    // 채팅방id, 보낸사람, 내용, 상태
                    TextMessage tmpMsg = new TextMessage(chatMessage.getChatRoomId() + ","
                            + chatMessage.getSenderId() + "," + chatMessage.getContents() + "," + chatMessage.getStatus());

                    log.info("채팅 수신자에게 보낼 메시지 = " + tmpMsg.toString());

                    target.sendMessage(tmpMsg);

                }

                // 4. 해당 채팅방에 세션은 없지만 다른 곳에서 채팅중인 경우
                if(!userSession.containsKey(chatMessage.getReceiverId()) &&
                        users.containsKey(chatMessage.getReceiverId())) {

                    users.get(chatMessage.getReceiverId()).sendMessage(new TextMessage("reload chatList"));
                }

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

                // 해당 채팅방이 rooms에 등록되어있으면
                if(rooms.containsKey(roomsOfUser.get(i).getId())) {

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

        log.info("연결 종료 직후 채팅 rooms = " + rooms);
        log.info("연결 종료 직후 채팅 users = " + users);

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
