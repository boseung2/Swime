package com.swime.domain;

import lombok.Data;

@Data
public class MemberHistoryVO {
    private long sn;
    private String email = "";
    private String updMtr = "";
    private String befVal = "";
    private String aftVal = "";
    private String reason = "";
    private String description = "";
    private String updUserId = "";

}
