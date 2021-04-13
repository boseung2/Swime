package com.swime.domain;

import lombok.Data;

import java.util.Date;

@Data
public class BoardAttachVO {

    private String uuid;

    private Long brdSn;

    private String uploadPath;
    private String fileName;
    private String fileType;
    private Long fileSize;
    private Date regDate;
}
