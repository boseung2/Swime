package com.swime.mapper;

import com.swime.domain.GroupCriteria;
import com.swime.domain.GroupVO;

import java.util.List;

public interface GroupMapper {

    // 모임을 생성한다. - o
    public int insertSelectKey(GroupVO group);

    // 해당 모임상세를 불러온다.- o
    public GroupVO read(Long sn);

    // 모임 목록을 불러온다 - o
    public List<GroupVO> getListWithPaging(GroupCriteria cri);

    // 모임정보를 업테이트한다.(모임 info 제외) - o
    public int update(GroupVO group);

    // 모임 info를 업테이트한다. - o
    public int updateInfo(GroupVO group);

    // 모임을 삭제한다. - o
    public int delete(GroupVO group);

    // 모든 모임개수를 구한다. - o
    public int getTotalCount(GroupCriteria cri);
}
