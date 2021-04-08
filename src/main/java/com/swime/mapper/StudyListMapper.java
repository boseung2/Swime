package com.swime.mapper;

import com.swime.domain.StudyCriteria;
import com.swime.domain.StudyListVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface StudyListMapper {
    public List<StudyListVO> getList();

    public List<StudyListVO> getListWithPaging(StudyCriteria cri);

    public int insert(StudyListVO attendant);

    public int update(@Param("stdSn") long stdSn, @Param("userId") String userId, @Param("status") String status);

    // 참여인원 세기
    public int count(long stdSn);
}
