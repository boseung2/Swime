package com.swime.service;

import com.swime.domain.GroupAttendVO;
import com.swime.domain.GroupCriteria;
import com.swime.domain.GroupTagVO;
import com.swime.domain.GroupVO;
import com.swime.mapper.GroupAttendMapper;
import com.swime.mapper.GroupMapper;
import com.swime.mapper.GroupTagMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Log4j
@Service
@AllArgsConstructor
public class GroupServiceImpl implements GroupService{

    private GroupMapper groupMapper;
    private GroupAttendMapper groupAttendMapper;
    private GroupTagMapper groupTagMapper;

    @Transactional
    @Override
    public int register(GroupVO group) {
        //모임을 생성한다.

        // 1. 기본정보 등록
        groupMapper.insertSelectKey(group);

        // 2. 모임참여리스트에 모임장등록한다.
        GroupAttendVO groupAttend = new GroupAttendVO();
        groupAttend.setGrpSn(group.getSn());
        groupAttend.setUserId(group.getUserId());
        groupAttend.setGrpRole("GRRO01"); // "GRRO01" = 모임장
        groupAttend.setStatus("GRUS01"); // "GRUS01" = 정상상태
        groupAttendMapper.insertSelectKey(groupAttend);

        // 3. 태그들을 등록한다.
        group.getTags().forEach(tag -> groupTagMapper.insert(new GroupTagVO(group.getSn(), tag)));

        // ***** 등록자 id 세션에서 가져와야함 *****

        return 1;
    }

    @Override
    public GroupVO get(Long sn) {
        // 해당 모임 모임상세를 불러온다.
        GroupVO group = groupMapper.read(sn);
        // 해당 모임 태그들을 불러와서 group 객체에 넣는다.
        List<String> tags = new ArrayList<>();
        groupTagMapper.getList(sn).forEach(tag -> tags.add(tag.getName()));
        group.setTags(tags);
        return group;
    }

    @Override
    public List<GroupVO> getListWithPaging(GroupCriteria cri) {
        // 모임 리스트를 불러온다. - o
        List<GroupVO> list = groupMapper.getListWithPaging(cri);

        // 각 모임 리스트에 태그를 불러와서 추가한다.
        list.forEach(group -> {
            List<String> tags = new ArrayList<>();
            groupTagMapper.getList(group.getSn()).forEach(tag -> tags.add(tag.getName()));
            group.setTags(tags);
        });

        return list;
    }

    @Override
    public int modify(GroupVO group) {
        // 모임 정보를 수정한다.
        int count1 = groupMapper.update(group);
        // 모임 상세페이지 모임정보(info)를 수정한다.
        int count2 = groupMapper.updateInfo(group);
        // 모임 태그를 수정한다.(있던거 모두 삭제하고 다시 생성)
        groupTagMapper.delete(group.getSn());
        group.getTags().forEach(tag -> groupTagMapper.insert(new GroupTagVO(group.getSn(), tag)));
        return 1;
    }

    @Override
    public int remove(GroupVO group) {
        // 모임을 삭제한다.
        return groupMapper.delete(group);
    }

}
