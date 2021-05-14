package com.swime.mapper;

import com.swime.domain.*;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AdminBoardMapper {

    //---------- 관리자 게시판 (나중에 관리자 매퍼로 이동 시킬 예정)--------------

    //관리자 게시판 리스트 페이징
    List<BoardVO> adminGetListWithPagingBySn(AdminBoardCriteria cri);

    //게시판 전체 개수를 가져온다
    int adminGetCountBySn(AdminBoardCriteria cri);

    // 정상 -> 삭제
    int adminBoardRemove(String sn);

    // 삭제 -> 정상
    int adminBoardFromDeleteToActive(String sn);

    // 수정
    int adminBoardUpdate(BoardVO board);


    //----------------------관리자 댓글 (나중에 관리자 파일로 옮기기)------------------------
    //게시판 댓글 페이징
    List<ReplyVO> adminReplyGetListWithPagingBySn(AdminReplyCriteria cri);

    //댓글 전체 개수
    int getCountBySn(AdminReplyCriteria cri);

    int adminReplyRemove(String sn);

    int adminReplyFromDeleteToActive(String sn);

    int adminReplyUpdate(ReplyVO reply);
}
