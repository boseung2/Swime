package com.swime.service;

import com.swime.domain.BoardCriteria;
import com.swime.domain.ReplyPageDTO;
import com.swime.domain.ReplyVO;
import com.swime.mapper.ReplyMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Log4j
@AllArgsConstructor
public class ReplyServiceImpl implements ReplyService{

    private ReplyMapper mapper;

    @Override
    public int register(ReplyVO vo) {

        log.info("register: " + vo);
        return mapper.insert(vo);
    }

    @Override
    public ReplyVO get(Long sn) {

        log.info("get: " + sn);
        return mapper.read(sn);
    }

    @Override
    public int modify(ReplyVO vo) {

        log.info("modify" + vo);
        return mapper.update(vo);
    }

    @Override
    public int remove(Long sn) {

        log.info("remove" + sn);
        return mapper.delete(sn);
    }

    @Override
    public List<ReplyVO> getList(BoardCriteria cri, Long brd_sn) {

        log.info("get Reply List of Board");
        return mapper.getListWithPaging(cri, brd_sn);
    }

    @Override
    public ReplyPageDTO getListPage(BoardCriteria cri, Long sn) {

        return new ReplyPageDTO(
                mapper.getCountBySn(sn),
                mapper.getListWithPaging(cri,sn)
        );
    }

}
