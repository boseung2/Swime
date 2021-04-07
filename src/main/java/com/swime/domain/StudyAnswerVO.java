package com.swime.domain;

import lombok.Data;

@Data
public class StudyAnswerVO {
    private long sn;
    private long stdSn;
    private String userId;
    private long questionSn; // 중복컬럼 <- StudySurvey에서 가져와서 넣기
    private String question; // 중복컬럼
    private String answer;
}
