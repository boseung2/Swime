package com.swime.service;

import com.swime.domain.GroupCriteria;
import com.swime.domain.GroupVO;
import com.swime.domain.StudyVO;
import com.swime.mapper.IndexDataMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Log4j
@Service
public class IndexDataServiceImpl implements IndexDataService {

    @Setter(onMethod_ = @Autowired)
    IndexDataMapper mapper;

    @Override
    public List<GroupVO> popularGroupList(GroupCriteria cri) {
        return mapper.popularGroupList(cri.getPageNum(), cri.getAmount());
    }

    @Override
    public List<StudyVO> popularStudyList(GroupCriteria cri) {
        return mapper.popularStudyList(cri.getPageNum(), cri.getAmount());
    }

    @Override
    public List<GroupVO> test(GroupCriteria cri) {
        return null;
    }
}
