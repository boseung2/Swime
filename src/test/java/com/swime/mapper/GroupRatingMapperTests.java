package com.swime.mapper;

import com.swime.domain.GroupCriteria;
import com.swime.domain.GroupRatingCriteria;
import com.swime.domain.GroupRatingVO;
import com.swime.domain.GroupVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.swime.config.RootConfig.class})
@Log4j
public class GroupRatingMapperTests {

    @Setter(onMethod_ = @Autowired)
    private GroupRatingMapper mapper;

    @Test
    public void testInsert() {
        GroupRatingVO groupRating = new GroupRatingVO();
        groupRating.setGrpSn(5L);
        groupRating.setStdSn(6L);
        groupRating.setUserId("jungbs3726@naver.com");
        groupRating.setRating(4D);
        groupRating.setReview("만족스러운 스터디였습니다.");

        mapper.insert(groupRating);
        log.info(groupRating);
    }

    @Test
    public void testInsertSelectKey() {
        GroupRatingVO groupRating = new GroupRatingVO();
        groupRating.setGrpSn(5L);
        groupRating.setStdSn(6L);
        groupRating.setUserId("jungbs3726@naver.com");
        groupRating.setRating(4D);
        groupRating.setReview("만족스러운 스터디였습니다.");

        mapper.insert(groupRating);
        log.info(groupRating);
    }

    @Test
    public void testRead() {
        GroupRatingVO groupRating = mapper.read(5L);
        log.info(groupRating);
    }

    @Test
    public void testGetList() {
        mapper.getList(1L).forEach(groupRating -> log.info(groupRating));
    }

    @Test
    public void testGetListWithPaging() {
        GroupRatingCriteria cri = new GroupRatingCriteria(2, 3);
        List<GroupRatingVO> list = mapper.getListWithPaging(1L, cri);
        list.forEach(groupRating -> log.info(groupRating));
    }

    @Test
    public void testUpdate() {
        GroupRatingVO groupRating = new GroupRatingVO();
        groupRating.setSn(1L);
        groupRating.setRating(1D);
        groupRating.setReview("수정된 리뷰");

        int count = mapper.update(groupRating);
        log.info("UPDATE COUNT : " + count);
    }

    @Test
    public void testDelete() {
        int count = mapper.delete(10L);
        log.info("DELETE COUNT : " + count);
    }



}
