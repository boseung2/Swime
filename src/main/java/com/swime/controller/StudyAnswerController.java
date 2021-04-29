package com.swime.controller;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.swime.domain.StudyAnswerVO;
import com.swime.domain.StudyParamVO;
import com.swime.domain.StudySurveyVO;
import com.swime.service.StudyService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import javax.print.attribute.standard.Media;
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

    @GetMapping(value="/get/{userId}/{stdSn}", produces = MediaType.APPLICATION_JSON_VALUE)
    public ResponseEntity<List<StudyAnswerVO>> get(@PathVariable("stdSn") long stdSn, @PathVariable("userId") String userId) {
        log.info("===============================잘 왔니? stdSn = " + stdSn);
        log.info("===============================잘 왔니? userId = " + userId);

        StudyParamVO param = new StudyParamVO();
        param.setStdSn(stdSn);
        param.setUserId(userId);

        try {
            List<StudyAnswerVO> answers = answerService.getAnswer(param);
            return new ResponseEntity<>(answers, HttpStatus.OK);

        }catch (Exception e) {
            return new ResponseEntity<>(new ArrayList<>(), HttpStatus.INTERNAL_SERVER_ERROR);
        }

    }

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

    @PostMapping(value="/remove")
    public ResponseEntity<String> remove(@RequestBody StudyParamVO param) {
        
        // stdSn, userId 필요
        log.info("study answer remove param = " + param);

        try {
            // 해당 스터디에 해당 유저의 답변을 모두 삭제
            answerService.removeAnswer(param);
            return new ResponseEntity<>("success", HttpStatus.OK);
        }catch (Exception e) {
            return new ResponseEntity<>("fail", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
