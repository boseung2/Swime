package com.swime.domain;

import lombok.Data;

import java.util.Date;

@Data
public class WishStudyVO {
    private long sn;
    private long stdSn;
    private String userId;
    private Date regDate;
}
