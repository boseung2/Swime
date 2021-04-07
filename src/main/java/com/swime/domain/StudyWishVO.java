package com.swime.domain;

import lombok.Data;

@Data
public class StudyWishVO {
    private long sn;
    private long stdSn;
    private String userId = "";
}
