package com.swime.mapper;

import com.swime.domain.BoardVO;
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
public class BoardMapperTests {

    @Setter(onMethod_ = @Autowired)
    private BoardMapper mapper;

    @Test
    public void testGetList() {
        mapper.getList().forEach(board -> log.info(board));
    }

    @Test
    public void testInsert() {
        BoardVO board = new BoardVO();
        board.setTtl("mapper test 제목");
        board.setCn("mapper test 내용");
        board.setPic("mapper test 사진 url");
        board.setTop("2");
        board.setCate("c002");
        board.setGrpNum(23L);
        board.setUserNum(1L);

        mapper.insert(board);
        log.info(board);
    }

    @Test
    public void testInsertSelectKey() {
        BoardVO board = new BoardVO();
        board.setTtl("mapper test 제목");
        board.setCn("mapper test 내용");
        board.setPic("mapper test 사진 url");
        board.setTop("2");
        board.setCate("c002");
        board.setGrpNum(23L);
        board.setUserNum(1L);

        mapper.insertSelectKey(board);

        log.info(board);
    }

    @Test
    public void testRead() {
        BoardVO board = mapper.read(5L);
        log.info(board);
    }

    @Test
    public void testDelete() {
        log.info("DELETE COUNT: " + mapper.delete(3L));
    }

    @Test
    public void testUpdate() {
        BoardVO board = new BoardVO();
        board.setNum(5L);
        board.setTtl("수정된 mapper test 제목");
        board.setCn("수정된 mapper test 내용");
        board.setPic("수정된 mapper test 사진 url");
        board.setTop("1");
        board.setCate("c002");
        board.setGrpNum(23L);
        board.setUserNum(1L);

        int count = mapper.update(board);
        log.info("UPDATE COUNT: " + count);
    }


}
