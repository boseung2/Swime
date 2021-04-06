package com.swime.mapper;

import com.swime.domain.BoardLikeVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.swime.config.RootConfig.class})
@Log4j
public class BoardLikeMapperTests {

    @Setter(onMethod_ = @Autowired)
    private BoardLikeMapper mapper;



    @Test
    public void testInsert(){
        BoardLikeVO boardLike = new BoardLikeVO();

        boardLike.setBrdSn(1L);
        boardLike.setUserId("toytoy@naver.com");

        mapper.insert(boardLike);

        log.info(boardLike);

    }

    @Test
    public void testDelete(){

        log.info("DELETE COUNT: " +
                mapper.delete(1L,"toytoy@naver.com"));
    }
}
