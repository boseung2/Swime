package com.swime.domain;

import lombok.Data;
import org.springframework.web.util.UriComponentsBuilder;

@Data
public class ProfileCriteria {
    private int pageNum;
    private int amount;

    public ProfileCriteria() {
        this(1, 6);
    }

    public ProfileCriteria(int pageNum, int amount) {
        this.pageNum = pageNum;
        this.amount = amount;
    }

    public String getListLink() {
        UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
                .queryParam("pageNum", this.pageNum)
                .queryParam("amount", this.getAmount());
        //.queryParam("type", this.getType())
        //.queryparam("keyowrd", this.getKeyword());

        return builder.toUriString();
    }
}
