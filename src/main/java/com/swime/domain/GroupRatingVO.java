package com.swime.domain;

import lombok.Data;

@Data
public class GroupRatingVO {
    private Long sn;
    private Long grpSn;
    private Long stdSn;
    private String userId;
    private Double rating;
    private String review;
    private String regDate;
}
