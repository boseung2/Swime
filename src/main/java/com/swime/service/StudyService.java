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

    // 그룹별 예정된 스터디 리스트
    public GroupStudyListDTO getList(StudyCriteria cri, long grpSn);

    // 그룹별 지난 스터디 리스트
    public GroupStudyListDTO getPastList(StudyCriteria cri, long grpSn);

    // 그룹별 스터디 개수
    public int countStudy(long grpSn);

    // WishStudy

    // 유저가 찜한 스터디 리스트
    public List<StudyVO> getWishList(StudyCriteria cri, String userId);

    // 유저의 스터디 찜 여부 반환
    public WishStudyVO getWish(WishStudyVO wish);

    // 스터디 찜
    public int registerWish(WishStudyVO wish);

    // 스터디 찜 취소
    public int removeWish(WishStudyVO wish);

    // StudyList
    
    // 참여멤버 리스트
    public List<StudyListVO> getAttendantList(long stdSn);

    // 참여멤버 리스트 (페이징 처리)
    public List<StudyListVO> getAttendantList(StudyCriteria cri, long stdSn);

    // 대기멤버 리스트
    public List<StudyListVO> getWaitingList(long stdSn);

    // 대기멤버 리스트 (페이징 처리)
    public List<StudyListVO> getWaitingList(StudyCriteria cri, long stdSn);

    // 영구강퇴 멤버 리스트
    public List<StudyListVO> getBanList(long stdSn);

    // 참여명단에서 해당 유저의 정보 가져오기
    public StudyListVO getAttendant(StudyParamVO param);

    // 해당 모임의 해당 유저가 참가한 스터디를 모두 가져오기
    public List<StudyVO> getStudiesOfGroup(long grpSn, String userId);

    // 참석
    public int registerAttendant(StudyParamVO param);

    // 유저의 참석명단 정보를 변경 (상태 변경)
    public int modifyAttendant(StudyParamVO param);

    // 스터디 참여명단에서 삭제하고 해당 스터디에 해당 유저의 설문답변이 남아있으면 지우기
    public int removeAttendant(StudyParamVO param);

    // 스터디 참여멤버 수를 반환
    public int countAttendants(long stdSn);

    // 등록을 위해 해당 스터디의 유저 가입상태를 확인해주는 함수
    public int checkAttendantForRegister (StudyParamVO param);

    // 탈퇴를 위해 해당 스터디의 유저 가입상태를 확인해주는 함수
    public int checkAttendantForRemove (StudyParamVO param);

    //StudySurvey
    
    //설문 리스트 반환
    public List<StudySurveyVO> getSurveyList(long stdSn);

    // 설문 등록
    public int registerSurvey(StudySurveyVO survey);

    // 설문 삭제
    public int removeSurvey(long stdSn);

    //StudyAnswer
    
    // 답변 가져오기
    public List<StudyAnswerVO> getAnswer(StudyParamVO param);

    // 답변들을 등록하고 해당 멤버를 검토중인 상태로 등록 또는 수정
    public void registerAnswers(List<StudyAnswerVO> answers);
    
    // 답변 삭제
    public int removeAnswer(StudyParamVO param);
}
