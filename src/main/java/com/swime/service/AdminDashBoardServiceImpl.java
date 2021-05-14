package com.swime.service;

import com.swime.domain.DashBoardLangVO;
import com.swime.domain.DashBoardLocaleVO;
import com.swime.domain.DashBoardModalDataDTO;
import com.swime.domain.DashBoardModalDataVO;
import com.swime.mapper.AdminDashBoardMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Calendar;
import java.util.Date;
import java.util.List;


@Log4j
@Service
public class AdminDashBoardServiceImpl implements AdminDashBoardService{

    @Setter(onMethod_ = @Autowired)
    private AdminDashBoardMapper mapper;


    @Override
    public int countTodayUserRegister() {
        return mapper.countTodayUserRegister();
    }

    @Override
    public DashBoardModalDataDTO todayUserRegister() {
        DashBoardModalDataDTO dto = new DashBoardModalDataDTO();
        dto.setList(mapper.todayUserRegister());
        dto.setCount(mapper.countTodayUserRegister());
        return dto;
    }

    @Override
    public int countTodayGroupRegister() {
        return mapper.countTodayGroupRegister();
    }

    @Override
    public DashBoardModalDataDTO todayGroupRegister() {
        DashBoardModalDataDTO dto = new DashBoardModalDataDTO();
        dto.setList(mapper.todayGroupRegister());
        dto.setCount(mapper.countTodayGroupRegister());
        return dto;
    }

    @Override
    public int countTodayStudyRegister() {
        return mapper.countTodayStudyRegister();
    }

    @Override
    public DashBoardModalDataDTO todayStudyRegister() {
        DashBoardModalDataDTO dto = new DashBoardModalDataDTO();
        dto.setList(mapper.todayStudyRegister());
        dto.setCount(mapper.countTodayStudyRegister());
        return dto;
    }

    @Override
    public Integer[] countUserRegisterByParam(int year, int month) {
        Calendar cal = Calendar.getInstance();
        cal.set(year,month-1,01);

        int endDay = cal.getActualMaximum(Calendar.DAY_OF_MONTH);

        Integer[] list = new Integer[endDay];

        for (int i = 0; i < endDay; i++) {
            list[i] = mapper.countUserRegisterByParam(year, month, i+1);
        }

        return list;
    }

    @Override
    public void visitCountUp() {
        mapper.visitCountUp();
    }

    @Override
    public Integer[] getVisitCountByTime(int year, int month, int day) {
        Integer[] list = new Integer[24];
        Integer tmp;

        for (int i = 0; i < 24; i++) {
            tmp = mapper.getVisitCountByTime(year, month, day,i);
            list[i] = tmp == null ? 0 : tmp;
        }
        return list;
    }

    @Override
    public List<DashBoardLangVO> getDashBoardLang() {
        return mapper.getDashBoardLang();
    }

    @Override
    public List<DashBoardLocaleVO> getDashBoardLocale() {
        return mapper.getDashBoardLocale();
    }

    @Override
    public Date test2() {
        return mapper.test2();
    }
}
