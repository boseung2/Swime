package com.swime.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class GroupCriteria {
    private int pageNum;
    private int amount;

    public GroupCriteria() {
        this(1, 6);
    }

    public GroupCriteria(int pageNum, int amount) {
        this.pageNum = pageNum;
        this.amount = amount;
    }
}
