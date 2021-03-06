package com.swime.Service;

import com.swime.domain.BoardCriteria;
import com.swime.domain.BoardPageDTO;
import com.swime.domain.BoardVO;
import com.swime.domain.GroupBoardPageDTO;
import com.swime.service.BoardService;
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
public class BoardServiceTests {

    @Setter(onMethod_ = {@Autowired})
    private BoardService service;

    @Test
    public void testExist(){

        log.info(service);
        Assert.assertNotNull(service);
    }

    @Test
    public void TestRegister(){
        BoardVO board = new BoardVO();

        //board.setSn(142L);
        board.setGrpSn(1142L);
        board.setUserId("toywar94@gmail.com");
        //board.setUserName("새로운 name");
        board.setTitle("16");
        board.setContent("16");
        //board.setLikeCnt(500);
        board.setTopFix("BOFI02");
        board.setStatus("BOST01");
        int result = service.register(board);
        log.info("result" + result);

        Assert.assertTrue(result == 2);

        log.info("생성된 게시물 번호: " + board.getSn());
    }

    @Test
    public void testGetListWithPaging(){
        BoardCriteria cri = new BoardCriteria(1,10);

        GroupBoardPageDTO boardPageDTO = service.getListWithPaging(cri,720);

        List<BoardVO> list = boardPageDTO.getList();

        list.forEach(board -> log.info(board));

        log.info(boardPageDTO.getBoardCnt());
    }

    @Test
    public void testGetList(){
        //service.getList().forEach(board -> log.info(board));
        List<BoardVO> list = service.getList(720);
        Assert.assertNotNull(list);
        list.forEach(board -> log.info(board));

    }

    @Test
    public void testGet(){

        log.info(service.get(6L));
    }

    @Test
    public void testDelete(){

        log.info("REMOVE RESULT: " + service.remove(9L));
    }

    @Test
    public void testUpdate(){

        BoardVO board = service.get(108L);
        log.info(board);

        if(board == null) return;

        board.setTitle("와 놓치고 지나갈뻔..");
        board.setContent("바뀌나요?");

        log.info("MODIFY RESULT: " + service.modify(board));
    }
}
