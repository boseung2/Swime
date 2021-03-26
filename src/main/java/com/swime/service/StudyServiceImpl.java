package com.swime.service;

import com.swime.domain.StudyVO;
import com.swime.mapper.StudyMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Log4j
@Service
@AllArgsConstructor
public class StudyServiceImpl implements StudyService{


    private StudyMapper mapper;

    @Override
    public void register(StudyVO study) {

        log.info("register........." + study);

        mapper.insertSelectKey(study);
    }

    @Override
    public List<StudyVO> getList() {

        log.info("getList.......");

        return mapper.getList();
    }

    @Override
    public StudyVO get(Long num) {

        log.info("get......" + num);

        return mapper.read(num);
    }
    //StudyMapper update 작성 후 만들기.
    @Override
    public boolean modify(StudyVO study) {

        return false;
    }

    @Override
    public boolean remove(Long num) {

        log.info("remove" + num);

        return mapper.delete(num) == 1;
    }


}
