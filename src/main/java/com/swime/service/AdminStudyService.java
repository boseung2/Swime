package com.swime.service;

import com.swime.domain.*;

import java.util.List;

public interface AdminStudyService {
    // 전체 스터디 리스트 반환
    public AdminStudyPageDTO getTotalStudyList(AdminStudyCriteria cri);

    // 예정된 스터디 리스트 반환
    public List<AdminStudyVO> getFutureStudyList(AdminStudyCriteria cri);

    // 지난 스터디 리스트 반환
    public List<AdminStudyVO> getPastStudyList(AdminStudyCriteria cri);

    // 삭제된 스터디 리스트 반환
    public List<AdminStudyVO> getDeletedStudy(AdminStudyCriteria cri);

}
