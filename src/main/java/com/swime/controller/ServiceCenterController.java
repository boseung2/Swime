package com.swime.controller;

import com.swime.domain.BoardCriteria;
import com.swime.domain.BoardVO;
import com.swime.domain.GroupBoardPageDTO;
import com.swime.service.BoardService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/serviceCenter/*")
@Log4j
@AllArgsConstructor
public class ServiceCenterController {

    private BoardService service;

    @GetMapping("/list")
    public void list(){

    }
    @GetMapping("/adminTest")
        public void adminTest(){
        BoardVO board = new BoardVO();


    }
    @GetMapping(value = "/admin/{brdSn}/{page}", produces = {MediaType.APPLICATION_JSON_VALUE})
    @ResponseBody
    public ResponseEntity<GroupBoardPageDTO> getList(@PathVariable("brdSn") long brdSn, @PathVariable("page") int page) {

        log.info(">>>>>>>>>>>>>  " + brdSn);
        //게시판 페이지당 3개의 게시글을 보여준다.
        BoardCriteria cri = new BoardCriteria(page, 3);
        log.info("cri>>>>>>>>>>"+cri);

        GroupBoardPageDTO list = service.getListWithPaging(cri, brdSn);

        return new ResponseEntity<>(list, HttpStatus.OK);
    }

}
