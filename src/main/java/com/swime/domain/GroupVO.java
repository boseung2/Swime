package com.swime.domain;

import lombok.Data;

import java.util.Date;

@Data
public class GroupVO {
    private Long sn;
    private String category;
    private String name;
    private String userId;
    private String userName;
    private String picture;
    private String description;
    private Long headcount;
    private Double rating;
    private String sido;
    private String sigungu;
    private String status;
    private Date regDate;
    private String regUserId;
    private Date updDate;
    private String updUserId;
}
