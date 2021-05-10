package com.swime.service;


import com.swime.domain.AuthVO;
import com.swime.domain.DashBoardLangVO;
import com.swime.domain.DashBoardLocaleVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface AdminDashBoardService {

    int countTodayUserRegister();

    int countTodayGroupRegister();

    int countTodayStudyRegister();

    Integer[] countUserRegisterByParam(@Param("year") int year, @Param("month") int month);

    void visitCountUp();

    Integer[] getVisitCountByTime(@Param("year") int year, @Param("month") int month, @Param("day") int day);

    List<DashBoardLangVO> getDashBoardLang();

    List<DashBoardLocaleVO> getDashBoardLocale();
}
