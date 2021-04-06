package com.swime.service;

import com.swime.domain.BoardCriteria;
import com.swime.domain.BoardVO;

import java.util.List;

public interface BoardService {

    public int register(BoardVO board);

    public BoardVO get(Long sn);

    public boolean modify(BoardVO board);

    public boolean remove(Long sn);

    public List<BoardVO> getListWithPaging(BoardCriteria cri);

}
