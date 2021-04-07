package com.swime.service;

import com.swime.domain.*;
import com.swime.mapper.StudyAnswerMapper;
import com.swime.mapper.StudyListMapper;
import com.swime.mapper.StudyMapper;
import com.swime.mapper.StudySurveyMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Log4j
@Service
public class StudyServiceImpl implements StudyService{

    @Setter(onMethod_ = @Autowired)
    private StudyMapper mapper;

    @Setter(onMethod_ = @Autowired)
    private StudyListMapper listMapper;

    @Setter(onMethod_ = @Autowired)
    private StudySurveyMapper surveyMapper;

    @Setter(onMethod_ = @Autowired)
    private StudyAnswerMapper answerMapper;

    @Override
    public int register(StudyVO study) {

        log.info("register........." + study);

        return mapper.insertSelectKey(study);
    }

    @Override
    public StudyVO get(Long sn) {

        log.info("get................." + sn);
        return mapper.read(sn);
    }

    @Override
    public int modify(StudyVO study) {

        log.info("modify.................." + study);

        return mapper.update(study);
    }

    @Override
    public int remove(Long sn) {

        log.info("remove...................." + sn);

        return mapper.delete(sn);
    }

    @Override
    public List<StudyVO> getList() {

        log.info("getList....................");

        return mapper.getList();
    }

    @Override
    public List<StudyVO> getList(StudyCriteria cri) {

        log.info("get List with criteria : " + cri);
        
        return mapper.getListWithPaging(cri);
    }

    //WishStudy
    @Override
    public List<StudyVO> getWishList(StudyCriteria cri) {
        return mapper.getWishListWithPaging(cri);
    }

    @Override
    public int wish(WishStudyVO wish) {
        return mapper.insertWishStudy(wish);
    }

    @Override
    public int cancelWish(Long stdSn, String userId) {
        return mapper.deleteWishStudy(stdSn, userId);
    }

    // StudyList
    @Override
    public List<StudyListVO> getAttendList() {
        return listMapper.getList();
    }

    @Override
    public List<StudyListVO> getAttendList(StudyCriteria cri) {
        return listMapper.getListWithPaging(cri);
    }

    @Override
    public int registerAttend(StudyListVO list) {
        return listMapper.insert(list);
    }

    @Override
    public int modifyAttend(long stdSn, String userId, String status) {
        return listMapper.update(stdSn, userId, status);
    }

    @Override
    public int AttendCount(long stdSn) {
        return listMapper.count(stdSn);
    }

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

    @Override
    public List<StudyAnswerVO> getAnswer(long stdSn, String userId) {
        return answerMapper.get(stdSn, userId);
    }

    @Override
    public int registerAnswer(StudyAnswerVO answer) {
        return answerMapper.insert(answer);
    }

    @Override
    public int removeAnswer(long stdSn, String userId) {
        return answerMapper.delete(stdSn, userId);
    }


}
