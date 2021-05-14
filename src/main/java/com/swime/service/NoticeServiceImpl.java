package com.swime.service;

import com.swime.domain.NoticeVO;
import com.swime.domain.StudyCriteria;
import com.swime.domain.StudyVO;
import com.swime.domain.WishStudyVO;
import com.swime.mapper.NoticeMapper;
import com.swime.mapper.WishStudyMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Log4j
@Service
public class NoticeServiceImpl implements NoticeService{
    @Setter(onMethod_ = @Autowired)
    private NoticeMapper mapper;


    @Override
    public void register(NoticeVO notice) {
        mapper.insert(notice);
    }

    @Override
    public List<NoticeVO> getList(String userId) {
        return mapper.getList(userId);
    }

    @Override
    public void modify(long sn) {
        mapper.update(sn);
    }
}
