package com.swime.mapper;

import com.swime.domain.GroupTagVO;

import java.util.List;

public interface GroupTagMapper {

    // 해시태그를 저장한다.
    int insert(GroupTagVO groupTag);

    // 해당 그룹번호에 해당하는 해시태그를 가져온다.
    List<GroupTagVO> getList(Long grpSn);

    // 해당 해시태그를 삭제한다.
    int delete(GroupTagVO groupTag);

}
