package com.swime.service;

import com.swime.domain.GroupAttendVO;

import java.util.List;

public interface GroupAttendService {

    //모임에 가입한다.
    int attend(GroupAttendVO groupAttend);

    // 해당 모임 가입인원들을 보여준다.
    List<GroupAttendVO> getList(Long grpSn);

    // 모임 참여이력을 수정한다.
    int modify(GroupAttendVO groupAttend);

    // 해당 모임 참가인원을 구한다.
    //long getAttendCountByGroupSn(Long grpSn);

}
