package com.swime.mapper;

import com.swime.domain.BoardCriteria;
import com.swime.domain.BoardLikeVO;
import com.swime.domain.BoardVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface BoardMapper {

    // 게시판 전체를 보여준다.
    public List<BoardVO> getList();

    // 게시판 페이징
    public List<BoardVO> getListWithPaging(BoardCriteria cri);

    // 게시판 생성
    public int insertSelectKey(BoardVO board);

    public int insert(BoardVO board);

    //게시판 상세정보 읽기
    public BoardVO read(Long sn);

    //게시판 삭제
    public int delete(Long sn);

    //게시판 업데이트
    public int update(BoardVO board);

    //게시판 상세내용 업데이트
    public int updateContent(BoardVO board);

    // 댓글 개수
    public void updateReplyCnt(@Param("sn") long sn, @Param("amount") int amount);


    //댓글 개수 (trpl(댓글테이블)의 개수를 가져옴) - 필요없음
    //public int getReplyCnt(Long brdSn);







}
