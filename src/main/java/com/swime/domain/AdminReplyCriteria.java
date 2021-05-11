package com.swime.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class AdminReplyCriteria {
    private int pageNum;
    private int amount;
    private String type;
    private String active;

    public AdminReplyCriteria(){
        this(1,10, "S","AD");
    }

    public AdminReplyCriteria(int pageNum, int amount, String type, String active){
        this.pageNum = pageNum;
        this.amount = amount;
        this.type = type;
        this.active = active;
    }
}
