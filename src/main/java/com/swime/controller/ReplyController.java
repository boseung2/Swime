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
    @PreAuthorize("isAuthenticated()")
    @PostMapping(value = "/new")
    public ResponseEntity<Integer> create(@RequestBody ReplyVO vo){

        log.info("ReplyVO: " + vo);

        int insertCount = service.register(vo);

        log.info("Reply InsertCount: " + insertCount);
        log.info("registerReplyCnt : "+service.getReplyCnt(vo.getBrdSn()));
        //string success
        return insertCount == 1
                ? new ResponseEntity<>(service.getReplyCnt(vo.getBrdSn()), HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }

    //댓글 삭제
    @PreAuthorize("principal.username == #reply.userId")
    @DeleteMapping(value="/{sn}/{brdSn}")
    public ResponseEntity<Integer> remove(@RequestBody ReplyVO reply, @PathVariable("sn") Long sn, @PathVariable("brdSn") Long brdSn){

        log.info("remove");
        log.info("removeUserId : " + reply.getUserId());

        //댓글 개수를 보낼 거임.
        //ReplyVO reply = new ReplyVO();

        log.info("replyCnt: " + service.getReplyCnt(brdSn));

        return service.remove(sn) == 1
                ? new ResponseEntity<>(service.getReplyCnt(brdSn), HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }
    //특정 댓글 조회
    @GetMapping(value = "/{sn}")
    public ResponseEntity<ReplyVO> get(@PathVariable("sn") Long sn){

        log.info("get: " + sn);

        return new ResponseEntity<>(service.get(sn), HttpStatus.OK);
    }
    //게시물 댓글 전체 조회
    @GetMapping(value = "/pages/{brdSn}/{page}")
    public ResponseEntity<List<ReplyVO>> getList(@PathVariable("page") int page,
                                                 @PathVariable("brdSn") Long brdSn){

        log.info("getList--------------------");
        BoardCriteria cri = new BoardCriteria(page, 10);
        log.info(cri);

        return new ResponseEntity<>(service.getList(cri, brdSn), HttpStatus.OK);
    }


    //댓글 수정 Long
    @PreAuthorize("principal.username == #vo.userId")
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
