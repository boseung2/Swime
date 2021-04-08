package com.swime.domain;

import lombok.Data;

import java.util.Date;

@Data
public class StudyVO {
    private long sn;
    private long grpSn;
    private String representation;
    private String representationName;
    private String name;
    private String startDate;
    private String endDate;
    private String repeatCycle;
    private String startTime;
    private String endTime;
    private String repeatDay;
    private String information;
    private String onOff;
    private String onUrl;
    private String placeId;
    private String expense;
    private int capacity;
    private int attendants; // studyService의 get메서드로 받아옴
    private String status;
    private Date regDate;
    private Date updDate;
}
