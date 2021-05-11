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
//    private String keyword;
//    private String bbsOrReply;

    public AdminBoardCriteria(){
        this(1,10);
    }

    public AdminBoardCriteria(int pageNum, int amount){
        this.pageNum = pageNum;
        this.amount = amount;

    }

    public String[] getTypeArr2(){
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
