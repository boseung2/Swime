package com.swime.controller;

import com.swime.domain.CodeTable;
import com.swime.domain.GroupCriteria;
import com.swime.domain.GroupVO;
import com.swime.mapper.IndexDataMapper;
import com.swime.service.IndexDataService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/")
@Log4j
@AllArgsConstructor
public class IndexDataController {

    IndexDataService service;
    IndexDataMapper mapper;


    @GetMapping(value = "/getPopularGroupList",
            produces = {
                    MediaType.APPLICATION_XML_VALUE,
                    MediaType.APPLICATION_JSON_VALUE
            })
    public ResponseEntity<List<GroupVO>> getPopularGroupList(GroupCriteria cri){
        List<GroupVO> list = service.popularGroupList(cri);
        list.forEach(group -> {
            group.setSigungu(CodeTable.valueOf(group.getSigungu()).getValue());
        });
        test();
        return new ResponseEntity<>(list, HttpStatus.OK);
    }

    public ResponseEntity test(){
        mapper.timeTest();
        mapper.setSessionTime();
        mapper.timeTest();
        return new ResponseEntity(HttpStatus.OK);
    }
}
