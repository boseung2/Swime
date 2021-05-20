package com.swime.domain;

import lombok.Data;

import java.util.List;

@Data
public class MemberDTO {

    List<MemberVO> list;
    int count;
}
