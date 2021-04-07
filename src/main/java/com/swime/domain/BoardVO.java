package com.swime.domain;

import lombok.Data;

import java.util.Date;
import java.util.List;

@Data
public class BoardVO {

    private Long sn;
    private Long grpSn;
    private String userId;
    private String userName;
    private String title;
    private String content;
    private int likeCnt;
    private String topFix;
    private String status;
    private Date regDate;
    private Date updDate;

    //게시글 등록 시 첨부까지 처리할 수 있게 BoardAtchVO추가
    private List<BoardAttachVO> attachList;
}
