package com.swime.domain;

import lombok.Data;

import java.util.Date;

@Data
public class BoardVO {
    private Long num;
    private String ttl;
    private String cn;
    private String pic;
    private String top;
    private Date regdate;
    private Date upddate;
    private String cate;
    private Long grpNum;
    private Long userNum;
}