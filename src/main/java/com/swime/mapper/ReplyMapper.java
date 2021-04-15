package com.swime.mapper;

import com.swime.domain.BoardCriteria;
import com.swime.domain.ReplyVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ReplyMapper {

    //댓글 sn을 commentGroup에 넣어주기 위한 seq
    public int getSequence();

    public int insert(ReplyVO reply);

    public ReplyVO read(Long sn);

    public int delete(Long sn);

    public int update(ReplyVO reply);

    public List<ReplyVO> getListWithPaging(
            @Param("cri") BoardCriteria cri,
            @Param("brdSn") Long brdSn);

    //댓글의 개수(페이징 처리 시 전체 댓글 숫자 파악) -사용중
    public int getCountByBrdSn(Long brdSn);

    //댓글 개수를 게시판에 보여주는 메서드 -- 미사용
    //public int getReplyCnt(Long brdSn);

    // 댓글 개수 증가, 감소 업데이트 long
    // (댓글개수를 amount로 받아서 증가 감소 시킴)
    public void updateReplyCnt(@Param("sn") Long sn, @Param("amount") int amount);



}
