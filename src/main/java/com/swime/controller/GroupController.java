package com.swime.controller;

import com.swime.domain.*;
import com.swime.service.GroupAttendService;
import com.swime.service.GroupRatingService;
import com.swime.service.GroupService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/group")
@Log4j
@AllArgsConstructor
public class GroupController {

    private GroupService groupService;
    private GroupAttendService groupAttendService;
    private GroupRatingService groupRatingService;

    @PostMapping(value = "/new")
    public ResponseEntity<String> create(@RequestBody GroupVO vo) {
        // 모임을 등록한다.
        int insertCount = groupService.register(vo);

        // 모임 등록자를 모임리스트에 모임장으로 등록한다.
        GroupAttendVO groupAttend = new GroupAttendVO();
        groupAttend.setGrpSn(vo.getSn());
        groupAttend.setUserId(vo.getUserId());
        groupAttend.setGrpRole("GRRO01"); // "GRRO01" = 모임장
        groupAttend.setStatus("GRUS01"); // "GRUS01" = 정상상태
        groupAttendService.attend(groupAttend);

        return insertCount == 1
                ? new ResponseEntity<>("success", HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @GetMapping(value = "/{sn}")
    public ResponseEntity<GroupVO> get(
            @PathVariable("sn") Long sn) {

        // 기본그룹정보
        GroupVO group = groupService.get(sn);
        // 그룹 가입자리스트
        //List<GroupAttendVO> attendList = groupAttendService.getList(sn);
        // 그룹 후기리스트
        //List<GroupRatingVO> ratingList = groupRatingService.getListWithPaging(sn, new GroupRatingCriteria(1, 6));

        return new ResponseEntity<>(group, HttpStatus.OK);
    }

    @PostMapping(value = "/list")
    public ResponseEntity<List<GroupVO>> getList(@RequestBody GroupCriteria cri) {
        return new ResponseEntity<>(groupService.getListWithPaging(cri), HttpStatus.OK);
    }

    @RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH},
                    value = "/{sn}")
    public ResponseEntity<String> modify(
            @RequestBody GroupVO vo,
            @PathVariable("sn") Long sn) {
        vo.setSn(sn);
        log.info("sn: " + sn);
        log.info("modify: " + vo);
        return groupService.modify(vo)
                ? new ResponseEntity<>("success", HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }





}
