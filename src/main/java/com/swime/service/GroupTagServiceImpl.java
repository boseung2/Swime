package com.swime.service;

import com.swime.domain.GroupTagVO;
import com.swime.mapper.GroupTagMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Log4j
@Service
@AllArgsConstructor
public class GroupTagServiceImpl implements GroupTagService{

    private GroupTagMapper mapper;

    @Override
    public int register(List<GroupTagVO> list) {
        list.forEach(mapper::insert);
        return 1;
    }

    @Override
    public List<GroupTagVO> getList(Long grpSn) {
        return mapper.getList(grpSn);
    }

    @Override
    public int delete(Long grpSn) {
        return mapper.delete(grpSn);
    }

}
