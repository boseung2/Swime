package com.swime.service;


import com.swime.domain.AuthVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AdminDashBoardService {

    int countTodayUserRegister();

    int countTodayGroupRegister();

    int countTodayStudyRegister();

    Integer[] countUserRegisterByParam(@Param("year") int year, @Param("month") int month);
}
