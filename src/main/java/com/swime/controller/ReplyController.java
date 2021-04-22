package com.swime.controller;


import com.swime.domain.BoardCriteria;
import com.swime.domain.ReplyVO;
import com.swime.service.ReplyService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.xml.ws.Response;
import java.util.List;

@RestController
@RequestMapping("/replies")
@Log4j
@AllArgsConstructor
public class ReplyController {

    private ReplyService service;

    //생성
//    @PreAuthorize("isAuthenticated()")
    @PostMapping(value = "/new")
    public ResponseEntity<String> create(@RequestBody ReplyVO vo){

        log.info("ReplyVO: " + vo);

        int insertCount = service.register(vo);

        log.info("Reply InsertCount: " + insertCount);

        return insertCount == 1
                ? new ResponseEntity<>("success", HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }
    //댓글 조회
    @GetMapping(value = "/{sn}")
    public ResponseEntity<ReplyVO> get(@PathVariable("sn") Long sn){

        log.info("get: " + sn);

        return new ResponseEntity<>(service.get(sn), HttpStatus.OK);
    }
    //특정 게시물 댓글
    @GetMapping(value = "/pages/{brdSn}/{page}")
    public ResponseEntity<List<ReplyVO>> getList(@PathVariable("page") int page,
                                                 @PathVariable("brdSn") Long brdSn){

        log.info("getList--------------------");
        BoardCriteria cri = new BoardCriteria(page, 10);
        log.info(cri);

        return new ResponseEntity<>(service.getList(cri, brdSn), HttpStatus.OK);
    }

    //댓글 삭제
    @DeleteMapping(value="/{sn}")
    public ResponseEntity<String> remove(@PathVariable("sn") Long sn){
        log.info("remove");

        return service.remove(sn) == 1
                ? new ResponseEntity<>("success", HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }

    //댓글 수정 Long
    @RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH},
                    value = "/{sn}")
    public ResponseEntity<String> modify(@RequestBody ReplyVO vo, @PathVariable("sn") int sn){

        vo.setSn(sn);

        log.info("sn: " + sn);

        return service.modify(vo) == 1
                ? new ResponseEntity<>("success", HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }




}
