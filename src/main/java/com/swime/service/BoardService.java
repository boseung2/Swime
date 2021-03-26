package com.swime.service;

import com.swime.domain.BoardVO;

import java.util.List;

public interface BoardService {

    public int register(BoardVO board);

    public BoardVO get(Long num);

    public int modify(BoardVO board);

    public int remove(Long num);

    public List<BoardVO> getList();



}
