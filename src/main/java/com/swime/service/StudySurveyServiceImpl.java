package com.swime.service;

import com.swime.domain.*;
import com.swime.mapper.*;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Log4j
@Service
public class StudySurveyServiceImpl implements StudySurveyService{

    @Setter(onMethod_ = @Autowired)
    private StudySurveyMapper surveyMapper;

    //StudySurvey
    @Override
    public List<StudySurveyVO> getSurveyList(long stdSn) {
        return surveyMapper.getList(stdSn);
    }

    @Override
    public int registerSurvey(StudySurveyVO survey) {
        return surveyMapper.insert(survey);
    }

    @Override
    public int removeSurvey(long stdSn) {
        return surveyMapper.delete(stdSn);
    }
}
