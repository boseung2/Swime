package com.swime.domain;

import lombok.Data;

import java.util.Date;

@Data
public class StudyVO {

    private Long stdNum;
    //fk
    private Long GrpNum;
    private Long stdPlcNum;

    private String stdName;
    private Date stdStartTime;
    private Date stdEenTime;
    private String stdExp; //가격
    private int stdCap; //인원
    private String stdInfo; //정보
    private String stdRep; //스터디 장
    private Date stdRegdate;
    private int stdStatus;





}
