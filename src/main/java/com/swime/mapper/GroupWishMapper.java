package com.swime.mapper;



import com.swime.domain.GroupWishVO;

import java.util.List;

public interface GroupWishMapper {

    List<GroupWishVO> getList();

    int insert(GroupWishVO vo);

    int insertSelectKey(GroupWishVO vo);

    int update(GroupWishVO vo);

}
