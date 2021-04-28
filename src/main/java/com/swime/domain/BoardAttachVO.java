package com.swime.domain;

import lombok.Data;

import java.util.Date;

@Data
public class BoardAttachVO {

    private String uuid;
    private Long brdSn;
    private String userId;
    private String uploadPath;
    private String fileName;
    private String fileType;
    private Date regDate;


    //private Long fileSize;
}
