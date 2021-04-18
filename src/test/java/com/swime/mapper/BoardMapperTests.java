package com.swime.mapper;


import com.swime.domain.BoardCriteria;
import com.swime.domain.BoardVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.swime.config.RootConfig.class})
@Log4j
public class BoardMapperTests {

    @Setter(onMethod_ = @Autowired)
    private BoardMapper mapper;

    @Test
    public void testGetList(){
        mapper.getList().forEach(board -> log.info(board));
    }

    @Test
    public void testInsert(){
        BoardVO board = new BoardVO();

        board.setGrpSn(224L);
        board.setUserId("boseung@naver.com");
        //board.setUserName("테스트:이민재");
        board.setTitle("Last Test : 자바 초보만 오세용~~!!");
        board.setContent("testtesttest");
        //board.setLikeCnt(500);
        board.setTopFix("BOFI01");
        board.setStatus("BOST01");

        int result = mapper.insert(board);
        log.info(result);
        Assert.assertTrue(result == 2);

        log.info(board);
    }

    @Test
    public void testInsertSelectKey(){
        BoardVO board = new BoardVO();

        board.setGrpSn(6L);
        board.setUserId("qwer9827@naver.com");
        //board.setUserName("selectKeyTest:minjae");
        board.setTitle("댓글 개수 TEST");
        board.setContent("IP가 뭔가요?");
        //board.setLikeCnt(500);
        board.setTopFix("BOFI01");
        board.setStatus("BOST01");

        mapper.insertSelectKey(board);

        log.info(board);

    }

    @Test
    public void testRead(){
        BoardVO board = mapper.read(15L);
        log.info(board);
    }
    @Test
    public void testRead2(){
        BoardVO board = mapper.read(41L);
        log.info(board);
    }
    @Test
    public void testRead3(){
        BoardVO board = mapper.read(46L);
        log.info(board);
    }

    @Test
    public void testDelete(){

        log.info("DELETE COUNT : " + mapper.delete(10L));

    }

    @Test
    public void testUpdate(){
        BoardVO board = new BoardVO();
        board.setSn(10L);
        //board.setUserId("수정된 이름");
        //board.setUserName("수정된 이메일");
        //board.setContent("testUpdate ");
        board.setTitle("수정된 제목");
        //board.setLikeCnt(20);
        //board.setTopFix("BOFI02");
        //board.setStatus("BOST01");

        int count = mapper.update(board);
        log.info("UPDATE COUNT: " + count);

    }

    @Test
    public void testPaging(){

        BoardCriteria cri = new BoardCriteria();
        cri.setPageNum(1);
        cri.setAmount(10);
        List<BoardVO> list = mapper.getListWithPaging(cri);
        list.forEach(board -> log.info(board.getSn()));
    }

    @Test
    public void testUpdateContent(){
        BoardVO board = new BoardVO();

        board.setSn(50L);
        board.setContent("contentUpdateTest: spring");

        int count = mapper.updateContent(board);

        log.info(count);
    }

//    @Test
//    public void testGetBoardCnt(){
//
//        int boardCnt = mapper.getBoardCnt(3L);
//
//        log.info("boardCnt" + boardCnt);
//    }
}
