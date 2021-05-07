package com.swime.service;

import com.swime.domain.*;
import com.swime.mapper.StudyAnswerMapper;
import com.swime.mapper.StudyListMapper;
import com.swime.mapper.WishStudyMapper;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Log4j
@Service
public class WishStudyServiceImpl implements WishStudyService{
    @Setter(onMethod_ = @Autowired)
    private WishStudyMapper WishMapper;

    // 유저가 찜한 스터디 반환
    @Override
    public List<StudyVO> getWishList(StudyCriteria cri, String userId) {
        return WishMapper.getList(cri, userId);
    }

    // 해당 유저가 해당 스터디를 찜했는지 찜 여부 반환
    @Override
    public WishStudyVO getWish(WishStudyVO wish) {
        return WishMapper.get(wish);
    }

    // 찜
    @Override
    public int registerWish(WishStudyVO wish) {
        return WishMapper.insert(wish);
    }

    // 찜 취소
    @Override
    public int removeWish(WishStudyVO wish) {
        return WishMapper.delete(wish);
    }
}
