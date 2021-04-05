package com.swime.service;

import com.swime.domain.GroupCriteria;
import com.swime.domain.GroupVO;
import com.swime.mapper.GroupMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Log4j
@Service
@AllArgsConstructor
public class GroupServiceImpl implements GroupService{

    private GroupMapper mapper;


    @Override
    public int register(GroupVO group) {
        return mapper.insertSelectKey(group);
    }

    @Override
    public GroupVO get(Long sn) {
        return mapper.read(sn);
    }

    @Override
    public boolean modify(GroupVO group) {
        return mapper.update(group) == 1;
    }

    @Override
    public boolean remove(GroupVO group) {
        return mapper.delete(group) == 1;
    }

    @Override
    public List<GroupVO> getList(GroupCriteria cri) {
        return mapper.getListWithPaging(cri);
    }
}
