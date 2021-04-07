package com.swime.service;

import com.swime.domain.GroupAttendVO;
import com.swime.domain.GroupVO;
import com.swime.mapper.GroupAttendMapper;
import com.swime.mapper.GroupMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Log4j
@Service
@AllArgsConstructor
public class GroupAttendServiceImpl implements GroupAttendService{

    private GroupAttendMapper groupAttendMapper;
    private GroupMapper groupMapper;

    @Override
    public int attend(GroupAttendVO groupAttend) {
        //모임에 가입한다.
        groupAttendMapper.insert(groupAttend);
        // 해당 모임 가입자 수를 모임정보에 업데이트한다.
        Long grpSn = groupAttend.getGrpSn();
        GroupVO group = groupMapper.read(grpSn);
        group.setAttendCount(groupAttendMapper.getAttendCountByGroupSn(grpSn));
        groupMapper.update(group);
        return 1;
    }

    @Override
    public List<GroupAttendVO> getList(Long grpSn) {
        // 해당 모임 가입인원들을 보여준다.
        return groupAttendMapper.getList(grpSn);
    }

    @Override
    public int modify (GroupAttendVO groupAttend) {
        return groupAttendMapper.update(groupAttend);
    }

//    @Override
//    public long getAttendCountByGroupSn(Long grpSn) {
//        return groupAttendMapper.getAttendCountByGroupSn(grpSn);
//    }

}
