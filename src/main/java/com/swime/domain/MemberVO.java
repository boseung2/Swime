package com.swime.domain;

import lombok.Data;

import java.sql.Date;

@Data
public class MemberVO {
    private String id;
    private String password;
    private String name;
    private String picture;
    private Date birth;
    private String regPath;
    private Date lastLoginDate;
    private Date emailAuth;
    private String status;
    private Date regDate;
}
