package com.swime.domain;

import lombok.Data;

import java.util.Date;
import java.util.List;


@Data
public class MemberVO {
    private String id;
    private String password;
    private String name;
    private String picture = "";
    private String birth = "";
    private String regPath;
    private Date lastLoginDate;
    private Date emailAuth;
    private String status;
    private Date regDate;
    private List<AuthVO> authList;
}
