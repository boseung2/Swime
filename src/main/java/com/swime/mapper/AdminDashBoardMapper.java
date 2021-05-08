package com.swime.mapper;


import org.apache.ibatis.annotations.Param;

import java.util.Date;

public interface AdminDashBoardMapper {

    int countTodayUserRegister();

    int countTodayGroupRegister();

    int countTodayStudyRegister();

    int countUserRegisterByParam(@Param("year") int year, @Param("month") int month, @Param("day") int day);

    Date test(@Param("year") int year, @Param("month") int month, @Param("day") int day);

    int getVisitCount();

    int visitCountUp();

    Integer getVisitCountByTime(@Param("year") int year, @Param("month") int month, @Param("day") int day, @Param("hour") int hour);
}
