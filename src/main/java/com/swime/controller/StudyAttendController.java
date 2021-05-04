package com.swime.controller;


import com.swime.domain.GroupAttendVO;
import com.swime.domain.StudyListVO;
import com.swime.domain.StudyParamVO;
import com.swime.domain.WishStudyVO;
import com.swime.service.GroupAttendService;
import com.swime.service.StudyListService;
import com.swime.service.StudyService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RequestMapping("/study/attend")
@RestController
@Log4j
@AllArgsConstructor
public class StudyAttendController {

    private StudyListService service;
    private GroupAttendService groupAttendService;

    // 스터디 명단에 해당 id가 있는지 확인
    @GetMapping(value="/get/{grpSn}/{userId}/{stdSn}")
    public ResponseEntity<String> get (@PathVariable("grpSn") long grpSn, @PathVariable("userId") String userId, @PathVariable("stdSn") long stdSn) {

        // 그룹명단에 해당 id가 있는지 확인/ 없으면 group not attend 반환
        // userId, grpSn 필요
        GroupAttendVO groupAttendVO = new GroupAttendVO();
        groupAttendVO.setGrpSn(grpSn);
        groupAttendVO.setUserId(userId);

        GroupAttendVO groupAttend = groupAttendService.readByGrpSnUserId(groupAttendVO);

        if(groupAttend == null || !"GRUS01".equals(groupAttend.getStatus())) {
            // 1. 그룹에 없거나 그룹에 참가상태가 아니면
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
                return new ResponseEntity<>("not attend", HttpStatus.OK);

            } else {
                // 3-2. 있고, 탈퇴 상태면 not attend 반환
                if("STUS02".equals(attendant.getStatus())) {
                    return new ResponseEntity<>("not attend", HttpStatus.OK);
                }

                // 3-3. 있고, 가입상태면 attend 반환
                if("STUS01".equals(attendant.getStatus())) {
                    return new ResponseEntity<>("attend", HttpStatus.OK);
                }

                // 3-4. 있고, 검토중인 상태면 waiting 반환
                if("STUS03".equals(attendant.getStatus())) {
                    return new ResponseEntity<>("waiting", HttpStatus.OK);
                }

                // 3-5. 있고, 영구탈퇴인 상태면 kicked 반환
                if("STUS04".equals(attendant.getStatus())) {
                    return new ResponseEntity<>("kicked", HttpStatus.OK);
                }

                // 다 아니면 실패 반환
                return new ResponseEntity<>("fail", HttpStatus.BAD_GATEWAY);
            }
        }
    }

    // 스터디 참가
    @PostMapping(value = "/register", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
    public ResponseEntity<String> register(@RequestBody StudyParamVO studyParam) {
        //1. 여기로 요청 보낼때 stdSn, userId 넘겨줘야함
        log.info("register stdSn = " + studyParam.getStdSn());
        log.info("register userId = " + studyParam.getUserId());

        //2. 이미 참가명단에 있는지 확인
        StudyListVO attendant = service.getAttendant(studyParam);

        // 3-1. 없으면 참석상태로 추가
        if(attendant == null) {
            studyParam.setStatus("STUS01");
            service.registerAttendant(studyParam);

            return new ResponseEntity<>("success", HttpStatus.OK);
        }else {
            // 3-2. 있고, 탈퇴상태면 참석상태로 update
            if("STUS02".equals(attendant.getStatus())) {
                studyParam.setStatus("STUS01");
                service.modifyAttendant(studyParam);

                return new ResponseEntity<>("success", HttpStatus.OK);
            }

            // 3-3. 있고, 검토중이면 참석상태로 update
            if("STUS03".equals(attendant.getStatus())) {
                studyParam.setStatus("STUS01");
                service.modifyAttendant(studyParam);

                return new ResponseEntity<>("success", HttpStatus.OK);
            }

            // 그 외의 상태 (가입, 검토중, 영구탈퇴)는 참가 실패
            return new ResponseEntity<>("fail", HttpStatus.BAD_GATEWAY);
        }
    }

    // 스터디 탈퇴
    @PostMapping(value = "/cancel", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
    public ResponseEntity<String> cancel(@RequestBody StudyParamVO studyParam) {
        //1. 여기로 요청 보낼때 stdSn, userId 넘겨줘야함
        log.info("cancel stdSn = " + studyParam.getStdSn());
        log.info("cancel userId = " + studyParam.getUserId());

        //2. 이미 참가명단에 있는지 확인
        StudyListVO attendant = service.getAttendant(studyParam);

        // 3. 참가명단에 있고, 가입상태이면 탈퇴 상태로 update
        if(attendant != null && "STUS01".equals(attendant.getStatus())) {
            studyParam.setStatus("STUS02");
            service.modifyAttendant(studyParam);

            return new ResponseEntity<>("success", HttpStatus.OK);
        }

        // 그 외의 상태 (가입, 검토중, 영구탈퇴)는 참가 실패
        return new ResponseEntity<>("fail", HttpStatus.BAD_GATEWAY);
    }

    // 스터디 영구탈퇴
    @PostMapping(value = "/ban", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
    public ResponseEntity<String> ban(@RequestBody StudyParamVO studyParam) {
        //1. 여기로 요청 보낼때 stdSn, userId 넘겨줘야함
        log.info("ban stdSn = " + studyParam.getStdSn());
        log.info("ban userId = " + studyParam.getUserId());

        //2. 이미 참가명단에 있는지 확인
        StudyListVO attendant = service.getAttendant(studyParam);

        // 3. 참가명단에 있고, 가입상태이면 영구탈퇴로 update
        if(attendant != null && "STUS01".equals(attendant.getStatus())) {
            studyParam.setStatus("STUS04");
            service.modifyAttendant(studyParam);

            return new ResponseEntity<>("success", HttpStatus.OK);
        }

        // 그 외의 상태 (미가입, 가입, 검토중, 탈퇴)는 영구강퇴 실패
        return new ResponseEntity<>("fail", HttpStatus.BAD_GATEWAY);
    }

    // 스터디 영구탈퇴 취소
    @PostMapping(value = "/cancelBan", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
    public ResponseEntity<String> cancelBan(@RequestBody StudyParamVO studyParam) {
        //1. 여기로 요청 보낼때 stdSn, userId 넘겨줘야함
        log.info("cancelBan stdSn = " + studyParam.getStdSn());
        log.info("cancelBan userId = " + studyParam.getUserId());

        //2. 이미 참가명단에 있는지 확인
        StudyListVO attendant = service.getAttendant(studyParam);

        // 3. 참가명단에 있고, 영구탈퇴 상태이면 탈퇴 상태로 update
        if(attendant != null && "STUS04".equals(attendant.getStatus())) {
            studyParam.setStatus("STUS02");
            service.modifyAttendant(studyParam);

            return new ResponseEntity<>("success", HttpStatus.OK);
        }

        // 그 외의 상태 (미가입, 가입, 검토중, 탈퇴)는 영구강퇴취소 실패
        return new ResponseEntity<>("fail", HttpStatus.BAD_GATEWAY);
    }

    // 검토중인 회원 거절
    @PostMapping(value = "/reject", consumes = "application/json", produces = {MediaType.TEXT_PLAIN_VALUE})
    public ResponseEntity<String> reject(@RequestBody StudyParamVO studyParam) {
        //1. 여기로 요청 보낼때 stdSn, userId 넘겨줘야함
        log.info("reject stdSn = " + studyParam.getStdSn());
        log.info("reject userId = " + studyParam.getUserId());

        //2. 이미 참가명단에 있는지 확인
        StudyListVO attendant = service.getAttendant(studyParam);

        // 3. 참가명단에 있고, 검토중인 상태이면
        if(attendant != null && "STUS03".equals(attendant.getStatus())) {
            try {
                //참여명단에서 삭제하고, 해당 스터디에있는 해당 유저의 답변을 모두 삭제
                service.removeAttendant(studyParam);

                return new ResponseEntity<>("success", HttpStatus.OK);
            } catch (Exception e) {
                return new ResponseEntity<>("fail", HttpStatus.INTERNAL_SERVER_ERROR);
            }
        }

        // 그 외의 상태는 거절 못함
        return new ResponseEntity<>("fail", HttpStatus.BAD_GATEWAY);
    }
}
