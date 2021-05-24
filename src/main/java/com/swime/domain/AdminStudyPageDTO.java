package com.swime.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

import java.util.List;

@Data
@Getter
@AllArgsConstructor
public class AdminStudyPageDTO {
    private int studyCnt;
    private List<AdminStudyVO> studyList;

    public AdminStudyPageDTO() {}
}
