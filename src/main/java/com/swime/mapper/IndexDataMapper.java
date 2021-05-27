package com.swime.mapper;

import com.swime.domain.GroupVO;
import com.swime.domain.StudyVO;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

public interface IndexDataMapper {

    List<GroupVO> popularGroupList(@Param("pageNum") int pageNum, @Param("amount") int amount);

    List<StudyVO> popularStudyList(@Param("pageNum") int pageNum, @Param("amount") int amount);

    Date timeTest();

    void setSessionTime();
}
