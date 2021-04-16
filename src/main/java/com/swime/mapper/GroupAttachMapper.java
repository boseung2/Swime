package com.swime.mapper;

import com.swime.domain.GroupAttachVO;

import java.util.List;

public interface GroupAttachMapper {

    void insert (GroupAttachVO vo);

    void delete(String uuid);

    List<GroupAttachVO> findByGrpSn(Long grpSn);

    void deleteAll(Long grpSn);

    List<GroupAttachVO> getOldFiles();
}
