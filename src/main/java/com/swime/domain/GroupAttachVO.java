package com.swime.domain;

import lombok.Data;

@Data
public class GroupAttachVO {

    private String uuid;
    private String uploadPath;
    private String fileName;
    private boolean fileType;

    private Long grpSn;
}
