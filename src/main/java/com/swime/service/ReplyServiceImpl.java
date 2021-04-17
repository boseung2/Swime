package com.swime.service;

import com.swime.domain.BoardCriteria;
import com.swime.domain.BoardVO;
import com.swime.domain.ReplyPageDTO;
import com.swime.domain.ReplyVO;
import com.swime.mapper.BoardMapper;
import com.swime.mapper.ReplyMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Log4j
@AllArgsConstructor
public class ReplyServiceImpl implements ReplyService{

    private BoardMapper boardMapper;
    private ReplyMapper replyMapper;

    @Transactional
    @Override
    public int register(ReplyVO reply) {

        /* 1. 대댓글
        *   1-1 원글의 댓글인 경우 -> 댓글 번호(sn)가 댓글의 그룹번호(groupComment)가 된다.
        *   1-2 댓글의 댓글인 경우 -> 그룹번호가 댓글의 그룹번호가 된다.
        * */

        int seq = replyMapper.getSequence(); // sequence를 가져온다.
        reply.setSn(seq); // 가져온 sequence를 sn에 set한다.

        int commentGroup = reply.getCommentGroup();
        boolean parentComment = commentGroup == 0;

        //부모(댓글)
        if(parentComment) {
            reply.setCommentGroup(reply.getSn());
        //자식(대댓글)--이게 맞나...생각해보기(프론트가..)
        //부모의 com_grp읽어서 자식 com_grp로 쏴주면...
        }else{
            reply.setCommentGroup(commentGroup);
        }

        log.info("commentGroup : " + commentGroup);
        log.info("parentComment:" + parentComment);
        log.info("register: " + reply);

        //댓글 개수 업데이트
        boardMapper.updateReplyCnt(reply.getBrdSn(), 1);

        replyMapper.insert(reply);



        /*
        2.댓글이 추가 될 때 게시판의 댓글 수가 증가한다.
                -Transaction으로 처리해보기-
        */

        //댓글 테이블에서 게시물 번호를 가져온다.
//        Long brdSn = reply.getBrdSn();
//        //가져온 번호로 게시물을 읽는다. - O
//        log.info("brdSn>>>>>>>>>>>>"+brdSn);
//
//        BoardVO board = boardMapper.read(brdSn);
//        //댓글 개수를 넣어준다. ->//여기가 문제인데...board가 null이 나오네
//        log.info("board>>>>>>>>>>>>"+board);
//        board.setReplyCnt(replyMapper.getReplyCnt(brdSn));
//
//        boardMapper.update(board);

        return 1;
    }

    @Override
    public ReplyVO get(Long sn) {

        log.info("get: " + sn);
        return replyMapper.read(sn);
    }

    @Override
    public int modify(ReplyVO reply) {

        log.info("modify" + reply);
        return replyMapper.update(reply);
    }

    @Transactional
    @Override
    public int remove(Long sn) {

        log.info("remove........" + sn);

        //댓글 번호를 읽어온다.
        ReplyVO reply = replyMapper.read(sn);
        //댓글 개수 감소
        boardMapper.updateReplyCnt(reply.getBrdSn(), -1);

        return replyMapper.delete(sn);
    }


    @Override
    public int getReplyCnt(Long brdSn) {

        log.info("getReplyCnt.........."+brdSn);
        return replyMapper.getCountByBrdSn(brdSn);
    }
    //*주석하기*
    @Override
    public List<ReplyVO> getList(BoardCriteria cri, Long brdSn) {

        log.info("get Reply List of Board");
        return replyMapper.getListWithPaging(cri, brdSn);
    }

    @Override
    public ReplyPageDTO getListPage(BoardCriteria cri, Long brdSn) {

        return new ReplyPageDTO(
                replyMapper.getCountByBrdSn(brdSn),
                replyMapper.getListWithPaging(cri,brdSn)
        );
    }

}
