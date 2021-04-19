package com.swime.service;

import com.swime.domain.GroupAttendVO;
import com.swime.domain.GroupVO;
import com.swime.mapper.GroupAttendMapper;
import com.swime.mapper.GroupMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Log4j
@Service
@AllArgsConstructor
public class GroupAttendServiceImpl implements GroupAttendService{

    private GroupMapper groupMapper;
    private GroupAttendMapper groupAttendMapper;

    @Transactional
    @Override
    public int attend(GroupAttendVO groupAttend) {
        groupAttend.setGrpRole("GRRO03");
        groupAttend.setStatus("GRUS01");

        //모임에 가입한다.
        int result = groupAttendMapper.insertSelectKey(groupAttend);

        // 해당 모임 가입자 수를 모임정보에 업데이트한다.
        updateGroupAttendCount(groupAttend.getGrpSn());

        return result;
    }

    @Override
    public GroupAttendVO get(Long sn) {
        GroupAttendVO returnVO = groupAttendMapper.read(sn);
        return returnVO;
    }

    @Override
    public List<GroupAttendVO> getList(Long grpSn) {
        // 해당 모임 가입인원들을 보여준다.
        return groupAttendMapper.getList(grpSn);
    }

    @Transactional
    @Override
    public int withdraw(Long sn) {

        GroupAttendVO vo = groupAttendMapper.read(sn);

        if(vo == null) {
            return 0;
        }

        vo.setStatus("GRUS02"); // GRUS02 탈퇴

        log.info(">>>>>>>>>>>>>groupAttend" + vo);

        int result = groupAttendMapper.update(vo);
        // 해당 모임 가입자 수를 모임정보에 업데이트한다.
        updateGroupAttendCount(vo.getGrpSn());
        return result;
    }

    @Transactional
    @Override
    public int ban(GroupAttendVO groupAttend) {
        groupAttend.setStatus("GRUS03"); // GRUS03 영구추방
        int result = groupAttendMapper.update(groupAttend);
        // 해당 모임 가입자 수를 모임정보에 업데이트한다.
        updateGroupAttendCount(groupAttend.getGrpSn());
        return result;
    }

    @Override
    public int cancelBan(GroupAttendVO groupAttend) {
        return 0;
    }

//    @Transactional
//    @Override
//    public int cancelBan(GroupAttendVO groupAttend) {
//        int result = withdraw(groupAttend);
//        // 해당 모임 가입자 수를 모임정보에 업데이트한다.
//        updateGroupAttendCount(groupAttend.getGrpSn());
//        return result; // GRUS02 탈퇴상태로 바꿈
//    }

    @Override
    public int changeRole(GroupAttendVO groupAttend) {
        groupAttend.setGrpRole("GRRO02"); // GRRO02 운영진
        return groupAttendMapper.update(groupAttend);
    }

    @Override
    public long getAttendCountByGroupSn(Long grpSn) {
        return groupAttendMapper.getAttendCountByGroupSn(grpSn);
    }

    // group 테이블의 groupAttendCount 를 최신화한다.
    private void updateGroupAttendCount(Long grpSn) {
        GroupVO group = groupMapper.read(grpSn);
        group.setAttendCount(groupAttendMapper.getAttendCountByGroupSn(grpSn));
        groupMapper.update(group);
    }

}
