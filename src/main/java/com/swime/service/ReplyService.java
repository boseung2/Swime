package com.swime.service;

import com.swime.domain.ReplyVO;

public interface ReplyService {

    public int register(ReplyVO vo);

    public ReplyVO get(Long sn);

    public int modify(ReplyVO vo);

    public int remove(Long sn);

    //페이징
    //public List<ReplyVO> getList
}
