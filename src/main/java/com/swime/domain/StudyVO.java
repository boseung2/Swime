package com.swime.domain;

import lombok.Data;

import java.util.Date;

@Data
public class StudyVO {
    private long sn;
    private long grpSn;
    private String name;
    private String startDate;
    private String endDate;
    private String startTime;
    private String endTime;
    private String repeatCycle;
    private String repeatDay;
    private String information;
    private String onOff;
    private String onUrl;
    private String placeId;
    private String expense;
    private int capacity;
    private int participants;
    private String status;
    private Date regDate;
    private Date updDate;
}
