package com.swime.mapper;

import com.swime.domain.GroupCriteria;
import com.swime.domain.GroupVO;

import java.util.List;

public interface GroupMapper {

    public List<GroupVO> getList();

    public int insert(GroupVO group);

    public int insertSelectKey(GroupVO group);

    public GroupVO read(Long sn);

    public int delete(GroupVO group);

    public int update(GroupVO group);

    public List<GroupVO> getListWithPaging(GroupCriteria cri);

}
