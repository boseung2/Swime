package com.swime.service;

import com.swime.domain.BoardCriteria;
import com.swime.domain.BoardPageDTO;
import com.swime.domain.BoardVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface BoardService {

    //모임별 게시글 리스트
    public List<BoardVO> getList(long grpSn);

    public int register(BoardVO board);

    public BoardVO get(Long sn);

    public boolean modify(BoardVO board);

    public boolean remove(Long sn);

    //댓글 개수
    //public int getReplyCnt(Long brdSn);

    //그룹별 게시글 리스트(페이징)
    public BoardPageDTO getListWithPaging(@Param("cri") BoardCriteria cri,
                                          @Param("grpSn") long grpSn);


    public int getTotal(BoardCriteria cri);



}
