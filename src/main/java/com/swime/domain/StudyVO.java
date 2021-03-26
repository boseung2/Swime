package com.swime.domain;

import lombok.Data;

import java.util.Date;

@Data
public class StudyVO {

    private Long num;
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
    private String status;

//    private Long std_Num;
//    //fk
//    private Long grp_Num;
//    private Long std_Plc_Num;
//
//    private String std_Name;
//    private String std_StartTime;
//    private String std_EndTime;
//    private String std_Exp; //가격
//    private int std_Cap; //인원
//    private String std_Info; //정보
//    private String std_Rep; //스터디 장
//    private Date std_Regdate;
//    private String std_Status;


}
