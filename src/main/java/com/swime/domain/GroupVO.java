package com.swime.domain;

import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

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
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date regDate;
    private String regUserId;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date updDate;
    private String updUserId;

    private List<GroupAttachVO> attachList;
}
