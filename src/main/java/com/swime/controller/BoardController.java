package com.swime.controller;

import com.swime.domain.BoardVO;
import com.swime.domain.GroupVO;
import com.swime.service.BoardService;
import com.swime.service.GroupService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/board")
@Log4j
@AllArgsConstructor
public class BoardController {

    private BoardService service;

    @PostMapping(value = "/new")
    public ResponseEntity<String> create(@RequestBody BoardVO vo) {

        log.info("BoardVO: " + vo);

        int insertCount = service.register(vo);

        log.info("Board INSERT COUNT: " + insertCount);

        return insertCount == 1
                ? new ResponseEntity<>("success", HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @GetMapping(value = "/list")
    public ResponseEntity<List<BoardVO>> getList() {
        return new ResponseEntity<>(service.getList(), HttpStatus.OK);
    }


    @GetMapping(value = "/{sn}")
    public ResponseEntity<BoardVO> get(
            @PathVariable("sn") Long sn) {
        return new ResponseEntity<>(service.get(sn), HttpStatus.OK);
    }

    @RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH},
            value = "/{sn}")
    public ResponseEntity<String> modify(
            @RequestBody BoardVO vo,
            @PathVariable("sn") Long sn) {

        vo.setSn(sn);

        log.info("sn: " + sn);
        log.info("modify: " + vo);

        return service.modify(vo)
                ? new ResponseEntity<>("success", HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }

}
