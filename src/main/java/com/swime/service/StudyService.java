package com.swime.service;

import com.swime.domain.*;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface StudyService {

    public void register(StudyVO study, List<String> qList);

    // 스터디정보와 참여인원 정보 같이 얻어오기
    public StudyVO get(Long sn);

    // 스터디 내용 수정
    public void modify(StudyVO study, List<String> qList);

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
}
