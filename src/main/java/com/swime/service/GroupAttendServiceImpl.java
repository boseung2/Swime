package com.swime.service;

import com.swime.domain.CodeTable;
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
        //if(groupAttendMapper.readByGrpSnUserId(groupAttend) != null) {
        //    return 0;
        //}

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
        returnVO.setGrpRole(CodeTable.valueOf(returnVO.getGrpRole()).getValue());
        return returnVO;
    }

    @Override
    public List<GroupAttendVO> getList(Long grpSn) {
        List<GroupAttendVO> list = groupAttendMapper.getList(grpSn);
        for(int i=0; i<list.size(); i++) {
            list.get(i).setGrpRole(CodeTable.valueOf(list.get(i).getGrpRole()).getValue());
        }
        // 해당 모임 가입인원들을 보여준다.
        return list;
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

    @Override
    public int ban(Long sn) {
        return 0;
    }

    @Override
    public int cancelBan(Long sn) {
        return 0;
    }

    @Override
    public int changeManager(Long sn) {
        return 0;
    }

    @Override
    public int changeMember(Long sn) {
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
