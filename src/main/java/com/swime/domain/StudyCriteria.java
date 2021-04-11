package com.swime.domain;

import com.swime.mapper.StudyMapper;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class StudyCriteria {

    private long pageNum;
    private int amount;
    private long stdSn;
    private String userId;

    public StudyCriteria(){
        this(1, 3);
    }

    public StudyCriteria(long pageNum, int amount) {
        this.pageNum = pageNum;
        this.amount = amount;
    }

    public StudyCriteria(long stdSn, String userId) {
        this.stdSn = stdSn;
        this.userId = userId;
    }

    public StudyCriteria(long pageNum, int amount, long stdSn) {
        this.pageNum = pageNum;
        this.amount = amount;
        this.stdSn = stdSn;
    }

    public StudyCriteria(long pageNum, int amount, String userId) {
        this.pageNum = pageNum;
        this.amount = amount;
        this.userId = userId;
    }

    public StudyCriteria(long pageNum, int amount, long stdSn, String userId) {
        this.pageNum = pageNum;
        this.amount = amount;
        this.stdSn = stdSn;
        this.userId = userId;
    }
}
