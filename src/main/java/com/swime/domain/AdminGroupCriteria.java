package com.swime.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class AdminGroupCriteria {

    private int pageNum;
    private int amount;

    public AdminGroupCriteria(){
        this(1,10);
    }

    public AdminGroupCriteria(int pageNum, int amount){
        this.pageNum = pageNum;
        this.amount = amount;

    }
}
