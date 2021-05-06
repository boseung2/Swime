package com.swime.service;


import com.swime.domain.BoardLikeVO;
import com.swime.domain.BoardVO;
import com.swime.mapper.BoardLikeMapper;
import com.swime.mapper.BoardMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Service;

@Service
@Log4j
@AllArgsConstructor
public class BoardLikeServiceImpl implements BoardLikeService{

    private BoardLikeMapper boardLikeMapper;
    private BoardMapper boardMapper;

    @Override
    public int register(BoardLikeVO boardLike) {

        // 좋아요 누른 회원을 insert한다. 여기까지는 테스트 ok
        boardLikeMapper.insert(boardLike);

        /*
        1. 좋아요 누를 시 tbrd 테이블 좋아요 개수가 증가한다.
            나중에 Transaction으로 처리하기.
        */
        // 좋아요 테이블의 게시물 번호를 가져온다.
        Long brnSn = boardLike.getBrdSn();
        // 가져온 번호로 게시물을 읽는다.
        BoardVO board = boardMapper.read(brnSn);

        log.info("board..........."+board);
        // 게시글의 좋아요 개수를 가져와서 set한다
        board.setLikeCnt(boardLikeMapper.getBoardLikeCnt(brnSn));

        boardMapper.update(board);

        return 1;
    }

    @Override
    public int remove(long brdSn, String userId) {
        //transaction으로 바꿀 수 있을 것 같은데.
        log.info("remove: " + brdSn);
        boardLikeMapper.delete(brdSn, userId);
        //게시글 번호를 읽는다
        BoardVO board = boardMapper.read(brdSn);
        //게시글의 좋아요 개수를 가져온다
        board.setLikeCnt(boardLikeMapper.getBoardLikeCnt(brdSn));
        //board 게시판의 likeCnt 업데이트
        boardMapper.update(board);

        return 1;
    }

    @Override
    public BoardLikeVO read(BoardLikeVO boardLike) {
        return boardLikeMapper.get(boardLike);
    }




    @Override
    public int getBoardLikeCnt(long brdSn) {

        log.info("getBoardLikeCnt: " + brdSn);
        return boardLikeMapper.getBoardLikeCnt(brdSn);
    }
}
