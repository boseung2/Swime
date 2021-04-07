package com.swime.mapper;

import com.swime.domain.BoardCriteria;
import com.swime.domain.ReplyVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ReplyMapper {

    public int insert(ReplyVO vo);

    public ReplyVO read(Long sn);

    public int delete(Long sn);

    public int update(ReplyVO reply);

    public List<ReplyVO> getListWithPaging(
            @Param("cri") BoardCriteria cri,
            @Param("brdSn") Long brdSn);

    //댓글의 개수
    public int getCountBySn(Long sn);



    //댓글 개수를 센다
    //public int getReplyCnt(Long brdSn);
}
