package com.swime.domain;

import lombok.Data;

import java.util.Date;

@Data
public class StudyListVO {
    private long sn;
    private long stdSn;
    private String picture;
    private String userId;
    private String userName; // tuser와 조인
    private String grpRole; // tgrp_list와 조인
    private String status;
    private Date regDate;
}
