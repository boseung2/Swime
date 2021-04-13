package com.swime.domain;

import lombok.Data;

import java.util.Date;

@Data
public class GroupAttendVO {
    private long sn;
    private long grpSn;
    private String userId;
    private String name;
    private String grpRole;
    private String status;
    private Date regDate;
    private Date updDate;
    private String updUserId;

}
