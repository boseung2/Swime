package com.swime.mapper;

import com.swime.domain.BoardCriteria;
import com.swime.domain.BoardLikeVO;
import com.swime.domain.BoardVO;

import java.util.List;

public interface BoardMapper {

    // 게시판 전체를 보여준다.
    public List<BoardVO> getList();

    // 게시판 페이징
    public List<BoardVO> getListWithPaging(BoardCriteria cri);

    public int insert(BoardVO board);

    // 게시판 생성
    public int insertSelectKey(BoardVO board);

    //게시판 상세정보
    public BoardVO read(Long sn);

    //게시판 삭제
    public int delete(Long sn);

    //게시판 업데이트
    public int update(BoardVO board);

    //게시판 내용 업데이트
    public int updateContent(BoardVO board);





}
