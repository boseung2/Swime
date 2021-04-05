package com.swime.service;

import com.swime.domain.StudyVO;

import java.util.List;

public interface StudyService {
    public void register(StudyVO study);

    public StudyVO get(Long sn);

    public boolean modify(StudyVO study);

    public boolean remove(Long sn);

    public List<StudyVO> getList();
}
