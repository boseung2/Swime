package com.swime.domain;

import lombok.Data;

@Data
public class StudySurveyVO {
    private long sn;
    private long stdSn;
    private long questionSn;
    private String question;
}
