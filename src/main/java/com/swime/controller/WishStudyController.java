package com.swime.controller;


import com.swime.domain.StudyParamVO;
import com.swime.domain.WishStudyVO;
import com.swime.service.StudyService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RequestMapping("/study")
@RestController
@Log4j
@AllArgsConstructor
public class WishStudyController {

    private StudyService service;

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
}
