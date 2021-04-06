package com.swime.domain;

import lombok.Data;

import java.util.Date;

@Data
public class BoardLikeVO {

    private Long likeSn;
    private Long brdSn;
    private String userId;
    private Date regDate;
}
