package com.swime.controller;

import com.swime.domain.*;
import com.swime.service.GroupAttendService;
import com.swime.service.GroupRatingService;
import com.swime.domain.GroupVO;
import com.swime.service.GroupService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
        log.info("****************************************************" +
                "INSERT COUNT : " + insertCount);

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
    public ResponseEntity<Map<String, Object>> get(
            @PathVariable("sn") Long sn) {

        Map<String, Object> map = new HashMap<>();
        // 기본그룹정보
        map.put("group", groupService.get(sn));
        // 그룹 가입자리스트
        map.put("attendList", groupAttendService.getList(sn));
        // 그룹 후기리스트
        map.put("ratingList", groupRatingService.getListWithPaging(sn, new GroupRatingCriteria(1, 6)));
        return new ResponseEntity<>(map, HttpStatus.OK);
    }

    @PostMapping(value = "/list")
    public ResponseEntity<List<GroupVO>> getList(@RequestBody GroupCriteria cri) {
        // 그룹 리스트 가져온다.
        return new ResponseEntity<>(groupService.getListWithPaging(cri), HttpStatus.OK);
    }

    @RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH},
                    value = "/{sn}")
    public ResponseEntity<String> modify(
            @RequestBody GroupVO group,
            @PathVariable("sn") Long sn) {
        // 모임정보 수정한다.
        group.setSn(sn);
        log.info("sn: " + sn);
        log.info("modify: " + group);
        return groupService.modify(group)
                ? new ResponseEntity<>("success", HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @PostMapping(value = "/attend")
    public ResponseEntity<String> attend(@RequestBody GroupAttendVO groupAttend) {
        // 모임에 참여한다.
        int count = groupAttendService.attend(groupAttend);

        // 해당 모임 가입자 수를 모임정보에 업데이트한다.
        Long grpSn = groupAttend.getGrpSn();
        GroupVO group = groupService.get(grpSn);
        group.setAttendCount(groupAttendService.getAttendCountByGroupSn(grpSn));
        groupService.modify(group);
        return count == 1
                ? new ResponseEntity<>("success", HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @GetMapping(value = "/userList/{sn}")
    public ResponseEntity<List<GroupAttendVO>> getAttendList(@PathVariable("sn") Long sn) {
        // 해당모임 가입유저를 가져온다.
        return new ResponseEntity<>(groupAttendService.getList(sn), HttpStatus.OK);
    }

    @RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH},
                value = "/user/{sn}")
    public ResponseEntity<String> modifyAttend(@RequestBody GroupAttendVO groupAttend, @PathVariable("sn") Long sn) {
        // 참석여부를 수정한다
        groupAttend.setSn(sn);
        return groupAttendService.modify(groupAttend) == 1
                ? new ResponseEntity<>("success", HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @PostMapping(value = "/rating/new")
    public ResponseEntity<String> registerRating(@RequestBody GroupRatingVO groupRating) {
        // 후기 등록
        int registerCount = groupRatingService.register(groupRating);

        return registerCount == 1
                ? new ResponseEntity<>("success", HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH},
                    value = "/rating/{sn}")
    public ResponseEntity<String> modifyRating(@RequestBody GroupRatingVO groupRating,
                                               @PathVariable("sn") Long sn) {
        // 후기 수정
        groupRating.setSn(sn);
        log.info("sn: " + sn);
        log.info("modify: " + groupRating);
        return groupRatingService.modify(groupRating) == 1
                ? new ResponseEntity<>("success", HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @DeleteMapping(value = "/rating/{sn}")
    public ResponseEntity<String> deleteRating(@PathVariable("sn") Long sn) {
        // 후기삭제
        groupRatingService.delete(sn);
        return groupRatingService.delete(sn) == 1
                ? new ResponseEntity<>("success", HttpStatus.OK)
                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
    }

}
