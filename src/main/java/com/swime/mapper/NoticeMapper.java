package com.swime.mapper;

import com.swime.domain.NoticeVO;
import com.swime.domain.StudyCriteria;
import com.swime.domain.StudyVO;
import com.swime.domain.WishStudyVO;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface NoticeMapper {
    // 알림 등록
    public int insert(NoticeVO notice);

    // 알림 리스트 가져오기
    public List<NoticeVO> getList(String userId);

    public int update(long sn);
}
