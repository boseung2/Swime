package com.swime.service;

import com.swime.domain.*;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface BoardService {

    //모임별 게시글 리스트
    public List<BoardVO> getList(long grpSn);

    //게시글 생성
    public int register(BoardVO board);

    //게시글 상세 조회
    public BoardVO get(Long sn);

    //게시글 수정
    public boolean modify(BoardVO board);

    //게시글 삭제
    public boolean remove(Long sn);

    //댓글 개수
    //public int getReplyCnt(Long brdSn);

    //그룹별 게시글 리스트(페이징)
    public GroupBoardPageDTO getListWithPaging(@Param("cri") BoardCriteria cri,
                                               @Param("grpSn") long grpSn);

    // 첨부파일
    public List<BoardAttachVO> getAttachList(Long brdSn);


    //현재 사용 x
    public int getTotal(BoardCriteria cri);

    //------------------------관리자 게시판----------------------------

    //List<BoardVO> adminGetListWithPagingBySn(@Param("cri") BoardCriteria cri);
    AdminBoardPageDTO adminGetListWithPagingBySn(@Param("cri") BoardCriteria cri);




}
