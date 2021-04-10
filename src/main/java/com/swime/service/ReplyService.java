package com.swime.service;

import com.swime.domain.BoardCriteria;
import com.swime.domain.ReplyPageDTO;
import com.swime.domain.ReplyVO;

import java.util.List;

public interface ReplyService {

    public int register(ReplyVO reply);

    public ReplyVO get(Long sn);

    public int modify(ReplyVO reply);

    public int remove(Long sn);

    //댓글페이징
    public List<ReplyVO> getList(BoardCriteria cri, Long brd_sn);

    //댓글, 댓글 수 처리
    public ReplyPageDTO getListPage(BoardCriteria cri, Long brd_sn);
}
