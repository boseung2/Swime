package com.swime.service;

import com.swime.domain.AdminBoardCriteria;
import com.swime.domain.AdminBoardPageDTO;
import com.swime.domain.BoardCriteria;
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

    @Override
    public AdminBoardPageDTO adminGetListWithPagingBySn(AdminBoardCriteria cri) {

        log.info("get adminBoard cri :" + cri);

        return new AdminBoardPageDTO(
                mapper.adminGetCountBySn(),
                mapper.adminGetListWithPagingBySn(cri));

    }
}
