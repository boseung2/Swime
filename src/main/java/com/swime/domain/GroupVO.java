package com.swime.domain;

import lombok.Data;

import java.time.LocalDateTime;

@Data
public class GroupVO {

    // 모임번호, 모임명, 모임정원, 모임정보, 모임사진, 모임장, 모임 생성 날짜, 모임 상태, 모임 지역번호, 언어번호
    private int num;
    private String name;
    private int cap;
    private String info;
    private String pic;
    private String rep;
    private LocalDateTime regDate;
    private int status;
    private int regnNum;
    private int langNum1;
    private int langNum2;
    private int langNum3;

}
