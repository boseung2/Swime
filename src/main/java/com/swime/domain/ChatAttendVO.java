package com.swime.domain;

import lombok.Data;
import lombok.extern.log4j.Log4j;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;

import java.util.HashSet;
import java.util.Set;

@Data
@Log4j
public class ChatAttendVO {
    private String chatRoomId;
    private String attendId;
}