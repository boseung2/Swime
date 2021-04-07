package com.swime.mapper;



import com.swime.domain.GroupWishVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface GroupWishMapper {

    List<GroupWishVO> readByGroupSn(long grpSn);

    List<GroupWishVO> readByid(String id);

    int insert(GroupWishVO vo);

    int delete(@Param("id") String id, @Param("grpSn") long grpSn);

}
