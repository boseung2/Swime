package com.swime.mapper;


import com.swime.domain.BoardCriteria;
import com.swime.domain.BoardVO;
import com.swime.domain.StudyParamVO;
import lombok.Setter;
import lombok.extern.log4j.Log4j;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

import static org.junit.Assert.assertNotNull;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = {com.swime.config.RootConfig.class})
@Log4j
public class BoardMapperTests {

    @Setter(onMethod_ = @Autowired)
    private BoardMapper mapper;

    @Test
    public void testGetList(){
        mapper.getList(720).forEach(board -> log.info(board));

        assertNotNull(mapper.getList(720));
    }

    @Test
    public void testInsert(){
        BoardVO board = new BoardVO();

        board.setGrpSn(224L);
        board.setUserId("toywar94@gmail.com");
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
        String stringExcess = "";

        try {
            board.setGrpSn(720L);
            board.setUserId("toywar94@gmail.com");
            //board.setUserName("selectKeyTest:minjae");
            board.setTitle("감사합니다감사합니다감사합니다감사합니다감사합니다감사합니다감사합니다감사합니다" +
                    "감사합니다감사합니다감사합니다감사합니다감사합니다감사합니다");
            board.setContent("testCodeTest2222");
            //board.setLikeCnt(500);
            board.setTopFix("BOFI01");
            board.setStatus("BOST01");

            int result = mapper.insertSelectKey(board);
            Assert.assertTrue(result == 2);
        } catch(Exception e) {
            //실패하면 뭐 넣냐..?
            stringExcess = "제목 글자 수 초과";
            log.info(stringExcess);
        }

        log.info(board);

    }

    @Test
    public void testInsertSelectKey3(){
        BoardVO board = new BoardVO();
        String stringExcess = "";
        String content = "안";
        int contentLength = 1333; //실제로 1332까지 들어감

        for(int i = 0; i < contentLength; i++){
            content += "안";
        }

        try {
            board.setGrpSn(720L);
            board.setUserId("toywar94@gmail.com");
            //board.setUserName("selectKeyTest:minjae");
            board.setTitle("감사합니다");

            board.setContent(content);
            //board.setLikeCnt(500);
            board.setTopFix("BOFI01");
            board.setStatus("BOST01");

            int result = mapper.insertSelectKey(board);
            Assert.assertTrue(result == 2);
        } catch(Exception e) {

            stringExcess = "내용 글자 수 초과";
            log.info(stringExcess);
        }

        log.info(board);

    }

    @Test
    public void testRead(){
        BoardVO board = mapper.read(142L);
        Assert.assertTrue(board.getUserId() != null);
        log.info(board);
    }
    @Test
    public void testRead2(){
        BoardVO board = mapper.read(145L);

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

//        BoardCriteria cri = new BoardCriteria();
//        cri.setPageNum(1);
//        cri.setAmount(10);
//        List<BoardVO> list = mapper.getListWithPaging();
//        list.forEach(board -> log.info(board.getSn()));
        BoardCriteria cri = new BoardCriteria();
        cri.setPageNum(1);
        cri.setAmount(10);

        List<BoardVO> list = mapper.getListWithPaging(cri, 720);
        list.forEach(board-> log.info(board.getSn()));
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
