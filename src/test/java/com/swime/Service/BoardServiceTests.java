package com.swime.Service;

import com.swime.domain.BoardCriteria;
import com.swime.domain.BoardVO;
import com.swime.service.BoardService;
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
public class BoardServiceTests {

    @Setter(onMethod_ = {@Autowired})
    private BoardService service;

    @Test
    public void testExist(){

        log.info(service);
        assertNotNull(service);
    }

    @Test
    public void TestRegister(){
        BoardVO board = new BoardVO();

        board.setGrpSn(10L);
        board.setUserId("Last 1새로운 id");
        //board.setUserName("새로운 name");
        board.setTitle("Last 새로운 제목");
        board.setContent("Last Test content2");
        //board.setLikeCnt(500);
        board.setTopFix("BOFI01");
        board.setStatus("BOST01");

        service.register(board);

        log.info("생성된 게시물 번호: " + board.getSn());
    }

    @Test
    public void testGetListWithPaging(){
        service.getListWithPaging(new BoardCriteria(1,10)).forEach(board -> log.info(board));
    }

    @Test
    public void testGet(){
        log.info(service.get(6L));
    }

    @Test
    public void testDelete(){

        log.info("REMOVE RESULT: " + service.remove(15L));
    }


    @Test
    public void testUpdate(){

        BoardVO board = service.get(4L);

        if(board == null) return;

        board.setTitle("Last Test 제목 수정 : Spring 게임 만들기");

        log.info("MODIFY RESULT: " + service.modify(board));
    }
}
