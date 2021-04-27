package com.swime.service;

import com.swime.domain.BoardCriteria;
import com.swime.domain.BoardPageDTO;
import com.swime.domain.BoardVO;
import com.swime.domain.GroupBoardPageDTO;
import com.swime.mapper.BoardMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Log4j
@Service
@AllArgsConstructor
public class BoardServiceImpl implements BoardService{

    private BoardMapper mapper;

    @Override
    public List<BoardVO> getList(long grpSn) {
        return mapper.getList(grpSn);
    }

    @Override
    public int register(BoardVO board) {

        return mapper.insertSelectKey(board);
    }

    @Override
    public BoardVO get(Long sn) {

        log.info("get......" + sn);
        return mapper.read(sn);
    }

    @Transactional
    @Override
    public boolean modify(BoardVO board) {
        log.info("modify: " + board);
        //게시판 수정
        int count1 = mapper.update(board);
        //게시판 내용(content)수정
        int count2 = mapper.updateContent(board);

        return mapper.update(board) == 1;
    }

    @Transactional
    @Override
    public boolean remove(Long sn) {

        log.info("remove: " + sn);
        return mapper.delete(sn) == 1;
    }


//    @Override
//    public List<BoardVO> getListWithPaging(BoardCriteria cri, long grpSn) {
//
//        log.info("get List with BoardCri: " + cri);
//        return mapper.getListWithPaging(cri, grpSn);
//    }

    @Override
    public GroupBoardPageDTO getListWithPaging(BoardCriteria cri, long grpSn){

        return new GroupBoardPageDTO(
                mapper.getCountBySn(grpSn),
                mapper.getListWithPaging(cri, grpSn));
    }

    @Override
    public int getTotal(BoardCriteria cri) {

        return mapper.getTotalCount(cri);
    }



//    @Override
//    public List<BoardVO> getList() {
//        return mapper.getList();
//    }
}
