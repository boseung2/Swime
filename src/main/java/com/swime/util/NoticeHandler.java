//package com.swime.util;
//
//import lombok.extern.log4j.Log4j;
//import org.springframework.context.annotation.Bean;
//import org.springframework.security.core.Authentication;
//import org.springframework.security.core.context.SecurityContextHolder;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.socket.TextMessage;
//import org.springframework.web.socket.WebSocketSession;
//import org.springframework.web.socket.handler.TextWebSocketHandler;
//
//import java.util.Map;
//import java.util.concurrent.ConcurrentHashMap;
//
//@Log4j
//public class NoticeHandler extends TextWebSocketHandler {
//
//    // 로그인중인 유저
//    Map<String, WebSocketSession> users = new ConcurrentHashMap<>();
//
//    // 클라이언트가 서버로 연결시
//    @Override
//    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
//
//        log.info("연결됨");
//        log.info(session.getPrincipal().getName() + "님이 연결되었습니다.");
//
////        // 접속한 유저의 정보를 받아오기
////        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
////
////        String userId = auth.getName();
////
////        log.info("접속했네요.");
////        log.info("userId = " + userId);
//
//        // 로그인중인 유저의 웹소켓 세션정보를 저장
//    }
//    // 클라이언트가 Data 전송시
//    @Override
//    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
//        super.handleTextMessage(session, message);
//    }
//}
