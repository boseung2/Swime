package com.swime.mapper;

import com.swime.domain.BoardVO;

import java.util.List;

public interface BoardMapper {

    public List<BoardVO> getList();

    public void insert(BoardVO board);

    public void insertSelectKey(BoardVO board);

    public BoardVO read(Long sn);

    public int delete(Long sn);

    public int update(BoardVO board);

}
