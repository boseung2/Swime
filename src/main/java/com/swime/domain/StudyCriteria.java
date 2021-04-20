package com.swime.domain;

import com.swime.mapper.StudyMapper;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Data
public class StudyCriteria {

    private int pageNum;
    private int amount;

    public StudyCriteria(){
        this(1, 3);
    }

    public StudyCriteria(int pageNum, int amount) {
        this.pageNum = pageNum;
        this.amount = amount;
    }
}
