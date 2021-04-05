package com.swime.domain;

import lombok.Data;

import java.util.Date;

@Data
public class BoardVO {

    private Long sn;
    private Long grpSn;
    private String userId;
    private String userName;
    private String title;
    private int likeCnt;
    private String topFix;
    private String status;
    private Date regDate;
    private Date updDate;






}
