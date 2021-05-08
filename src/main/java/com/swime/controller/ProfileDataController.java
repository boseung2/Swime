package com.swime.controller;

import com.swime.domain.*;
import com.swime.service.ProfileService;
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

import java.util.List;

@Controller
@RequestMapping("/profile")
@Log4j
@AllArgsConstructor
public class ProfileDataController {

    ProfileService service;

    @GetMapping(value = "/makeStudy",
            produces = {
                    MediaType.APPLICATION_XML_VALUE,
                    MediaType.APPLICATION_JSON_VALUE
            })
    @ResponseBody
    public ResponseEntity<GroupStudyListDTO> getMakeStudyList(String id, ProfileCriteria cri){
        return new ResponseEntity<>(service.makeBoth(id, cri), HttpStatus.OK);
    }

    @GetMapping(value = "/beforeStudy",
            produces = {
                    MediaType.APPLICATION_XML_VALUE,
                    MediaType.APPLICATION_JSON_VALUE
            })
    @ResponseBody
    public ResponseEntity<GroupStudyListDTO> getBeforeStudyList(String id, ProfileCriteria cri){
        return new ResponseEntity<>(service.beforeBoth(id, cri), HttpStatus.OK);
    }

    @GetMapping(value = "/afterStudy",
            produces = {
                    MediaType.APPLICATION_XML_VALUE,
                    MediaType.APPLICATION_JSON_VALUE
            })
    @ResponseBody
    public ResponseEntity<GroupStudyListDTO> getAfterStudyList(String id, ProfileCriteria cri){
        return new ResponseEntity<>(service.afterBoth(id, cri), HttpStatus.OK);
    }

    @GetMapping(value = "/wishStudy",
            produces = {
                    MediaType.APPLICATION_XML_VALUE,
                    MediaType.APPLICATION_JSON_VALUE
            })
    @ResponseBody
    public ResponseEntity<GroupStudyListDTO> getWishStudyList(String id, ProfileCriteria cri){
        return new ResponseEntity<>(service.wishBoth(id, cri), HttpStatus.OK);
    }

    @GetMapping(value = "/writeContents",
            produces = {
                    MediaType.APPLICATION_XML_VALUE,
                    MediaType.APPLICATION_JSON_VALUE
            })
    @ResponseBody
    public ResponseEntity<GroupBoardPageDTO> getWriteContentsList(String id, ProfileCriteria cri){
        return new ResponseEntity<>(service.ContentsBoth(id, cri), HttpStatus.OK);
    }

    @GetMapping(value = "/writeReply",
            produces = {
                    MediaType.APPLICATION_XML_VALUE,
                    MediaType.APPLICATION_JSON_VALUE
            })
    @ResponseBody
    public ResponseEntity<ReplyPageDTO> getWriteReplyList(String id, ProfileCriteria cri){
        return new ResponseEntity<>(service.ReplyBoth(id, cri), HttpStatus.OK);
    }









    // 스터디 리스트 페이징처리
    @GetMapping(value = "/list/{grpSn}/{page}", produces = {MediaType.APPLICATION_JSON_VALUE})
    @ResponseBody
    public ResponseEntity<GroupStudyListDTO> getList(@PathVariable("grpSn") long grpSn, @PathVariable("page") int page) {

        StudyCriteria cri = new StudyCriteria(page, 3);
//        GroupStudyListDTO list = service.getList(cri, grpSn);
        GroupStudyListDTO list = null;

        return new ResponseEntity<>(list, HttpStatus.OK);
    }
}
