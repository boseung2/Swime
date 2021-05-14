package com.swime.mapper;


import com.swime.domain.DashBoardLangVO;
import com.swime.domain.DashBoardLocaleVO;
import com.swime.domain.DashBoardModalDataVO;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

public interface AdminDashBoardMapper {

    int countTodayUserRegister();
    List<DashBoardModalDataVO> todayUserRegister();

    int countTodayGroupRegister();
    List<DashBoardModalDataVO> todayGroupRegister();

    int countTodayStudyRegister();
    List<DashBoardModalDataVO> todayStudyRegister();

    int countUserRegisterByParam(@Param("year") int year, @Param("month") int month, @Param("day") int day);

    Date test(@Param("year") int year, @Param("month") int month, @Param("day") int day);
    Date test2();

    int getVisitCount();

    int visitCountUp();

    Integer getVisitCountByTime(@Param("year") int year, @Param("month") int month, @Param("day") int day, @Param("hour") int hour);

    List<DashBoardLangVO> getDashBoardLang();

    List<DashBoardLocaleVO> getDashBoardLocale();
}
