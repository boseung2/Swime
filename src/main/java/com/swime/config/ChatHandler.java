package com.swime.config;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.swime.domain.ChatMessageVO;
import com.swime.domain.ChatRoomVO;
import com.swime.service.ChatRoomService;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.util.*;
import java.util.concurrent.ConcurrentHashMap;

@Log4j
public class ChatHandler extends TextWebSocketHandler {

    @Setter(onMethod_ = {@Autowired})
    ChatRoomService chatRoomService;

    // 현재 존재하는 채팅방
    Map<String, ChatRoomVO> rooms = new ConcurrentHashMap<>();

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
        ChatRoomVO chatRoom = rooms.get(chatMessage.getChatRoomId());

        // rooms map에서 받은 chatRoom을 가지고 메시지를 처리한다.
        chatRoom.handleMessage(session, chatMessage);

        // 사용자가 해당 채팅방에 입장했을때 메시지를 보낸다.
        // 이는 입장/채팅 메시지가 될 수 있으며
        // 메시지에는 항상 채팅방 id를 수반해야한다.
        // 입장 메시지가 왔을때 챗핸들러는 해당 채팅방에 사용자의 세션을 등록해준다.
        // 채팅 메시지가 왔을때는 해당 메시지를 db에 등록해주고 채팅방에 있는 유저들에게 실시간으로 메시지를 뿌려준다. -> 채팅방 메시지에 동적으로 추가
        // 또한 채팅방에 상대방 유저세션이 없더라도 전체 세션에 상대방 유저가 있으면 메시지를 보내준다. -> 받은사람은 리스트를 새로고침
        // 퇴장 메시지가 왔을때는 해당 채팅방에서 사용자의 세션을 지운다.

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
