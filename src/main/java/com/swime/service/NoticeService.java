package com.swime.service;

import com.swime.domain.NoticeVO;
import com.swime.domain.StudyCriteria;
import com.swime.domain.StudyVO;
import com.swime.domain.WishStudyVO;

import java.util.List;

public interface NoticeService {
    // 알림 등록
    public void register(NoticeVO notice);

}
