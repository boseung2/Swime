package com.swime.service;

import com.swime.domain.*;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface StudyService {

    public int register(StudyVO study);

    // 스터디정보와 참여인원 정보 같이 얻어오기
    public StudyVO get(Long sn);

    // 스터디 내용 수정
    public int modify(StudyVO study);

    // 스터디 모집 종료
    public int endStudy(StudyParamVO param);

    // 스터디 삭제
    public int remove(StudyParamVO param);

    // 스터디 리스트 for 관리자페이지
    public List<StudyVO> getList(long grpSn);

    // 그룹별 스터디 리스트
    public GroupStudyListDTO getList(StudyCriteria cri, long grpSn);

    public GroupStudyListDTO getPastList(StudyCriteria cri, long grpSn);

    public int countStudy(long grpSn);

    // WishStudy
    public List<StudyVO> getWishList(StudyCriteria cri, String userId);

    public WishStudyVO getWish(StudyParamVO param);

    public int registerWish(WishStudyVO wish);

    public int removeWish(StudyParamVO param);

    // StudyList
    public List<StudyListVO> getAttendantList(long stdSn);

    public List<StudyListVO> getAttendantList(StudyCriteria cri, long stdSn);

    public List<StudyListVO> getWaitingList(long stdSn);

    public List<StudyListVO> getWaitingList(StudyCriteria cri, long stdSn);

    public List<StudyListVO> getBanList(long stdSn);

    public StudyListVO getAttendant(StudyParamVO param);

    // 해당 모임의 해당 유저가 참가한 스터디를 모두 가져온다.
    public List<StudyVO> getStudiesOfGroup(long grpSn, String userId);

    public int registerAttendant(StudyParamVO param);

    public int modifyAttendant(StudyParamVO param);

    // 스터디 참여명단에서 삭제하고 해당 스터디에 해당 유저의 설문답변이 남아있으면 지운다.
    public int removeAttendant(StudyParamVO param);

    public int countAttendants(long stdSn);

    // 등록을 위해 해당 스터디의 유저 가입상태를 확인해주는 함수
    public int checkAttendantForRegister (StudyParamVO param);

    // 탈퇴를 위해 해당 스터디의 유저 가입상태를 확인해주는 함수
    public int checkAttendantForRemove (StudyParamVO param);

    //StudySurvey
    public List<StudySurveyVO> getSurveyList(long stdSn);

    public int registerSurvey(StudySurveyVO survey);

    public int removeSurvey(long stdSn);

    //StudyAnswer
    public List<StudyAnswerVO> getAnswer(StudyParamVO param);

    // 답변들을 등록하고 해당 멤버를 검토중인 상태로 등록 또는 수정
    public void registerAnswers(List<StudyAnswerVO> answers);
    
    public int removeAnswer(StudyParamVO param);
}
