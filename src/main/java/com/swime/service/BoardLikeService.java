package com.swime.service;

import com.swime.domain.BoardLikeVO;
import org.apache.ibatis.annotations.Param;

public interface BoardLikeService {

    public int register(BoardLikeVO boardLike);

    public int remove(@Param("brdSn")Long brdSn, @Param("userId") String userId);

    public int getBoardLikeCnt(Long brdSn);

}
