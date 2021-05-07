package com.swime.domain;

import lombok.Data;

@Data
public class ChatMessageDTO {
    private MessageType type;
    private String content;
    private String sender;

    public enum MessageType {
        CHAT,
        JOIN,
        LEAVE
    }
}

