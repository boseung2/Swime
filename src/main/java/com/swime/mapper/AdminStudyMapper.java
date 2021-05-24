package com.swime.mapper;

import com.swime.domain.AdminStudyCriteria;
import com.swime.domain.AdminStudyPageDTO;
import com.swime.domain.AdminStudyVO;

import java.util.List;

public interface AdminStudyMapper {

    // 전체 스터디 리스트 반환
    public List<AdminStudyVO> getTotalStudyList(AdminStudyCriteria cri);

    public AdminStudyPageDTO getTotalCnt();

    // 예정된 스터디 리스트 반환
    public List<AdminStudyVO> getFutureStudyList(AdminStudyCriteria cri);

    // 지난 스터디 리스트 반환
    public List<AdminStudyVO> getPastStudyList(AdminStudyCriteria cri);

    // 삭제된 스터디 리스트 반환
    public List<AdminStudyVO> getDeletedStudy(AdminStudyCriteria cri);
}
