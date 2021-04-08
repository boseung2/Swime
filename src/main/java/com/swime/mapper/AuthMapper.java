package com.swime.mapper;

import com.swime.domain.AuthVO;

import java.util.List;

public interface AuthMapper {

    List<AuthVO> getList(String id);

    int insert(String id, String auth);

    int delete(String id, String auth);
}
