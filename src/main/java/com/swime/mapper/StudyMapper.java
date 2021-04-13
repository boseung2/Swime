package com.swime.mapper;

import com.swime.domain.StudyCriteria;
import com.swime.domain.StudyParamVO;
import com.swime.domain.StudyVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface StudyMapper {
    public List<StudyVO> getList();

    public List<StudyVO> getListWithPaging(StudyCriteria cri);

    public int insert(StudyVO study);

    public int insertSelectKey(StudyVO study);

    public StudyVO get(Long sn);

    //스터디 내용 수정
    public int update(StudyVO study);
    
    //스터디 상태 수정
    public int updateStatus(StudyParamVO param);

}
