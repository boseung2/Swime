package com.swime.service;

import com.swime.domain.*;
import com.swime.mapper.BoardMapper;
import org.apache.ibatis.annotations.Param;

public interface AdminBoardService {

    //------------------------관리자 게시판----------------------------

    //List<BoardVO> adminGetListWithPagingBySn(@Param("cri") BoardCriteria cri);
    AdminBoardPageDTO adminGetListWithPagingBySn(AdminBoardCriteria cri);
    //AdminBoardPageDTO adminGetListWithPagingBySn(@Param("cri") BoardCriteria cri);


    //---------------------------관리자 댓글---------------------------
    ReplyPageDTO adminReplyGetListWithPagingBySn(AdminReplyCriteria cri);

}
