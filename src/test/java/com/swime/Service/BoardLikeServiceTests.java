package com.swime.Service;

import com.swime.domain.BoardLikeVO;
import com.swime.service.BoardLikeService;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import static org.junit.Assert.assertNotNull;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.swime.config.RootConfig.class})
@Log4j

public class BoardLikeServiceTests {

    @Setter(onMethod_ = {@Autowired})
    private BoardLikeService service;

    @Test
    public void testExist(){

        log.info(service);
        assertNotNull(service);
    }

    @Test
    public void testRegister(){

        BoardLikeVO boardLike = new BoardLikeVO();

        //boardLike.setLikeSn(44L);
        boardLike.setBrdSn(25L);
        boardLike.setUserId("boseung@naver.com");

        service.register(boardLike);

        log.info(boardLike);


    }


    @Test
    public void testRemove(){

        log.info("REMOVE RESULT: " + service.remove(44L,"toy11@naver.com"));

    }

    @Test
    public void testGetBoardLikeCnt(){
        log.info("getBoardCounting: " + service.getBoardLikeCnt(1L));
    }
}
