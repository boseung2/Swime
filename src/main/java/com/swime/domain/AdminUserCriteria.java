package com.swime.domain;

import lombok.Data;
import lombok.ToString;

@Data
@ToString
public class AdminUserCriteria {
    private int pageNum;
    private int amount;

    public AdminUserCriteria(){
        this(1,10);
    }

    public AdminUserCriteria(int pageNum, int amount){
        this.pageNum = pageNum;
        this.amount = amount;
    }
}
