package com.swime.domain;

import lombok.Data;

import java.util.Date;

@Data
public class StudyVO {

    private Long stdNum;
    //fk
    private Long grpNum;
    private Long stdPlcNum;

    private String name;
    private String startTime;
    private String endTime;
    private String exp; //가격
    private int cap; //인원
    private String info; //정보
    private String rep; //스터디 장
    private Date regdate;
    private int status;





}
