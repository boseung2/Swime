package com.swime.service;

import com.swime.domain.GroupCriteria;
import com.swime.domain.GroupVO;

import java.util.List;

public interface GroupService {

    public int register(GroupVO group);

    public GroupVO get(Long sn);

    public List<GroupVO> getListWithPaging(GroupCriteria cri);

    public boolean modify(GroupVO group);

    public boolean remove(GroupVO group);

}
