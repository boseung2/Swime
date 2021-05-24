package com.swime.service;

import com.swime.domain.*;
import com.swime.mapper.AdminBoardMapper;
import com.swime.mapper.AdminStudyMapper;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Log4j
@Service
@AllArgsConstructor
public class AdminStudyServiceImpl implements AdminStudyService{

    @Setter(onMethod_ = @Autowired)
    private AdminStudyMapper mapper;

    @Transactional
    @Override
    public AdminStudyPageDTO getTotalStudyList(AdminStudyCriteria cri) {
        AdminStudyPageDTO adminStudyPageDTO = new AdminStudyPageDTO();

        adminStudyPageDTO.setStudyList(mapper.getTotalStudyList(cri));
        adminStudyPageDTO.setStudyCnt(mapper.getTotalCnt().getStudyCnt());

        return adminStudyPageDTO;
    }

    @Override
    public List<AdminStudyVO> getFutureStudyList(AdminStudyCriteria cri) {
        return mapper.getFutureStudyList(cri);
    }

    @Override
    public List<AdminStudyVO> getPastStudyList(AdminStudyCriteria cri) {
        return mapper.getPastStudyList(cri);
    }

    @Override
    public List<AdminStudyVO> getDeletedStudy(AdminStudyCriteria cri) {
        return mapper.getDeletedStudy(cri);
    }
}
