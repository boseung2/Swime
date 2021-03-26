package com.swime.mapper;

import com.swime.domain.StudyVO;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface StudyMapper {

    //@Select("select * from tstd")
    public List<StudyVO> getList();

    public void insert(StudyVO study);

    public void insertSelectKey(StudyVO study);

    public StudyVO read(Long num);

    public int delete(Long num);

    //내일 하기 2개 테이블 join하고 update
    public int update(StudyVO study);
}
