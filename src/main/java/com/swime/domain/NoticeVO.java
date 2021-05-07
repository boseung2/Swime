package com.swime.domain;

import lombok.Data;

import java.util.Date;

@Data
public class NoticeVO {
    private long sn;
    private String sender;
    private String receiver;
    private String kind;
    private String url;
    private String content; // 50자
    private Date sendDate;
    private String status;
}
