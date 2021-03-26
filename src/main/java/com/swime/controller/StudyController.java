package com.swime.controller;


import com.swime.domain.StudyVO;
import com.swime.mapper.StudyMapper;
import com.swime.service.StudyService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RequestMapping("/study")
@RestController
@Log4j
@AllArgsConstructor
public class StudyController {

    private StudyService service;

    @GetMapping("")
    public List<StudyVO> getList(){

        return service.getList();
    }


}
