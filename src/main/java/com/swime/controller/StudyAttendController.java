package com.swime.controller;


import com.swime.domain.GroupAttendVO;
import com.swime.domain.StudyListVO;
import com.swime.domain.StudyParamVO;
import com.swime.domain.WishStudyVO;
import com.swime.service.GroupAttendService;
import com.swime.service.StudyService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RequestMapping("/study")
@RestController
@Log4j
@AllArgsConstructor
public class StudyAttendController {

    private StudyService service;
    private GroupAttendService groupAttendService;

    // 스터디 명단에 해당 id가 있는지 확인
    @GetMapping(value="/getAttend/{grpSn}/{userId}/{stdSn}")
    public ResponseEntity<String> getAttend (@PathVariable("grpSn") long grpSn, @PathVariable("userId") String userId, @PathVariable("stdSn") long stdSn) {
        // 1. 그룹명단에 해당 id가 있는지 확인/ 없으면 group not attend 반환
        // userId, grpSn 필요
        GroupAttendVO groupAttendVO = new GroupAttendVO();
        groupAttendVO.setGrpSn(grpSn);
        groupAttendVO.setUserId(userId);

        GroupAttendVO groupAttend = groupAttendService.readByGrpSnUserId(groupAttendVO);

        if(groupAttend == null || !"GRUS01".equals(groupAttend.getStatus())) {
            log.info("그룹에 없다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
            return new ResponseEntity<>("group not attend", HttpStatus.OK);

        }else {
            // 2. 그룹에 가입되어있으면 해당 id가 스터디 명단에 있는지 확인
            // userId, stdSn 필요
            StudyParamVO studyParamVO = new StudyParamVO();
            studyParamVO.setStdSn(stdSn);
            studyParamVO.setUserId(userId);

            StudyListVO attendant = service.getAttendant(studyParamVO);

            // 3-1. 해당 스터디 명단에 없으면 not attend 반환
            if(attendant == null) {
                log.info("스터디에 없다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                return new ResponseEntity<>("not attend", HttpStatus.OK);

            } else {
                // 3-2. 있고, 탈퇴 상태면 not attend 반환
                if("STUS02".equals(attendant.getStatus())) {
                    log.info("탈퇴했다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                    return new ResponseEntity<>("not attend", HttpStatus.OK);
                }

                // 3-3. 있고, 가입상태면 attend 반환
                if("STUS01".equals(attendant.getStatus())) {
                    log.info("이미 가입했다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                    return new ResponseEntity<>("attend", HttpStatus.OK);
                }

                // 3-4. 있고, 검토중인 상태면 waiting 반환
                if("STUS03".equals(attendant.getStatus())) {
                    log.info("검토중이다!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                    return new ResponseEntity<>("waiting", HttpStatus.OK);
                }

                // 3-5. 있고, 영구탈퇴인 상태면 kicked 반환
                if("STUS04".equals(attendant.getStatus())) {
                    log.info("영구탈퇴!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!");
                    return new ResponseEntity<>("kicked", HttpStatus.OK);
                }

                // 다 아니면 실패 반환
                return new ResponseEntity<>("fail", HttpStatus.BAD_GATEWAY);
            }
        }
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
