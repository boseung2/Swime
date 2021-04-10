package com.swime.service;

import com.swime.domain.BoardCriteria;
import com.swime.domain.ReplyPageDTO;
import com.swime.domain.ReplyVO;
import com.swime.mapper.ReplyMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Log4j
@AllArgsConstructor
public class ReplyServiceImpl implements ReplyService{

    private ReplyMapper mapper;

    @Override
    public int register(ReplyVO reply) {

        /* 1. 대댓글
        *   1-1 원글의 댓글인 경우 -> 댓글 번호(sn)가 댓글의 그룹번호(groupComment)가 된다.
        *   1-2 댓글의 댓글인 경우 -> 그룹번호가 댓글의 그룹번호가 된다.
        * */

        // sequence를 가져온다.
        int seq = mapper.getSequence();
        // 가져온 sequence를 sn에 set한다.
        reply.setSn(seq);

        int commentGroup = reply.getCommentGroup();
        boolean parentComment = commentGroup == 0;

        log.info("commentGroup : " + commentGroup);
        log.info("parentComment:" + parentComment);

        //부모(댓글)
        if(parentComment) {
            reply.setCommentGroup(reply.getSn());
        //자식(대댓글)--이게 맞나...생각해보기(프론트가..)
        }else{
            reply.setCommentGroup(commentGroup);
        }

        log.info("register: " + reply);
        return mapper.insert(reply);
    }

    @Override
    public ReplyVO get(Long sn) {

        log.info("get: " + sn);
        return mapper.read(sn);
    }

    @Override
    public int modify(ReplyVO reply) {

        log.info("modify" + reply);
        return mapper.update(reply);
    }

    @Override
    public int remove(Long sn) {

        log.info("remove" + sn);
        return mapper.delete(sn);
    }

    @Override
    public List<ReplyVO> getList(BoardCriteria cri, Long brd_sn) {

        log.info("get Reply List of Board");
        return mapper.getListWithPaging(cri, brd_sn);
    }

    @Override
    public ReplyPageDTO getListPage(BoardCriteria cri, Long sn) {

        return new ReplyPageDTO(
                mapper.getCountBySn(sn),
                mapper.getListWithPaging(cri,sn)
        );
    }

}
