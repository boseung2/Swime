package com.swime.mapper;



import com.swime.domain.GroupWishVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface GroupWishMapper {

    int insert(GroupWishVO vo);

    GroupWishVO read(GroupWishVO vo);

    int delete(GroupWishVO vo);

    List<GroupWishVO> readByGroupSn(long grpSn);

    List<GroupWishVO> readByid(String id);

    int delete(@Param("id") String id, @Param("grpSn") long grpSn);

}
