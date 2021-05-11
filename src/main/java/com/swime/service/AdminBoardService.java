package com.swime.service;

import com.swime.domain.AdminBoardCriteria;
import com.swime.domain.AdminBoardPageDTO;
import com.swime.domain.BoardCriteria;
import com.swime.mapper.BoardMapper;

public interface AdminBoardService {

    //------------------------관리자 게시판----------------------------

    //List<BoardVO> adminGetListWithPagingBySn(@Param("cri") BoardCriteria cri);
    AdminBoardPageDTO adminGetListWithPagingBySn(AdminBoardCriteria cri);
    //AdminBoardPageDTO adminGetListWithPagingBySn(@Param("cri") BoardCriteria cri);

}
