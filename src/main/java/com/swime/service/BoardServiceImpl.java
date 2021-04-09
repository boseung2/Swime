package com.swime.service;

import com.swime.domain.BoardCriteria;
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
    public BoardVO get(Long sn) {

        log.info("get......" + sn);
        return mapper.read(sn);
    }

    @Override
    public boolean modify(BoardVO board) {

        log.info("modify: " + board);

        return mapper.update(board) == 1;
    }

    @Override
    public boolean remove(Long sn) {

        log.info("remove: " + sn);
        return mapper.delete(sn) == 1;
    }

    @Override
    public List<BoardVO> getListWithPaging(BoardCriteria cri) {

        log.info("get List with BoardCri: " + cri);
        return mapper.getListWithPaging(cri);
    }

//    @Override
//    public List<BoardVO> getList() {
//        return mapper.getList();
//    }
}
