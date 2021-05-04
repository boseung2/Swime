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
        WishStudyVO wish= new WishStudyVO();
        wish.setStdSn(stdSn);
        wish.setUserId(userId);

        WishStudyVO wishResult = service.getWish(wish);

        if(wishResult == null) {
            log.info("스터디 찜 여부 = not exist");
            return new ResponseEntity<>("not exist", HttpStatus.OK);
        }else{
            log.info("스터디 찜 여부 = exist");
            return new ResponseEntity<>("exist", HttpStatus.OK);
        }
    }

    // 스터디 찜/취소
    @PostMapping(value = "/wish", consumes = "application/json")
    public ResponseEntity<String> wish(@RequestBody WishStudyVO wish) {

        // 1. get.jsp에서 여기로 요청 보낼때 stdSn, userId 넘겨줘야함
        log.info("스터디 찜/취소 stdSn = " + wish.getStdSn());
        log.info("스터디 찜/취소 userId = " + wish.getUserId());

        WishStudyVO wishState = service.getWish(wish);

        if (wishState != null) {
            // 찜 취소
            service.removeWish(wish);
            return new ResponseEntity<>("cancelWish", HttpStatus.OK);
        } else {
            // 찜
            service.registerWish(wish);
            return new ResponseEntity<>("wish", HttpStatus.OK);
        }
    }
}
