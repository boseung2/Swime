package com.swime.mapper;

import com.swime.domain.StudyCriteria;
import com.swime.domain.StudyVO;

import java.util.List;

public interface StudyMapper {

    public List<StudyVO> getList();

    public List<StudyVO> getListWithPaging(StudyCriteria cri);


}
