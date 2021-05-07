package com.swime.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class ReplyCriteria {
    private int pageNum;
    private int amount;

    public ReplyCriteria(){
        this(1,10);
    }

    public ReplyCriteria(int pageNum, int amount){
        this.pageNum = pageNum;
        this.amount = amount;
    }
}
