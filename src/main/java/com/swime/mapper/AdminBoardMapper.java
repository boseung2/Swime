package com.swime.mapper;

import com.swime.domain.*;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AdminBoardMapper {

    //---------- 관리자 게시판 (나중에 관리자 매퍼로 이동 시킬 예정)--------------
    //나중에 조건 줘서 1개로 메서드 만들기 mapper포함 @Param("cri")
//    List<BoardVO> adminGetListWithPagingByRegDate(@Param("cri") BoardCriteria cri);
//    List<BoardVO> adminGetListWithPagingByState(@Param("cri") BoardCriteria cri);

    List<BoardVO> adminGetListWithPagingBySn(AdminBoardCriteria cri);
    //List<BoardVO> adminGetListWithPagingBySn2(@Param("cri") BoardCriteria cri);

    //게시판 전체 개수를 가져온다
    int adminGetCountBySn(AdminBoardCriteria cri);

    int adminBoardRemove(String sn);
//    int adminBoardRemove(Long sn);

    int adminBoardUpdate(BoardVO board);


    //----------------------관리자 댓글 (나중에 관리자 파일로 옮기기)------------------------
    //게시판 댓글 페이징
    List<ReplyVO> adminReplyGetListWithPagingBySn(AdminReplyCriteria cri);

    //댓글 전체 개수
    int getCountBySn(AdminReplyCriteria cri);

    int adminReplyRemove(Long sn);

    int adminReplyUpdate(ReplyVO reply);
}
