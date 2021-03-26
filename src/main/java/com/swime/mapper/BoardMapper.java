package com.swime.mapper;

import com.swime.domain.BoardVO;

import java.util.List;

public interface BoardMapper {

    public List<BoardVO> getList();

    public int insert(BoardVO board);

    public int insertSelectKey(BoardVO board);

    public BoardVO read(Long num);

    public int delete(Long num);

    public int update(BoardVO board);
}
