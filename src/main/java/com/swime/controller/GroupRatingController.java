package com.swime.controller;

import com.swime.domain.GroupCriteria;
import com.swime.domain.GroupRatingPageDTO;
import com.swime.domain.GroupRatingVO;
import com.swime.service.GroupRatingService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RequestMapping("/rating/")
@RestController
@Log4j
@AllArgsConstructor
public class GroupRatingController {

    private GroupRatingService service;

    @PreAuthorize("isAuthenticated()")
    @PostMapping(value= "/new",
        consumes = "application/json",
        produces = {MediaType.TEXT_PLAIN_VALUE})
    public ResponseEntity<String> create(@RequestBody GroupRatingVO vo) {

        log.info("GroupRatingVO : " + vo);

        int insertCount = service.register(vo);

        log.info("Group Rating INSERT COUNT : " + insertCount);

        return insertCount == 1
                ? new ResponseEntity<>("success", HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @GetMapping(value = "/pages/{grpSn}/{page}",
            produces = {
                MediaType.APPLICATION_XML_VALUE,
                MediaType.APPLICATION_JSON_VALUE
            })
    public ResponseEntity<GroupRatingPageDTO> getList(
            @PathVariable("page") int page,
            @PathVariable("grpSn") Long grpSn) {

        log.info("getList.......");
        GroupCriteria cri = new GroupCriteria(page, 5);
        log.info(cri);

        return new ResponseEntity<>(service.getListPage(cri, grpSn), HttpStatus.OK);
    }

    @GetMapping(value = "/{sn}",
        produces = {MediaType.APPLICATION_XML_VALUE,
        MediaType.APPLICATION_JSON_VALUE})
    public ResponseEntity<GroupRatingVO> get(@PathVariable("sn") Long sn) {
        log.info("get: " + sn);

        return new ResponseEntity<>(service.get(sn), HttpStatus.OK);
    }

    @PreAuthorize("principal.username == #vo.userId")
    @DeleteMapping(value = "/{sn}")
    public ResponseEntity<String> remove(@RequestBody GroupRatingVO vo, @PathVariable("sn") Long sn) {

        log.info("remove: " + sn);

        log.info("userId : " + vo.getUserId());

        return service.delete(sn) == 1
                ? new ResponseEntity<>("success", HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @PreAuthorize("principal.username == #vo.userId")
    @RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH},
    value = "/{sn}",
    consumes = "application/json")
    public ResponseEntity<String> modify(
            @RequestBody GroupRatingVO vo,
            @PathVariable("sn") Long sn) {
        vo.setSn(sn);
        //vo.setGrpSn(service.get(sn).getGrpSn());
        log.info("sn: " + sn);
        log.info("modify: " + vo);

        return service.modify(vo) == 1
                ? new ResponseEntity<>("success", HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }

}
