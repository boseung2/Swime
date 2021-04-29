package com.swime.controller;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.swime.domain.StudyAnswerVO;
import com.swime.domain.StudySurveyVO;
import com.swime.service.StudyService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

@RequestMapping("/study/answer")
@RestController
@Log4j
@AllArgsConstructor
public class StudyAnswerController {

    private StudyService answerService;

    @PostMapping(value="/register")
    public ResponseEntity<String> register(@RequestBody String jsonString) {

        log.info("jsonData = " + jsonString);

        // jsonData를 json 객체 배열로 바꾸기
        StudyAnswerVO[] array = new Gson().fromJson(jsonString, StudyAnswerVO[].class);
        List<StudyAnswerVO> answers = Arrays.asList(array);

        for(int i = 0; i < answers.size(); i++) {
            log.info(i+1 + "번째 답변 = " + answers.get(i));
        }

        try {
            // 답변들 등록
            answerService.registerAnswers(answers);
            return new ResponseEntity<>("success", HttpStatus.OK);

        }catch (Exception e) {
            return new ResponseEntity<>("fail", HttpStatus.INTERNAL_SERVER_ERROR);
        }

    }
}
