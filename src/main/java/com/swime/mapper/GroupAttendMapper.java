package com.swime.mapper;

import com.swime.domain.GroupAttendVO;

import java.util.List;

public interface GroupAttendMapper {

    // 모임에 참석한다.
    int insertSelectKey(GroupAttendVO groupAttend);

    // sn 으로 해당 정보를 읽는다.
    GroupAttendVO read(Long sn);

    // 모임페이지에서 참여한 인원들을 보여준다.
    List<GroupAttendVO> getList(Long grpSn);

    // 모임 역할, 상태 변화를 수정한다.
    int update(GroupAttendVO groupAttend);

    // 해당 그룹원 수를 센다.
    long getAttendCountByGroupSn(Long grpSn);

    // 해당 회원을 삭제한다.
    int delete(Long sn);

    // grpSn, userId로 회원을 조회한다.
    GroupAttendVO readByGrpSnUserId(GroupAttendVO groupAttend);
}
