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

    private GroupMapper groupMapper;

    @Override
    public int register(GroupVO group) {
        //모임을 생성한다.
        // 기본정보 세팅 - o
        groupMapper.insertSelectKey(group);
        // 모임참여리스트에 모임장을 넣어준다. - controller

        // 등록자 id user에서 가져옴
        return 1;
    }

    @Override
    public GroupVO get(Long sn) {
        // 해당 모임 모임상세를 불러온다. - o
        return groupMapper.read(sn);
    }

    @Override
    public List<GroupVO> getListWithPaging(GroupCriteria cri) {
        // 모임 리스트를 불러온다. - o
        // 각 모임 태그를 불러온다
        return groupMapper.getListWithPaging(cri);
    }

    @Override
    public boolean modify(GroupVO group) {
        // 모임 정보를 수정한다. - o
        int count1 = groupMapper.update(group);
        // 모임 상세페이지 모임정보(info)를 수정한다. - o
        int count2 = groupMapper.updateInfo(group);
        // 모임 태그를 수정한다.
        return count1 + count2 == 2;
    }

    @Override
    public boolean remove(GroupVO group) {
        // 모임을 삭제한다.
        return groupMapper.delete(group) == 1;
    }
}
