package com.swime.service;

import com.swime.domain.*;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface StudyService {
    public int register(StudyVO study);

    public StudyVO get(Long sn);

    public int modify(StudyVO study);

    public int remove(Long sn);

    public List<StudyVO> getList();

    public List<StudyVO> getList(StudyCriteria cri);

    // WishStudy
    public List<StudyVO> getWishList(StudyCriteria cri);

    public int wish(WishStudyVO wish);

    public int cancelWish(Long stdSn,String userId);

    // StudyList
    public List<StudyListVO> getAttendList();

    public List<StudyListVO> getAttendList(StudyCriteria cri);

    public int registerAttend(StudyListVO list);

    public int modifyAttend(long stdSn, String userId, String status);

    public int AttendCount(long stdSn);

    //StudySurvey
    public List<StudySurveyVO> getSurveyList(long stdSn);

    public int registerSurvey(StudySurveyVO survey);

    public int removeSurvey(long stdSn);

    //StudyAnswer
    public List<StudyAnswerVO> getAnswer(long stdSn, String userId);

    public int registerAnswer(StudyAnswerVO answer);

    public int removeAnswer(long stdSn, String userId);
}
