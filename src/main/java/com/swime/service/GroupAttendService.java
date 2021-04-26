package com.swime.service;

import com.swime.domain.GroupAttendVO;

import java.util.List;

public interface GroupAttendService {

    //모임에 가입한다.
    int attend(GroupAttendVO groupAttend);

    // sn 으로 해당 멤버를 가져온다.
    GroupAttendVO get(Long sn);

    // grpSn, userId 로 해당 멤버를 가져온다.
    GroupAttendVO readByGrpSnUserId(GroupAttendVO groupAttend);

    // 해당 모임 가입인원들을 보여준다.
    List<GroupAttendVO> getList(Long grpSn);

    // 모임에서 탈퇴한다.
    int withdraw(GroupAttendVO groupAttend);


    // 모임장을 양도한다.
    int changeLeader(Long sn);

    // 운영진으로 승급한다.
    int changeManager(Long sn);

    // 모임원으로 강등한다.
    int cancleManager(Long sn);

    // 모임에서 영구 추방한다.
    int banPermanent(Long sn);

    // 모임에서 추방한다.
    int ban(Long sn);

    // 모임 영구 추방을 취소한다.
    int cancelBan(Long sn);


    // 해당 모임 참가인원을 구한다.
    long getAttendCountByGroupSn(Long grpSn);

}
