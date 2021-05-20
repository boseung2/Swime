package com.swime.mapper;

import com.swime.domain.AdminBoardCriteria;
import com.swime.domain.AdminGroupCriteria;
import com.swime.domain.GroupVO;

import java.util.List;

public interface AdminGroupMapper {

    //모임 리스트
    List<GroupVO> adminGetGroupListWithPagingBySn(AdminGroupCriteria cri);

    //모임 개수
    int adminGetCountBySn(AdminGroupCriteria cri);

    //모임 삭제
    int adminGroupRemove(Long sn);

    //모임 수정
    int adminGroupUpdate(GroupVO groupVO);
}
