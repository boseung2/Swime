package com.swime.domain;

import lombok.Data;

import java.util.Date;

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
    private String yourName; // 상대방 이름 from tuser
    private String yourPicture; // 상대방 사진 from tuser
    private int unreadMsg; // 안읽은 메시지 개수
}
