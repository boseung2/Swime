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
}
