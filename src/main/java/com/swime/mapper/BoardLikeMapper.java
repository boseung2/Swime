package com.swime.mapper;

import com.swime.domain.BoardLikeVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface BoardLikeMapper {
    // 좋아요 누를 시 유저 등록
    public int insert(BoardLikeVO boardLike);
    // 좋아요 취소 시 유저 삭제
    public int delete(@Param("brdSn") long brdSn,
                      @Param("userId")String userId);

    //게시판 좋아요 번호를 센다.
    public int getBoardLikeCnt(long brdSn);

    //유저가 해당 게시글의 좋아요를 눌렀으면 1 아니면 0 이렇게 할 거임.
//    public int get(@Param("brdSn") long brdSn,
//                                 @Param("userId")String userId);
    public BoardLikeVO get(BoardLikeVO boardLike);

}
