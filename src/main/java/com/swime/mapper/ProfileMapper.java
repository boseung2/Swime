package com.swime.mapper;


import com.swime.domain.GroupVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface ProfileMapper {

    List<GroupVO> ownerList(String id);

    GroupVO read(@Param("sn") Long sn, @Param("id") String id);

    List<GroupVO> joinList(String id);

    List<GroupVO> wishList(String id);



}
