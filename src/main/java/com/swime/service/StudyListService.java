package com.swime.service;

import com.swime.domain.*;

import java.util.List;

public interface StudyListService {
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

}
