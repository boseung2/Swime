package com.swime.service;

import com.swime.domain.BoardVO;
import com.swime.mapper.BoardMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Log4j
@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService{

    private BoardMapper mapper;

    @Override
    public int register(BoardVO board) {
        return mapper.insertSelectKey(board);
    }

    @Override
    public BoardVO get(Long num) {
        return mapper.read(num);
    }

    @Override
    public int modify(BoardVO board) {
        return mapper.update(board);
    }

    @Override
    public int remove(Long num) {
        return mapper.delete(num);
    }

    @Override
    public List<BoardVO> getList() {
        return mapper.getList();
    }
}
