package com.swime.service;

import com.swime.domain.*;
import com.swime.mapper.BoardMapper;
import org.apache.ibatis.annotations.Param;

public interface AdminBoardService {

    //------------------------관리자 게시판----------------------------
    AdminBoardPageDTO adminGetListWithPagingBySn(AdminBoardCriteria cri);

    int adminBoardRemove(String sn);

    int adminBoardFromDeleteToActive(String sn);

//    int adminBoardUpdate(BoardVO board);

    //---------------------------관리자 댓글---------------------------
    ReplyPageDTO adminReplyGetListWithPagingBySn(AdminReplyCriteria cri);

    int adminReplyRemove(String sn);

    int adminReplyFromDeleteToActive(String sn);

}
