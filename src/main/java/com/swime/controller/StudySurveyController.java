package com.swime.controller;

import com.swime.domain.StudySurveyVO;
import com.swime.service.StudyService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RequestMapping("/study/survey")
@RestController
@Log4j
@AllArgsConstructor
public class StudySurveyController {

    private StudyService surveyService;

    @GetMapping(value="/get/{stdSn}", produces = {MediaType.APPLICATION_JSON_VALUE})
    public ResponseEntity<List<StudySurveyVO>> get(@PathVariable("stdSn") long stdSn) {
        // 1. stdsn 필요

        return new ResponseEntity<>(surveyService.getSurveyList(stdSn), HttpStatus.OK);
    }
}
