package com.swime.service;

import com.swime.domain.*;

import java.util.List;

public interface WishStudyService {
    // 유저가 찜한 스터디 리스트
    public List<StudyVO> getWishList(StudyCriteria cri, String userId);

    // 유저의 스터디 찜 여부 반환
    public WishStudyVO getWish(WishStudyVO wish);

    // 스터디 찜
    public int registerWish(WishStudyVO wish);

    // 스터디 찜 취소
    public int removeWish(WishStudyVO wish);
}
