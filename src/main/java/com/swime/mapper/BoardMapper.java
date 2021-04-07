package com.swime.mapper;

import com.swime.domain.BoardCriteria;
import com.swime.domain.BoardLikeVO;
import com.swime.domain.BoardVO;

import java.util.List;

public interface BoardMapper {

    public List<BoardVO> getList();

    public List<BoardVO> getListWithPaging(BoardCriteria cri);

    public int insert(BoardVO board);

    public int insertSelectKey(BoardVO board);

    public BoardVO read(Long sn);

    public int delete(Long sn);

    public int update(BoardVO board);

    //게시판 좋아요 개수를 센다.
    public int getBoardCnt(Long sn);




}
