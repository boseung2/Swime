package com.swime.service;

import com.swime.domain.*;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface StudyService {

    public int register(StudyVO study);

    // 스터디정보와 참여인원 정보 같이 얻어오기
    public StudyVO get(Long sn);

    public int modify(StudyVO study);

    public int remove(Long sn);

    public List<StudyVO> getList();

    public List<StudyVO> getList(StudyCriteria cri);

    // WishStudy
    public List<StudyVO> getWishList(StudyCriteria cri);

    public int registerWish(WishStudyVO wish);

    public int removeWish(Long stdSn,String userId);

    // StudyList
    public List<StudyListVO> getAttendantList();

    public List<StudyListVO> getAttendantList(StudyCriteria cri);

    public int registerAttendant(StudyListVO attendant);

    public int modifyAttendant(long stdSn, String userId, String status);

    public int countAttendants(long stdSn);

    //StudySurvey
    public List<StudySurveyVO> getSurveyList(long stdSn);

    public int registerSurvey(StudySurveyVO survey);

    public int removeSurvey(long stdSn);

    //StudyAnswer
    public List<StudyAnswerVO> getAnswer(long stdSn, String userId);

    public int registerAnswer(StudyAnswerVO answer);
    
    public int removeAnswer(long stdSn, String userId); //사용 안할지도
}
