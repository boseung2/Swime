package com.swime.service;

import com.swime.domain.StudyCriteria;
import com.swime.domain.StudyVO;
import com.swime.mapper.StudyMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Log4j
@Service
public class StudyServiceImpl implements StudyService{

    @Setter(onMethod_ = @Autowired)
    private StudyMapper mapper;

    @Override
    public int register(StudyVO study) {

        log.info("register........." + study);

        return mapper.insertSelectKey(study);
    }

    @Override
    public StudyVO get(Long sn) {

        log.info("get................." + sn);
        return mapper.read(sn);
    }

    @Override
    public int modify(StudyVO study) {

        log.info("modify.................." + study);

        return mapper.update(study);
    }

    @Override
    public int remove(Long sn) {

        log.info("remove...................." + sn);

        return mapper.delete(sn);
    }

    @Override
    public List<StudyVO> getList() {

        log.info("getList....................");

        return mapper.getList();
    }

    @Override
    public List<StudyVO> getList(StudyCriteria cri) {

        log.info("get List with criteria : " + cri);
        
        return mapper.getListWithPaging(cri);
    }

    @Override
    public List<StudyVO> getWishList(StudyCriteria cri) {
        return mapper.getWishListWithPaging(cri);
    }
}
