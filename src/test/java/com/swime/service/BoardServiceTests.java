package com.swime.service;

import com.swime.domain.BoardVO;
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
    public void testExist() {
        log.info(service);
        assertNotNull(service);
    }

    @Test
    public void testRegister() {
        BoardVO board = new BoardVO();
        board.setTtl("새로 작성하는 글");
        board.setCn("새로 작성하는 내용");
        board.setPic("새로운 사진 url");
        board.setTop("1");
        board.setCate("c001");
        board.setGrpNum(2L);
        board.setUserNum(1L);

        service.register(board);

        log.info("생성된 게시물의 번호: " + board.getNum());
    }

    @Test
    public void testGetList() {
        service.getList().forEach(board -> log.info(board));
    }

    @Test
    public void testGet() {
        log.info(service.get(2L));
    }

    @Test
    public void testDelete() {
        log.info("REMOVE RESULT: " + service.remove(11L));
    }

    @Test
    public void testUpdate() {
        BoardVO board = service.get(14L);
        if(board == null) {
            return;
        }

        board.setTtl("제목 수정합니다.");
        log.info("MODIFY RESULT: " + service.modify(board));

    }
}
