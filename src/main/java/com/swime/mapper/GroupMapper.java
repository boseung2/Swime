package com.swime.mapper;

import com.swime.domain.GroupVO;

import java.util.List;

public interface GroupMapper {
    public void insertGroup(GroupVO group);

    public void insertSelectKey(GroupVO group);

    public GroupVO readGroup(Long num);

    public int deleteGroup(Long num);

    public int updateGroup(GroupVO group);

    public List<GroupVO> getGroupList();

}
