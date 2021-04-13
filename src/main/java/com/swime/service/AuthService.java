package com.swime.service;


import com.swime.domain.AuthVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AuthService {

    List<AuthVO> getList(String id);

    boolean register(@Param("id") String id, @Param("auth") String auth);

    boolean remove(@Param("id") String id);

    boolean removeAuth(@Param("id") String id, @Param("auth") String auth);

    AuthVO select(@Param("id") String id, @Param("auth") String auth);

    boolean isAready(@Param("id") String id, @Param("auth") String auth);

}
