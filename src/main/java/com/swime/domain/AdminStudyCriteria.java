package com.swime.domain;


import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class AdminStudyCriteria {
    private int pageNum;
    private int amount;

    public AdminStudyCriteria(int pageNum, int amount){
        this.pageNum = pageNum;
        this.amount = amount;
    }
}
