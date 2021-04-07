package com.swime.mapper;

import com.swime.domain.GroupAttendVO;

import java.util.List;

public interface GroupAttendMapper {

    // 모임에 참석한다.
    public int insert(GroupAttendVO groupAttend);

    // 모임페이지에서 참여한 인원들을 보여준다.
    public List<GroupAttendVO> getList(Long grpSn);

    // 모임 역할, 상태 변화를 수정한다.
    public int update(GroupAttendVO groupAttend);

    // 해당 그룹원 수를 센다.
    public long getAttendCountByGroupSn(Long grpSn);

}
