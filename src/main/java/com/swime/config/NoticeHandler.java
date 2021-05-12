package com.swime.config;

import lombok.extern.log4j.Log4j;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.util.Date;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

@Log4j
public class NoticeHandler extends TextWebSocketHandler {

    // 로그인중인 유저
    Map<String, WebSocketSession> users = new ConcurrentHashMap<>();

    // 클라이언트가 서버로 연결시
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        
        log.info("웹소켓 연결됨");
        
        // 현재 세션 사용자가 로그인한 상태이고, users에 있지 않으면 users에 저장

        log.info("session principal = " + session.getPrincipal());

        if(session.getPrincipal() != null && users.get(session.getPrincipal()) == null) {
            log.info(session.getPrincipal().getName() + "님이 연결되었습니다.");

            // 로그인중인 유저의 웹소켓 세션정보를 저장
            users.put(session.getPrincipal().getName(), session);

            log.info("users = " + users);
        }



    }
    // 클라이언트가 Data 전송시
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {

        // 보내는 사람 id
        String senderId = session.getPrincipal().getName();

        //[수신자, 알림 종류, 알림url, 알림내용]
        String msg = message.getPayload();
        if(msg != null) {
            String[] strs = msg.split(",");
            log.info("받은 메시지 = " + strs.toString());

            if(strs != null && strs.length == 4) {

                String target = strs[0];
                String kind = strs[1];
                String url = strs[2];
                String content= strs[3];

                log.info("target = " + target);
                log.info("kind = " + kind);
                log.info("url = " + url);
                log.info("content = " + content);

                WebSocketSession targetSession = users.get(target);
                log.info("targetSession = " + users.get(target));
                log.info("users = " + users);

                // 수신자가 실시간으로 접속해있으면
                if(targetSession != null) {
                    TextMessage tmpMsg = new TextMessage("<a target='_blank' href='"+ url +"'>[<b>" + kind + "</b>] " + content + "</a>");

                    log.info("수신자에게 보낼 메시지 = " + tmpMsg.toString());

                    targetSession.sendMessage(tmpMsg);

                }
            }
        }
    }

    // 연결 해제시
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {

        log.info("session principal = " + session.getPrincipal().getName());
        
        if(users.get(session.getPrincipal().getName()) != null) {
            String senderId = session.getPrincipal().getName();

            if(senderId != null) {
                log.info(senderId + " 연결 종료됨");
                users.remove(senderId);
                log.info("users = " + users);
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
