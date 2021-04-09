package com.swime.controller;


import com.swime.domain.ReplyVO;
import com.swime.service.ReplyService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/reply")
@Log4j
@AllArgsConstructor
public class ReplyController {

    private ReplyService service;

    @PostMapping(value = "/new")
    public ResponseEntity<String> create(@RequestBody ReplyVO vo){

        log.info("ReplyVO: " + vo);

        int insertCount = service.register(vo);

        log.info("Reply InsertCount: " + insertCount);

        return insertCount == 1
                ? new ResponseEntity<>("success", HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @GetMapping(value = "/{sn}")
    public ResponseEntity<ReplyVO> get(@PathVariable("sn") Long sn){

        log.info("get: " + sn);

        return new ResponseEntity<>(service.get(sn), HttpStatus.OK);
    }


}
