package com.swime.mapper;

import com.swime.domain.AdminBoardCriteria;
import com.swime.domain.BoardCriteria;
import com.swime.domain.BoardVO;

import java.util.List;

public interface AdminBoardMapper {

    //---------- 관리자 게시판 (나중에 관리자 매퍼로 이동 시킬 예정)--------------
    //나중에 조건 줘서 1개로 메서드 만들기 mapper포함 @Param("cri")
//    List<BoardVO> adminGetListWithPagingByRegDate(@Param("cri") BoardCriteria cri);
//    List<BoardVO> adminGetListWithPagingByState(@Param("cri") BoardCriteria cri);

    List<BoardVO> adminGetListWithPagingBySn(AdminBoardCriteria cri);
    //List<BoardVO> adminGetListWithPagingBySn2(@Param("cri") BoardCriteria cri);

    //게시판 전체 개수를 가져온다
    int adminGetCountBySn();

    int adminRemove(Long sn);

    int adminUpdate(BoardVO board);
}
