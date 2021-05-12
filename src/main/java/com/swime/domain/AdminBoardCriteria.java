package com.swime.domain;


import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@ToString
public class AdminBoardCriteria {
    private int pageNum;
    private int amount;

    //검색
    private String type; // S : 번호순 SS: 상태순 D : 날짜순
    private String active;
    private String keyword;
    private String search;
    //private String bbsOrReply;

    public AdminBoardCriteria(){
        this(1,10,"S","AD","EN", "");
    }

    public AdminBoardCriteria(int pageNum, int amount, String type, String active,
                              String keyword, String search){
        this.pageNum = pageNum;
        this.amount = amount;
        this.type = type;
        this.active = active;
        this.keyword = keyword;
        this.search = search;

    }

    public String[] getTypeArr(){
        return type == null? new String[] {}: type.split("");
    }

    //게시물 삭제 후 페이지 번호 검색 조건 유지
    //지금 필요 없을듯..
//    public String getListLink() {
//        UriComponentsBuilder builder = UriComponentsBuilder.fromPath("")
//
//        .queryParam("type", this.getType());
//
//
//        return builder.toUriString();
//    }
}
