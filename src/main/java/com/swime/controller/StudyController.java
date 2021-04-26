package com.swime.controller;


import com.swime.domain.*;
import com.swime.service.StudyService;
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

@Controller
@RequestMapping("/study")
@Log4j
@AllArgsConstructor
@PropertySource("classpath:/map_key.properties")
public class StudyController {

    @Autowired
    ApplicationContext context;

    private StudyService service;

    // 스터디 리스트 페이징처리
    @GetMapping(value = "/list/{grpSn}/{page}", produces = {MediaType.APPLICATION_JSON_VALUE})
    @ResponseBody
    public ResponseEntity<GroupStudyListDTO> getList(@PathVariable("grpSn") long grpSn, @PathVariable("page") int page) {

        StudyCriteria cri = new StudyCriteria(page, 3);
        GroupStudyListDTO list = service.getList(cri, grpSn);

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
    public String get(long sn, StudyCriteria cri, String userId, Model model) {

        if(userId == "") {

        }
        log.info("스터디 상세조회 cri = " + cri);
        log.info("스터디 조회자 = " + userId);

        StudyCriteria sendCri = new StudyCriteria(cri.getPageNum(), cri.getAmount());
        model.addAttribute("cri", sendCri);

        log.info("sendCri = " + sendCri);

        try {
            StudyVO study = service.get(sn);
            model.addAttribute("study", study);

            if(study == null) {
                // 해당스터디가 존재하지 않으면 에러페이지로 이동
                return "redirect:/study/error";
            }
            model.addAttribute("members", service.getAttendantList(sn));

        }catch (Exception e) {
            // 스터디 정보를 가져오는데 실패하면 에러페이지로 이동
            return "redirect:/study/error";
        }

        // 로그인한 경우
        StudyParamVO studyParam = new StudyParamVO();
        studyParam.setUserId(userId);
        studyParam.setStdSn(sn);

//        model.addAttribute("studyParam", studyParam);

//        // 찜 여부 가져오기 : null이면 찜 아니면 찜취소
//        log.info("=============================찜 여부 : " + service.getWish(studyParam));
//        model.addAttribute("wish", service.getWish(studyParam));

        // 참석 여부 가져오기
        model.addAttribute("attend", service.getAttendant(studyParam));

        return "study/get";
    }

    // 스터디 생성 페이지
    @GetMapping("/register")
    @PreAuthorize("isAuthenticated()")
    public void register(@RequestParam("grpSn") long grpSn, StudyCriteria cri, Model model) {
        model.addAttribute("grpSn", grpSn);
        model.addAttribute("cri", cri);

        Environment env = context.getEnvironment();
        log.info("key = " + env.getProperty("key"));

        model.addAttribute("key", env.getProperty("key"));
    }

    // 스터디 생성
    @PostMapping("/register")
    @PreAuthorize("isAuthenticated()")
    public String register(StudyVO study, String userId, StudyCriteria cri, RedirectAttributes rttr) {

        log.info("스터디 생성 cri = " + cri);

        log.info("study onOff = " + study.getOnOff());

        // 반복 주기 설정
        if("(선택)".equals(study.getRepeatCycle())) {
            study.setRepeatCycle(null);
        }else {
            study.setRepeatCycle(study.getRepeatCycle());
        }

        try {
            service.register(study);
            rttr.addFlashAttribute("result", "register");
        }catch (Exception e) {
            rttr.addFlashAttribute("result", "register error");
        }

        rttr.addAttribute("userId", userId);
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
    }

    @PostMapping("/modify")
    @PreAuthorize("principal.username == #study.representation")
    public String modify(StudyVO study, StudyCriteria cri, String userId, RedirectAttributes rttr) {

        log.info("modify representation " + study.getRepresentation());

        log.info("modify study onOff = " + study.getOnOff());

        // 반복 주기 설정
        log.info("====================================repeatCycle" + study.getRepeatCycle()); //STCY01
        if("(선택)".equals(study.getRepeatCycle())) {
            study.setRepeatCycle(null);
        }else {
            study.setRepeatCycle(study.getRepeatCycle());
        }

        if(service.modify(study) == 1) {
            rttr.addFlashAttribute("result", "update");
        }else {
            rttr.addFlashAttribute("result", "update error");
        }

        rttr.addAttribute("pageNum", cri.getPageNum());
        rttr.addAttribute("amount", cri.getAmount());
        rttr.addAttribute("userId", userId);

        // 수정된 스터디의 상세조회 페이지로 이동한다.
        return "redirect:/study/get?sn=" + study.getSn();
    }

    // 스터디 삭제
    @PostMapping("/remove")
    @PreAuthorize("principal.username == #representation")
    public String remove(long sn, long grpSn, StudyCriteria cri, String representation, RedirectAttributes rttr) { // 스터디번호 들어옴

        log.info("=======================================remove cri = " + cri);

        StudyParamVO param = new StudyParamVO();
        param.setStdSn(sn);

        if(service.remove(param) == 1) {
            rttr.addFlashAttribute("result", "success");
        }else {
            rttr.addFlashAttribute("result", "error");
        }

        rttr.addAttribute("pageNum", cri.getPageNum());
        rttr.addAttribute("amount", cri.getAmount());

        return "redirect:/group/get?sn=" + grpSn;
    }
    
    // 스터디 멤버 관리 페이지 - 참여멤버/ 대기멤버 가져오기 - 아직 구현 x
    @GetMapping("/members")
    @PreAuthorize("principal.username == #study.representation")
    public void members(long stdSn, Model model) {
        model.addAttribute("study", service.get(stdSn));
        model.addAttribute("attendantList", service.getAttendantList(stdSn));
        model.addAttribute("waitingList", service.getWaitingList(stdSn));
    }

    // 스터디 찜 여부 반환
    @GetMapping(value = "/wish/{userId}/{stdSn}")
    public ResponseEntity<String> getWish(@PathVariable String userId, @PathVariable long stdSn) {

        // 로그인 되어있는 경우만 반환 가능
        StudyParamVO studyParam = new StudyParamVO();
        studyParam.setStdSn(stdSn);
        studyParam.setUserId(userId);

        log.info("스터디 찜 여부 stdSn = " + stdSn);
        log.info("스터디 찜 여부 userId = " + userId);

        try {
            WishStudyVO wishResult = service.getWish(studyParam);

            log.info("스터디 찜 여부 =======================================");

            if(wishResult == null) {
                log.info("not exist");
                return new ResponseEntity<>("not exist", HttpStatus.OK);
            }else{
                log.info("exist");
                return new ResponseEntity<>("exist", HttpStatus.OK);
            }

        }catch (Exception e) {
            log.info("fail");
            return new ResponseEntity<>("fail", HttpStatus.BAD_GATEWAY);
        }
    }

    // 스터디 찜/취소
    @PostMapping(value = "/wish", consumes = "application/json")
    public ResponseEntity<String> wish(@RequestBody WishStudyVO wish) {
        // 1. get.jsp에서 여기로 요청 보낼때 stdSn, userId 넘겨줘야함
        log.info("스터디 찜/취소 stdSn = " + wish.getStdSn());
        log.info("스터디 찜/취소 userId = " + wish.getUserId());

        wish.setUserId(wish.getUserId());

        StudyParamVO studyParam = new StudyParamVO();
        studyParam.setStdSn(wish.getStdSn());
        studyParam.setUserId(wish.getUserId());

        try{
            // 해당 스터디를 찜한 기록 불러오기
            WishStudyVO wishState = service.getWish(studyParam);

            if(wishState != null) {
                // 해당 스터디를 찜한 기록이 있으면
                try {
                    if (service.removeWish(studyParam) == 1) { // 찜 취소
                        return new ResponseEntity<>("cancelWish", HttpStatus.OK);
                    }else {// 찜 취소 실패
                        return new ResponseEntity<>("fail", HttpStatus.INTERNAL_SERVER_ERROR);
                    }
                } catch (Exception e) { // 찜 취소 실패
                    return new ResponseEntity<>("fail", HttpStatus.INTERNAL_SERVER_ERROR);
                }
            }else {
                // 찜한 기록이 있으면
                try {
                    if (service.registerWish(wish) == 1) { // 찜
                        return new ResponseEntity<>("wish", HttpStatus.OK);
                    }else {// 찜 실패
                        return new ResponseEntity<>("fail", HttpStatus.INTERNAL_SERVER_ERROR);
                    }
                } catch (Exception e) { // 찜 실패
                    return new ResponseEntity<>("fail", HttpStatus.INTERNAL_SERVER_ERROR);
                }
            }
        } catch (Exception e) { // 찜 기록 불러오기 실패
            return new ResponseEntity<>("fail", HttpStatus.INTERNAL_SERVER_ERROR);
        }

        // 4. get 페이지에서 하트가 바뀌어있어야함
    }

//    // 스터디 참가
//    @PostMapping(value = "/attend", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
//    @ResponseBody
//    public ResponseEntity<String> attend(@RequestBody StudyParamVO studyParam) {
//        //1. get.jsp에서 여기로 요청 보낼때 stdSn, userId 넘겨줘야함
//        log.info("======================================stdSn = " + studyParam.getStdSn());
//        log.info("======================================UserId = " + studyParam.getUserId());
//
//        //2. 이미 참가명단에 있는지 확인
//        // 가입한적x : 1/ 탈퇴 : 2/ 가입,검토중,영구탈퇴 : -1
//        int result = service.checkAttendantForRegister(studyParam);
//        log.info("======================================result = " + result);
//
//        if (result == -1) return new ResponseEntity<>("failAttend", HttpStatus.BAD_GATEWAY);
//
//        //3. 해당 스터디에 설문이 있는지 확인
//        // 3-1. 설문 없는 경우
//        if(service.getSurveyList(studyParam.getStdSn()).size() == 0) {
//
//            studyParam.setStatus("STUS01");
//
//            // 가입한적 없는 경우
//            if(result == 1) {
//                return service.registerAttendant(studyParam) == 1
//                    ? new ResponseEntity<>("attend", HttpStatus.OK)
//                    : new ResponseEntity<>("failAttend", HttpStatus.INTERNAL_SERVER_ERROR);
//                }
//            }else {
//                // 전에 탈퇴한 경우
//                return service.modifyAttendant(studyParam) == 1
//                    ? new ResponseEntity<>("attend", HttpStatus.OK)
//                    : new ResponseEntity<>("failAttend", HttpStatus.INTERNAL_SERVER_ERROR);
//            }
//        // 3-2. 설문 있는 경우 -> 설문 뿌려주기
//        // 아직 처리 안함
//        return new ResponseEntity<>("", HttpStatus.OK);
//    }
//
//    // 스터디 탈퇴
//    @PostMapping(value = "/cancelAttend", produces = "text/plain; charset =UTF-8")
//    @ResponseBody
//    public ResponseEntity<String> cancelAttend(StudyParamVO studyParam) {
//        //1. get.jsp에서 여기로 요청 보낼때 stdSn, userId 넘겨줘야함
//        studyParam.setUserId("boseung@naver.com"); //임의의 유저
//
//        //2. 가입 상태 확인
//        // 가입 : 1/ 검토중 : 2/그 외 : -1
//        int result = service.checkAttendantForRemove(studyParam);
//
//        if(result == -1) return new ResponseEntity<>("fail", HttpStatus.BAD_GATEWAY);
//
//        studyParam.setStatus("STUS02");
//
//        return service.modifyAttendant(studyParam) == 1
//                ? new ResponseEntity<>("success", HttpStatus.OK)
//                : new ResponseEntity<>("fail", HttpStatus.INTERNAL_SERVER_ERROR);
//    }
}
