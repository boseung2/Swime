package com.swime.service;

import com.swime.domain.GroupAttachVO;
import com.swime.domain.GroupCriteria;
import com.swime.domain.GroupVO;

import java.util.List;

public interface GroupService {

    // 모임을 생성한다.
    public int register(GroupVO group);

    // 해당 모임 모임상세를 불러온다.
    public GroupVO get(Long sn);

    // 모임 리스트를 불러온다.
    public List<GroupVO> getListWithPaging(GroupCriteria cri);

    // 모임 정보를 수정한다.
    public int modify(GroupVO group);

    // 모임을 삭제한다.
    public int remove(GroupVO group);

    public int getTotal(GroupCriteria cri);

    GroupAttachVO getAttach(Long grpSn);

}
