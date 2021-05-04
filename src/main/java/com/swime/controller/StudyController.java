package com.swime.controller;


import com.swime.domain.*;
import com.swime.service.StudyService;
import com.swime.service.StudySurveyService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.PropertySource;
import org.springframework.core.env.Environment;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.print.attribute.standard.Media;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/study")
@Log4j
@AllArgsConstructor
@PropertySource("classpath:/map_key.properties")
public class StudyController {

    @Autowired
    ApplicationContext context;

    private StudyService service;
    private StudySurveyService surveyService;

    // 스터디 리스트 페이징처리
    @GetMapping(value = "/list/{grpSn}/{page}", produces = {MediaType.APPLICATION_JSON_VALUE})
    @ResponseBody
    public ResponseEntity<GroupStudyListDTO> getList(@PathVariable("grpSn") long grpSn, @PathVariable("page") int page) {

        StudyCriteria cri = new StudyCriteria(page, 3);
        GroupStudyListDTO list = service.getList(cri, grpSn);

        return new ResponseEntity<>(list, HttpStatus.OK);
    }

    // 지난 스터디 리스트 페이징처리
    @GetMapping(value = "/pastList/{grpSn}/{page}", produces = {MediaType.APPLICATION_JSON_VALUE})
    @ResponseBody
    public ResponseEntity<GroupStudyListDTO> getPastList(@PathVariable("grpSn") long grpSn, @PathVariable("page") int page) {

        StudyCriteria cri = new StudyCriteria(page, 3);
        GroupStudyListDTO list = service.getPastList(cri, grpSn);

        return new ResponseEntity<>(list, HttpStatus.OK);
    }

    // 에러페이지
    @GetMapping("/error")
    public void error() {

    }

    @GetMapping("/map")
    public void map(Model model) {
        Environment env = context.getEnvironment();
        log.info("key = " + env.getProperty("key"));

        model.addAttribute("key", env.getProperty("key"));
    }

    // 스터디 상세조회
    @GetMapping("/get")
    public String get(long sn, StudyCriteria cri, Model model) {

        // 지도 api 키
        Environment env = context.getEnvironment();
        model.addAttribute("key", env.getProperty("key"));

        // 그룹 페이징
        StudyCriteria sendCri = new StudyCriteria(cri.getPageNum(), cri.getAmount());
        model.addAttribute("cri", sendCri);

        StudyVO study = service.get(sn);
        model.addAttribute("study", study);

        if(study == null) {
            // 해당스터디가 존재하지 않으면 에러페이지로 이동
            return "redirect:/study/error";
        }

        return "study/get";
    }

