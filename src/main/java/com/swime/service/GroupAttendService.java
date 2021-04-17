package com.swime.service;

import com.swime.domain.GroupAttendVO;

import java.util.List;

public interface GroupAttendService {

    //모임에 가입한다.
    int attend(GroupAttendVO groupAttend);

    GroupAttendVO get(Long sn);

    // 해당 모임 가입인원들을 보여준다.
    List<GroupAttendVO> getList(Long grpSn);

    // 모임에서 탈퇴한다.
    int withdraw(GroupAttendVO groupAttend);

    // 모임에서 영구 추방한다.
    int ban(GroupAttendVO groupAttend);

    // 모임 영구 추방을 취소한다.
    int cancelBan(GroupAttendVO groupAttend);

    // 모임 역할을 수정한다.
    int changeRole(GroupAttendVO groupAttend);

    // 해당 모임 참가인원을 구한다.
    long getAttendCountByGroupSn(Long grpSn);

}
