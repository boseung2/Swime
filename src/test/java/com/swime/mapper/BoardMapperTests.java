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
    public void testGetList(){
        mapper.getList().forEach(board -> log.info(board));
    }

    @Test
    public void testInsert(){
        BoardVO board = new BoardVO();

        board.setGrpSn(8L);
        board.setUserId("테스트2:minjae@naver.com");
        board.setUserName("테스트:이민재");
        board.setTitle("테스트 : 자바 초보만 오세용~~!!");
        //board.setLikeCnt(500);
        board.setTopFix("BOFI01");
        board.setStatus("BOST01");

        mapper.insert(board);

        log.info(board);
    }

    @Test
    public void testInsertSelectKey(){
        BoardVO board = new BoardVO();

        board.setGrpSn(3L);
        board.setUserId("selectKeyTest : minjae@naver.com");
        board.setUserName("selectKeyTest:minjae");
        board.setTitle("selectKeyTest : 자바 초보만 오세용~~!!");
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
    public void testDelete(){

        log.info("DELETE COUNT : " + mapper.delete(1L));

    }

    @Test
    public void testUpdate(){
        BoardVO board = new BoardVO();
        board.setSn(7L);
        board.setUserId("수정된 이름");
        board.setUserName("수정된 이메일");
        board.setTitle("수정된 제목");
        board.setLikeCnt(20);
        board.setTopFix("BOFI02");
        board.setStatus("BOST02");

        int count = mapper.update(board);
        log.info("UPDATE COUNT: " + count);

    }
}