    // ajax로 스터디정보 보내주기
    @GetMapping(value = "/ajaxGet", produces = {MediaType.APPLICATION_JSON_VALUE})
    public ResponseEntity<StudyVO> ajaxGet(long stdSn) {

        try {
            return new ResponseEntity<>(service.get(stdSn), HttpStatus.OK);

        }catch (Exception e) {
            return new ResponseEntity<>(new StudyVO(), HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    // 스터디 생성 페이지
    @GetMapping("/register")
    @PreAuthorize("isAuthenticated()")
    public void register(@RequestParam("grpSn") long grpSn, StudyCriteria cri, Model model) {
        model.addAttribute("grpSn", grpSn);
        model.addAttribute("cri", cri);

        // 지도 api key 전달
        Environment env = context.getEnvironment();
        log.info("key = " + env.getProperty("key"));

        model.addAttribute("key", env.getProperty("key"));
    }

    // 스터디 생성
    @PostMapping("/register")
    @PreAuthorize("isAuthenticated()")
    public String register(StudyVO study, StudyCriteria cri, StudyQuestionVO questions, RedirectAttributes rttr) {

        // startDate, endDate 시간 더해주기
        study.setStartDate(study.getStartDate() + ' ' + study.getStartTime());
        study.setEndDate(study.getEndDate() + ' ' + study.getEndTime());

        // 질문이 하나라도 있으면 설문 등록
        List<String> qList = new ArrayList<>();

        if(!"".equals(questions.getQuestion1()) || !"".equals(questions.getQuestion2()) || !"".equals(questions.getQuestion3())) {

            qList.add(questions.getQuestion1());
            qList.add(questions.getQuestion2());
            qList.add(questions.getQuestion3());

            log.info("받은 질문 리스트 = " + qList);
        }

        // 스터디 등록
        service.register(study, qList);

        // 결과 모달에 띄워주기 위한 result 전달
        rttr.addFlashAttribute("result", "register");


        // 그룹 페이징
        rttr.addAttribute("pageNum", cri.getPageNum());
        rttr.addAttribute("amount", cri.getAmount());

        // 만들어진 스터디의 상세조회 페이지로 이동한다.
        return "redirect:/study/get?sn=" + study.getSn();
    }

    // 스터디 수정
    @GetMapping("/modify")
    @PreAuthorize("principal.username == #representation")
    public void modify(long sn, StudyCriteria cri, String representation, Model model) {
        model.addAttribute("study", service.get(sn));
        model.addAttribute("cri", cri);

        List<StudySurveyVO> qList = surveyService.getSurveyList(sn);

        for(int i = 0; i < qList.size(); i++) {
            log.info((i+1) + "번째 질문 = " + qList.get(i));
            model.addAttribute("question" + (i+1), qList.get(i));
        }

        // api key
        Environment env = context.getEnvironment();
        model.addAttribute("key", env.getProperty("key"));
    }

    @PostMapping("/modify")
    @PreAuthorize("principal.username == #study.representation")
    public String modify(StudyVO study, StudyCriteria cri, StudyQuestionVO questions, RedirectAttributes rttr) {

        // startDate, endDate 시간 더해주기
        study.setStartDate(study.getStartDate() + ' ' + study.getStartTime());
        study.setEndDate(study.getEndDate() + ' ' + study.getEndTime());

        // 설문 새로 등록
        List<String> qList = new ArrayList<>();

        if(!"".equals(questions.getQuestion1()) || !"".equals(questions.getQuestion2()) || !"".equals(questions.getQuestion3())) {

            qList.add(questions.getQuestion1());
            qList.add(questions.getQuestion2());
            qList.add(questions.getQuestion3());

            log.info("받은 질문 리스트 = " + qList);
        }

        service.modify(study, qList);
        rttr.addFlashAttribute("result", "update");

        rttr.addAttribute("pageNum", cri.getPageNum());
        rttr.addAttribute("amount", cri.getAmount());

        // 수정된 스터디의 상세조회 페이지로 이동한다.
        return "redirect:/study/get?sn=" + study.getSn();
    }

    // 스터디 삭제
    @PostMapping("/remove")
    @PreAuthorize("principal.username == #representation")
    public String remove(long sn, long grpSn, StudyCriteria cri, String representation, RedirectAttributes rttr) { // 스터디번호 들어옴

        StudyParamVO param = new StudyParamVO();
        param.setStdSn(sn);

        service.remove(param);
        rttr.addFlashAttribute("result", "success");

        rttr.addAttribute("pageNum", cri.getPageNum());
        rttr.addAttribute("amount", cri.getAmount());

        return "redirect:/group/get?sn=" + grpSn;
    }

    // 스터디 멤버 관리 페이지
    @GetMapping("/members")
    @PreAuthorize("principal.username == #representation")
    public void members(long stdSn, String representation, StudyCriteria cri, Model model) {
        // 스터디장만 멤버관리페이지에 접근할 수 있음

        // 참여멤버와 대기멤버를 호출하기위해 stdSn 필요
        model.addAttribute("stdSn", stdSn);
        model.addAttribute("representation", representation);

        // 그룹 페이징
        StudyCriteria newCri = new StudyCriteria(cri.getPageNum(), cri.getAmount());
        model.addAttribute("cri", newCri);
    }
}
