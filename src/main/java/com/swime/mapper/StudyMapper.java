package com.swime.mapper;

import com.swime.domain.StudyCriteria;
import com.swime.domain.StudyVO;

import java.util.List;

public interface StudyMapper {
    public List<StudyVO> getList();

    public void insert(StudyVO study);

    public void insertSelectKey(StudyVO study);

    public StudyVO read(Long sn);

    public int update(StudyVO study);

    public int delete(Long sn);

    //public List<StudyVO> getListWithPaging(StudyCriteria cri);


}
