package com.swime.controller;

import com.swime.domain.GroupCriteria;
import com.swime.domain.GroupRatingPageDTO;
import com.swime.domain.GroupRatingVO;
import com.swime.domain.GroupWishVO;
import com.swime.service.GroupRatingService;
import com.swime.service.GroupWishService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

@RequestMapping("/groupWish/")
@RestController
@Log4j
@AllArgsConstructor
public class GroupWishController {

    private GroupWishService service;

    @PreAuthorize("isAuthenticated()")
    @PostMapping(value= "/new",
        consumes = "application/json",
        produces = {MediaType.TEXT_PLAIN_VALUE})
    public ResponseEntity<String> create(@RequestBody GroupWishVO vo) {

        log.info("GroupWishVO : " + vo);

        boolean result = service.register(vo);

        log.info("Group Rating INSERT RESULT:"  + result);

        return result
                ? new ResponseEntity<>("success", HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @GetMapping(value = "/get/{grpSn}/{userId}",
        produces = {MediaType.APPLICATION_XML_VALUE,
        MediaType.APPLICATION_JSON_VALUE})
    public ResponseEntity<GroupWishVO> get(@PathVariable("grpSn") Long grpSn, @PathVariable("userId") String userId) {
        GroupWishVO vo = new GroupWishVO();
        vo.setGrpSn(grpSn);
        vo.setUserId(userId);
        log.info("vo: " + vo);

        return new ResponseEntity<>(service.read(vo), HttpStatus.OK);
    }

    @PreAuthorize("principal.username == #userId")
    @DeleteMapping(value = "/delete/{grpSn}/{userId:.+}")
    public ResponseEntity<String> remove(@PathVariable("grpSn") Long grpSn, @PathVariable("userId") String userId) {
        GroupWishVO vo = new GroupWishVO();
        vo.setGrpSn(grpSn);
        vo.setUserId(userId);
        log.info("remove: " + vo);

        return service.delete(vo)
                ? new ResponseEntity<>("success", HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }

}
