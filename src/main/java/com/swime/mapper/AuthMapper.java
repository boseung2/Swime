package com.swime.mapper;

import com.swime.domain.AuthVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AuthMapper {

    List<AuthVO> getList(String id);

    int insert(@Param("id") String id, @Param("auth") String auth);

    int delete(@Param("id") String id, @Param("auth") String auth);
}
