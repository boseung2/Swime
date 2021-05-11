package com.swime.service;

import com.swime.domain.*;
import com.swime.mapper.AdminBoardMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Service;

@Log4j
@Service
@AllArgsConstructor
public class AdminBoardServiceImpl implements AdminBoardService{

    private AdminBoardMapper mapper;


    //------------------------------관리자 게시판
//    @Override
//    public List<BoardVO> adminGetListWithPagingBySn(BoardCriteria cri) {
//
//        log.info("get adminBoard cri" + cri);
//
//        return mapper.adminGetListWithPagingBySn(cri);
//    }
    //관리자 게시판
    @Override
    public AdminBoardPageDTO adminGetListWithPagingBySn(AdminBoardCriteria cri) {

        log.info("get adminBoard cri :" + cri);

        return new AdminBoardPageDTO(
                mapper.adminGetCountBySn(),
                mapper.adminGetListWithPagingBySn(cri));

    }

    //관리자 댓글
    @Override
    public ReplyPageDTO adminReplyGetListWithPagingBySn(AdminReplyCriteria cri) {
        log.info("get adminReply Cri : " + cri);
        return new ReplyPageDTO(
                mapper.getCountBySn(),
                mapper.adminReplyGetListWithPagingBySn(cri));
    }




}