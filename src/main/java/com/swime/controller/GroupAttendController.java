package com.swime.controller;

import com.swime.domain.GroupAttendVO;
import com.swime.service.GroupAttendService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequestMapping("/groupAttend/")
@RestController
@Log4j
@AllArgsConstructor
public class GroupAttendController {

    private GroupAttendService service;

    @PostMapping(value= "/new",
            consumes = "application/json",
            produces = {MediaType.TEXT_PLAIN_VALUE})
    public ResponseEntity<String> create(@RequestBody GroupAttendVO vo) {

        int insertCount = service.attend(vo);

        log.info("Group Attend INSERT COUNT : " + insertCount);

        return insertCount == 1
                ? new ResponseEntity<>("success", HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @GetMapping(value = "/page/{grpSn}",
            produces = {
                    MediaType.APPLICATION_XML_VALUE,
                    MediaType.APPLICATION_JSON_VALUE
            })
    public ResponseEntity<List<GroupAttendVO>> getList(
            @PathVariable("grpSn") Long grpSn) {

        log.info("getList.......");

        return new ResponseEntity<>(service.getList(grpSn), HttpStatus.OK);
    }

    @GetMapping(value = "/{sn}",
            produces = {MediaType.APPLICATION_XML_VALUE,
                    MediaType.APPLICATION_JSON_VALUE})
    public ResponseEntity<GroupAttendVO> get(@PathVariable("sn") Long sn) {
        log.info("get: " + sn);

        return new ResponseEntity<>(service.get(sn), HttpStatus.OK);
    }

    @RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH},
            value = "/withdraw/{sn}",
            consumes = "application/json",
            produces = {MediaType.TEXT_PLAIN_VALUE})
    public ResponseEntity<String> withdraw(
            @PathVariable("sn") Long sn) {

        return service.withdraw(sn) == 1
                ? new ResponseEntity<>("success", HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }


}
