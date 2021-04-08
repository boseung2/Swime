package com.swime.controller;

import com.swime.domain.StudyCriteria;
import com.swime.domain.StudyVO;
import com.swime.service.StudyService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import oracle.ucp.proxy.annotation.Post;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.print.attribute.standard.Media;
import javax.xml.ws.Response;
import java.util.List;

@RestController
@RequestMapping("/study")
@Log4j
@AllArgsConstructor
public class StudyController {

    private StudyService service;

    @GetMapping(value="/list", produces= MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<List<StudyVO>> getList() {

        log.info("get List ....................");
        return new ResponseEntity<>(service.getList(), HttpStatus.OK);
    }

    @GetMapping(value="/list/{grpSn}/{page}", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<List<StudyVO>> getListwithPaging(
            @PathVariable("grpSn") long grpSn,
            @PathVariable("page") long page) {

        log.info("get list with paging .........................");
        StudyCriteria cri = new StudyCriteria(page, 3);
        log.info(cri);

        return new ResponseEntity<>(service.getList(cri), HttpStatus.OK);
    }

    @PostMapping(value="/new", consumes = "application/json",
    produces = {MediaType.TEXT_PLAIN_VALUE})
    public ResponseEntity<String> register(@RequestBody StudyVO study) {
        log.info("insert.................." + study);

        int insertCount = service.register(study);
        return insertCount == 1
                ? new ResponseEntity<>("success", HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @GetMapping(value="/{sn}", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<StudyVO> get(@PathVariable("sn") long sn) {

        log.info("get ....................." + sn);
        return new ResponseEntity<>(service.get(sn), HttpStatus.OK);
    }

    @RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH},
    value="/{sn}", consumes="application/json",
    produces = {MediaType.TEXT_PLAIN_VALUE})
    public ResponseEntity<String> modify(@RequestBody StudyVO study,
                                         @PathVariable("sn") long sn) {
        study.setSn(sn);

        log.info("sn: " + sn);
        log.info("modify: " + study);

        return service.modify(study) == 1
                ? new ResponseEntity<>("success", HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @RequestMapping(method = {RequestMethod.DELETE},
            value="/{sn}",
            produces = {MediaType.TEXT_PLAIN_VALUE})
    public ResponseEntity<String> remove(@PathVariable("sn") long sn) {

        log.info("remove................." + sn);

        return service.remove(sn) == 1
                ? new ResponseEntity<>("success", HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @GetMapping(value="/wishList/{userId}/{page}", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<List<StudyVO>> getWishListwithPaging(
            @PathVariable("userId") String userId,
            @PathVariable("page") long page) {

        log.info("get list with paging .........................");
        StudyCriteria cri = new StudyCriteria(page, 3, userId);
        log.info(cri);

        return new ResponseEntity<>(service.getList(cri), HttpStatus.OK);
    }
}
