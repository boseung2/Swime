package com.swime.service;

import com.swime.domain.GroupTagVO;

import java.util.List;

public interface GroupTagService {

    // 해시태그를 모두 등록한다.
    int register(List<GroupTagVO> list);

    // 해당 그룹번호에 해당하는 해시태그를 모두 가져온다.
    List<GroupTagVO> getList(Long grpSn);

    // 해당 해시태그를 모두 삭제한다.
    int delete(Long grpSn);

}
