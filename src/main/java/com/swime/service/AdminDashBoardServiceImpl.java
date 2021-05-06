package com.swime.service;

import com.swime.mapper.AdminDashBoard;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


@Log4j
@Service
//@AllArgsConstructor
public class AdminDashBoardServiceImpl implements AdminDashBoardService{

    @Setter(onMethod_ = @Autowired)
    private AdminDashBoard mapper;


    @Override
    public int countTodayUserRegister() {
        return mapper.countTodayUserRegister();
    }

    @Override
    public int countTodayGroupRegister() {
        return mapper.countTodayGroupRegister();
    }

    @Override
    public int countTodayStudyRegister() {
        return mapper.countTodayStudyRegister();
    }
}
