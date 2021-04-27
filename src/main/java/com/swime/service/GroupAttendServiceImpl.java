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
        // 모임 참가
        // 1. 처음 참가일때 insert
        // 2. 이미 참가일때 return 0
        // 3. 참가했었는데 탈퇴상태일때 - 삭제하고 다시 insert
        // 4. 참가했었는데 영구추방상태일때 return 0



        GroupAttendVO checkVO = groupAttendMapper.readByGrpSnUserId(groupAttend);
        // 이미 list 에 있는데 참가상태일때
        if(checkVO != null) {
            String status = checkVO.getStatus();
            // 이미 참가상태
            if(status.equals("GRUS01")) {
                return 0;
            }
            // 탈퇴상태일때 delete 하고 다시 insert
           else if(status.equals("GRUS02")) {
                groupAttendMapper.delete(checkVO.getSn());
            }
            // 영구강퇴상태일때 무시한다.
           else if(status.equals("GRUS03")) {
                return 0;
            }
        }

        groupAttend.setGrpRole("GRRO03");
        groupAttend.setStatus("GRUS01");

        //모임에 가입한다.
        int result = groupAttendMapper.insertSelectKey(groupAttend);

        // 해당 모임 가입자 수를 모임정보에 업데이트한다.
        updateGroupAttendCount(groupAttend.getGrpSn());

        return result;
    }

    @Transactional
    @Override
    public GroupAttendVO get(Long sn) {
        GroupAttendVO returnVO = groupAttendMapper.read(sn);
        returnVO.setGrpRole(CodeTable.valueOf(returnVO.getGrpRole()).getValue());
        return returnVO;
    }

    @Transactional
    @Override
    public GroupAttendVO readByGrpSnUserId(GroupAttendVO groupAttend) {
        return groupAttendMapper.readByGrpSnUserId(groupAttend);
    }


    @Transactional
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
    public List<GroupAttendVO> getListWithBan(Long grpSn) {
        // ban 당한 유저까지 list 로 보여준다.
        List<GroupAttendVO> list = groupAttendMapper.getListWithBan(grpSn);
        for(int i=0; i<list.size(); i++) {
            list.get(i).setGrpRole(CodeTable.valueOf(list.get(i).getGrpRole()).getValue());
        }
        // 해당 모임 가입인원들을 보여준다.
        return list;
    }

    @Transactional
    @Override
    public int withdraw(GroupAttendVO groupAttend) {

        GroupAttendVO vo = groupAttendMapper.readByGrpSnUserId(groupAttend);

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
    public int changeLeader(Long sn) {
        // 모임장을 위임한다.
        // 1. 해당 sn 의 유저의 grpRole 을 GRRO01로 바꾼다.
        GroupAttendVO targetVO = groupAttendMapper.read(sn);

        if(targetVO == null) {
            return 0;
        }

        targetVO.setGrpRole("GRRO01");
        int result = groupAttendMapper.update(targetVO);

        // 2. 원래 모임장의 grpRole 을 GRRO02으로 바꾼다.
        GroupVO groupVO = groupMapper.read(targetVO.getGrpSn());

        GroupAttendVO vo = new GroupAttendVO();
        vo.setUserId(groupVO.getUserId());
        vo.setGrpSn(groupVO.getSn());

        GroupAttendVO originalVO = groupAttendMapper.readByGrpSnUserId(vo);
        originalVO.setGrpRole("GRRO02");
        groupAttendMapper.update(originalVO);

        // 3. tgrp 테이블도 모임장 update 해줘야한다.
        groupVO.setUserId(targetVO.getUserId());
        groupMapper.update(groupVO);

        return result;
    }

    @Transactional
    @Override
    public int changeManager(Long sn) {
        // 운영진으로 임명한다.
        // 1. 해당 sn 에 해당하는 멤버 grpRole 을 GRRO02로 바꾼다.
        GroupAttendVO vo = groupAttendMapper.read(sn);

        if(vo == null) {
            return 0;
        }

        vo.setGrpRole("GRRO02");

        return groupAttendMapper.update(vo);
    }

    @Transactional
    @Override
    public int cancelManager(Long sn) {
        // 1. 해당 sn 에 해당하는 멤버 grpRole 을 GRRO03으로 바꾼다.
        GroupAttendVO vo = groupAttendMapper.read(sn);

        if(vo == null) {
            return 0;
        }

        vo.setGrpRole("GRRO03");

        return groupAttendMapper.update(vo);
    }

    @Transactional
    @Override
    public int banPermanent(Long sn) {
        // 영구추방해버린다.

        // 1. 해당 sn 에 해당하는 멤버 status 를 GRUS03으로 바꾼다.
        GroupAttendVO vo = groupAttendMapper.read(sn);

        if(vo == null) {
            return 0;
        }

        vo.setStatus("GRUS03");

        int result = groupAttendMapper.update(vo);

        // 2. 그룹정보 업데이트해야함
        updateGroupAttendCount(vo.getGrpSn());

        return result;
    }

    @Transactional
    @Override
    public int ban(Long sn) {
        // 그냥 추방만한다.(재가입허용)

        // 1. 해당 sn에 해당하는 멤버를 아예 delete
        GroupAttendVO vo = groupAttendMapper.read(sn);

        if(vo == null) {
            return 0;
        }

        int result = groupAttendMapper.delete(sn);

        // 2. 그룹정보 업데이트해야함
        updateGroupAttendCount(vo.getGrpSn());

        return result;
    }

    @Transactional
    @Override
    public int cancelBan(Long sn) {
        // 영구추방을 해제시켜준다.

        // 1. 해당 sn 에 해당하는 멤버를 아예 delete한다.
        GroupAttendVO vo = groupAttendMapper.read(sn);

        if(vo == null) {
            return 0;
        }

        return groupAttendMapper.delete(sn);
    }

    @Transactional
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
