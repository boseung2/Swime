package com.swime.domain;

import lombok.Data;

import java.util.Date;
import java.util.List;

@Data
public class GroupVO {
    private Long sn;
    private List<String> tags;
    private String category;
    private String name;
    private String userId;
    private String userName;
    private String picture;
    private String description;
    private String info;
    private Long attendCount;
    private Double rating;
    private Long ratingCount;
    private String sido;
    private String sigungu;
    private String status;
    private Date regDate;
    private String regUserId;
    private Date updDate;
    private String updUserId;
}
