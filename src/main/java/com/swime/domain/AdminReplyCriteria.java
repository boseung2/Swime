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
    private String keyword;
    private String search;

    public AdminReplyCriteria(){
        this(1,10, "S","AD","EN","");
    }

    public AdminReplyCriteria(int pageNum, int amount, String type, String active, String keyword, String search){
        this.pageNum = pageNum;
        this.amount = amount;
        this.type = type;
        this.active = active;
        this.keyword = keyword;
        this.search = search;
    }
}
