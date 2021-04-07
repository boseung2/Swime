package com.swime.service;

import com.swime.domain.StudyCriteria;
import com.swime.domain.StudyListVO;
import com.swime.domain.StudyVO;
import com.swime.domain.WishStudyVO;
import com.swime.mapper.StudyListMapper;
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

    @Setter(onMethod_ = @Autowired)
    private StudyListMapper listMapper;

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

    @Override
    public int wish(WishStudyVO wish) {
        return mapper.insertWishStudy(wish);
    }

    @Override
    public int cancelWish(Long stdSn, String userId) {
        return mapper.deleteWishStudy(stdSn, userId);
    }

    // StudyList
    @Override
    public List<StudyListVO> getAttendList() {
        return listMapper.getList();
    }

    @Override
    public List<StudyListVO> getAttendList(StudyCriteria cri) {
        return listMapper.getListWithPaging(cri);
    }

    @Override
    public int registerAttend(StudyListVO list) {
        return listMapper.insert(list);
    }

    @Override
    public int modifyAttend(long stdSn, String userId, String status) {
        return listMapper.update(stdSn, userId, status);
    }


}
