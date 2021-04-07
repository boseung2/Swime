package com.swime.mapper;

import com.swime.domain.BoardCriteria;
import com.swime.domain.BoardLikeVO;
import com.swime.domain.BoardVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface BoardLikeMapper {

    // 좋아요 누를 시 유저 등록
    public int insert(BoardLikeVO board);
    // 좋아요 취소 시 유저 삭제
    public int delete(@Param("brdSn")Long brdSn,
                      @Param("userId")String userId);

    //public BoardLikeVO read(Long sn);

}
