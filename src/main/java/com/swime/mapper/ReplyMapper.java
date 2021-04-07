package com.swime.mapper;

import com.swime.domain.ReplyVO;

public interface ReplyMapper {

    public int insert(ReplyVO vo);

    public ReplyVO read(Long sn);

    public int delete(Long sn);

    public int update(ReplyVO reply);


    //댓글 개수를 센다
    public int getReplyCnt(Long brdSn);
}
