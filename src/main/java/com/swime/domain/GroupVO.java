package com.swime.domain;

import lombok.Data;


@Data
public class GroupVO {

    //모임번호 모임명, 모임정원, 모임정보, 모임사진, 모임장, 모임 상태, 언어코드, 모임지역 시도, 시군구
    private int num;
    private String name;
    private int cap;
    private String info;
    private String pic;
    private String rep;
    private String status;
    private String langNum1;
    private String langNum2 = "";
    private String langNum3 = "";
    private String regn_sido;
    private String regn_sgg;

}
