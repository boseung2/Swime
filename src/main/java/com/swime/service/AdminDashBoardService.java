package com.swime.service;


import com.swime.domain.*;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AdminDashBoardService {

    int countTodayUserRegister();
    DashBoardModalDataDTO todayUserRegister();

    int countTodayGroupRegister();
    DashBoardModalDataDTO todayGroupRegister();

    int countTodayStudyRegister();
    DashBoardModalDataDTO todayStudyRegister();

    Integer[] countUserRegisterByParam(@Param("year") int year, @Param("month") int month);

    void visitCountUp();

    Integer[] getVisitCountByTime(@Param("year") int year, @Param("month") int month, @Param("day") int day);

    List<DashBoardLangVO> getDashBoardLang();

    List<DashBoardLocaleVO> getDashBoardLocale();
}
