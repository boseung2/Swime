package com.swime.domain;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class GroupVO {

    // 모임번호, 모임명, 모임정원, 모임정보, 모임사진, 모임장, 모임 생성 날짜, 모임 상태, 모임 지역번호, 언어번호
    private int grpNum;
    private String grpName;
    private int grpCap;
    private String grpInfo;
    private String grpPic;
    private String grpRep;
    private LocalDateTime grpRegDate;
    private int grpStatus;
    private int grpRegnNum;
    private int langNum1;
    private int langNum2;
    private int langNum3;

}
