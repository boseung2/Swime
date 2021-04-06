package com.swime.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class BoardCriteria {

    private int pageNum;
    private int amount;

    public BoardCriteria(){
        this(1,10);
    }

    public BoardCriteria(int pageNum, int amount){
        this.pageNum = pageNum;
        this.amount = amount;
    }
}
