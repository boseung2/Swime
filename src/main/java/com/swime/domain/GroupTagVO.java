package com.swime.domain;

import lombok.Data;

@Data
public class GroupTagVO {

    private Long grpSn;
    private String name;

    public GroupTagVO(Long grpSn, String name) {
        this.grpSn = grpSn;
        this.name = name;
    }

    public GroupTagVO() {}

}
