package com.swime.domain;

import lombok.Data;

import java.util.Date;

@Data
public class ReplyVO {

    private int sn;
    private Long brdSn;
    private String userId;
    private int commentGroup;
    private String name;
    private String content;
    private int cnt;
    private String status;
    private Date regDate;
    private Date updDate;
}
