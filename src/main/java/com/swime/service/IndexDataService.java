package com.swime.service;

import com.swime.domain.GroupCriteria;
import com.swime.domain.GroupVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface IndexDataService {

    List<GroupVO> popularGroupList();

    List<GroupVO> popularStudyList();

    List<GroupVO> test(GroupCriteria cri);
}
