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

    public StudyCriteria(){
        this(1, 3);
    }

    public StudyCriteria(long pageNum, int amount) {
        this.pageNum = pageNum;
        this.amount = amount;
    }
}
