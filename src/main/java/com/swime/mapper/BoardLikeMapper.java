package com.swime.mapper;

import com.swime.domain.BoardCriteria;
import com.swime.domain.BoardLikeVO;
import com.swime.domain.BoardVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface BoardLikeMapper {

    public int insert(BoardLikeVO board);

    //public int insertSelectKey(BoardLikeVO board);

    //public BoardLikeVO read(Long sn);

    public int delete(@Param("brdSn")Long brdSn,
                      @Param("userId")String userId);

}
