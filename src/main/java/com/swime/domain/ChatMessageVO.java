package com.swime.domain;

import lombok.Data;
import org.springframework.web.socket.WebSocketSession;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

@Data
public class ChatMessageVO {
    private long sn;
    private String chatRoomId;
    private String receiverId;
    private String senderId;
    private String contents;
    private String status;
    private Date sendDate;
    private Date readDate;
    private MessageType type; // ENTER, LEAVE, CHAT
    private String yourName;
}
