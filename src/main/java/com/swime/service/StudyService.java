package com.swime.service;

import com.swime.domain.StudyVO;

import java.util.List;

public interface StudyService {
    public int register(StudyVO study);

    public StudyVO get(Long sn);

    public int modify(StudyVO study);

    public int remove(Long sn);

    public List<StudyVO> getList();
}
