package com.swime.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class GroupRatingCriteria {
    private int pageNum;
    private int amount;

    public GroupRatingCriteria() {
        this(1, 5);
    }

    public GroupRatingCriteria(int pageNum, int amount) {
        this.pageNum = pageNum;
        this.amount = amount;
    }
}
