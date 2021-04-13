package com.swime.mapper;

import com.swime.domain.BoardLikeVO;
import org.apache.ibatis.annotations.Param;

public interface BoardLikeMapper {
    // 좋아요 누를 시 유저 등록
    public int insert(BoardLikeVO board);
    // 좋아요 취소 시 유저 삭제
    public int delete(@Param("brdSn")Long brdSn,
                      @Param("userId")String userId);

    //게시판 좋아요 번호를 센다.
    public int getBoardLikeCnt(Long brdSn);
}
