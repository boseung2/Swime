package com.swime.mapper;

import com.swime.domain.BoardCriteria;
import com.swime.domain.BoardLikeVO;
import com.swime.domain.BoardVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface BoardMapper {

    // 모임별 게시판
    public List<BoardVO> getList(long grpSn);

    // 게시판 생성
    public int insertSelectKey(BoardVO board);
    // 사용x
    public int insert(BoardVO board);

    //게시판 읽기
    public BoardVO read(Long sn);

    //게시판 삭제
    public int delete(Long sn);

    //게시판 업데이트
    public int update(BoardVO board);

    //게시판 상세내용 업데이트
    public int updateContent(BoardVO board);

    // 게시판 페이징
    public List<BoardVO> getListWithPaging(@Param("cri") BoardCriteria cri,
                                           @Param("grpSn") long grpSn);

    //모임별 게시물 개수 - 게시판 페이징 처리 시 전체 게시물의 숫자를 파악
    public int getCountBySn(long sn);


    // 댓글 개수
    public void updateReplyCnt(@Param("sn") long sn, @Param("amount") int amount);



    //전체 게시물 개수 - 현재 사용 x / 나중에 사용 가능성 있어서 냅둠
    public int getTotalCount(BoardCriteria cri);

    //댓글 개수 (trpl(댓글테이블)의 개수를 가져옴) - 필요없음
    //public int getReplyCnt(Long brdSn);



    //---------- 관리자 게시판 (나중에 관리자 매퍼로 이동 시킬 예정)--------------
    //나중에 조건 줘서 1개로 메서드 만들기 mapper포함
    List<BoardVO> adminGetListWithPagingByRegDate(@Param("cri") BoardCriteria cri);
    List<BoardVO> adminGetListWithPagingByState(@Param("cri") BoardCriteria cri);

    List<BoardVO> adminGetListWithPagingBySn(@Param("cri") BoardCriteria cri);

    //게시판 전체 개수를 가져온다
    int adminGetCountBySn();

    int adminRemove(Long sn);

    int adminUpdate(BoardVO board);









}
