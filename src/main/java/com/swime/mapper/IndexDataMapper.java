package com.swime.mapper;

import com.swime.domain.GroupVO;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

public interface IndexDataMapper {

    List<GroupVO> popularGroupList(@Param("pageNum") int pageNum, @Param("amount") int amount);

    List<GroupVO> popularStudyList();

    Date timeTest();

    void setSessionTime();
}
