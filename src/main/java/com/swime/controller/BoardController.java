package com.swime.controller;

import com.swime.domain.*;
import com.swime.service.BoardLikeService;
import com.swime.service.BoardService;
import com.swime.service.GroupAttendService;
import com.swime.service.ReplyService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.swing.plaf.basic.BasicSplitPaneUI;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

//@RestController
@Controller
//@RequestMapping("/board")
@RequestMapping("/board/*")
@Log4j
@AllArgsConstructor
public class BoardController {

    private BoardService service;
    private BoardLikeService boardLikeService;
    private ReplyService replyService;
    private GroupAttendService groupAttendService;


    @GetMapping(value = "/list/{grpSn}/{page}", produces = {MediaType.APPLICATION_JSON_VALUE})
    @ResponseBody
    public ResponseEntity<GroupBoardPageDTO> getList(@PathVariable("grpSn") long grpSn, @PathVariable("page") int page) {

        log.info(">>>>>>>>>>>>>  " + grpSn);
        //게시판 페이지당 3개의 게시글을 보여준다.
        BoardCriteria cri = new BoardCriteria(page, 3);
        log.info("cri>>>>>>>>>>"+cri);

        GroupBoardPageDTO list = service.getListWithPaging(cri, grpSn);

        return new ResponseEntity<>(list, HttpStatus.OK);
    }

    //게시판 페이지
    @PreAuthorize("isAuthenticated()")
    @GetMapping("/register")
    public void register(@RequestParam("grpSn") long grpSn, String userId,Model model){
        model.addAttribute("grpSn", grpSn);
        model.addAttribute("userId", userId);


        //모임번호, 유저아이디로 groupAttend에 set해서 groupAttend에 저장하고
        GroupAttendVO groupAttend = new GroupAttendVO();
        groupAttend.setGrpSn(grpSn);
        groupAttend.setUserId(userId);

        //readByGrp~에 넣어준다.(해당멤버)
        //게시판 상위 고정을 하기 위해서 해당 사용자의 그룹정보를 가져와야지 모임역할을 알 수 있다.
        //모임 역할은 1.모임장 2.운영진 3.일반회원이 있다.
        GroupAttendVO groupAttendVO = groupAttendService.readByGrpSnUserId(groupAttend);

        log.info("groupAttend : "+groupAttendVO);

        model.addAttribute("group", groupAttendVO);


    }



    @PreAuthorize("isAuthenticated()")
    @PostMapping("/register")
    public String register(BoardVO board, long grpSn, RedirectAttributes rttr) {


        if(board.getAttachList() != null){
            board.getAttachList().forEach(attach-> log.info(attach));
        }

        log.info("register...." + board);
        try{
            service.register(board);
            rttr.addFlashAttribute("boardResult", "registerSuccess");
        }catch (Exception e){
            rttr.addFlashAttribute("boardResult", "registerFail");
            e.getMessage();
        }

       return "redirect:/group/get?sn="+grpSn;
        //return "redirect:/board/get?sn="+board.getSn();
    }

//
    @GetMapping("/get")
    public void get(@RequestParam("sn") Long sn, long grpSn, String userId,
                    Model model, @ModelAttribute("cri") BoardCriteria cri) {

        GroupAttendVO groupAttend = new GroupAttendVO();
        groupAttend.setGrpSn(grpSn);
        groupAttend.setUserId(userId);

        GroupAttendVO groupAttendVO = groupAttendService.readByGrpSnUserId(groupAttend);

        //그룹을 가입한 리스트 출력 : 로그인 여부 / 모임가입 여부에 따라
        //댓글 작성 할 수 있는지...
        List<GroupAttendVO> groupList = groupAttendService.getList(grpSn);

        model.addAttribute("groupAttendList", groupList);
        model.addAttribute("group", groupAttendVO);
        model.addAttribute("board", service.get(sn));
        //(x)
        model.addAttribute("reply", replyService.get(sn));

        log.info("groupList>>>>>>>"+groupList);
        log.info("groupAttendVO : " + groupAttendVO);
        log.info("/get");
        log.info("replyServiceGet : "+replyService.get(sn));
        log.info(">>>>>>>>>>>>>>>>>>>>>>>>>"+service.get(sn));

    }


    @GetMapping("/modify")
    public void modify(@RequestParam("sn") Long sn, long grpSn, String userId,
                    Model model, @ModelAttribute("cri") BoardCriteria cri,RedirectAttributes rttr) {

        log.info("/modify");


        GroupAttendVO groupAttend = new GroupAttendVO();
        groupAttend.setGrpSn(grpSn);
        groupAttend.setUserId(userId);

        GroupAttendVO groupAttendVO = groupAttendService.readByGrpSnUserId(groupAttend);

        model.addAttribute("board", service.get(sn));
        model.addAttribute("group", groupAttendVO);
        //(x)
        model.addAttribute("reply", replyService.get(sn));

        log.info("groupAttend  : "+groupAttendVO);
        log.info("replyServiceGet : "+replyService.get(sn));
        log.info(">>>>>>>>>>>>>>>>>>>>>>>>>"+service.get(sn));
    }


    @PreAuthorize("principal.username == #board.userId")
    @PostMapping("/modify")
    public String modify(BoardVO board, long grpSn, @ModelAttribute("cri") BoardCriteria cri,
                         RedirectAttributes rttr) {


        log.info("modify: " + board);
        try{
            if (service.modify(board)) {
                rttr.addFlashAttribute("result", "success");
            }else{
                //fail처리
                //rttr.addFlashAttribute("result", "fail");
            }
        }catch (Exception e){
            e.getMessage();
        }


        rttr.addAttribute("pageNum", cri.getPageNum());
        rttr.addAttribute("amount", cri.getAmount());

        return "redirect:/group/get?sn="+grpSn;
        //return "redirect:/board/get?sn="+board.getSn();
    }

    @PreAuthorize("principal.username == #userId")
    @PostMapping("/remove")
    public String remove(@RequestParam("sn") Long sn, long grpSn, @ModelAttribute("cri") BoardCriteria cri,
                         RedirectAttributes rttr) {

        log.info("remove: " + sn);

        List<BoardAttachVO> attachList = service.getAttachList(sn);

        if (service.remove(sn)) {
            //파일 삭제 함수 호출
            deleteFiles(attachList);
            rttr.addFlashAttribute("boardResult", "removeSuccess");
        }else{
            rttr.addFlashAttribute("boardResult", "removefail");
        }
//
        rttr.addAttribute("pageNum", cri.getPageNum());
        rttr.addAttribute("amount", cri.getAmount());

        return "redirect:/group/get?sn=" + grpSn;

    }

    //좋아요 눌렀는지 여부 판단
    // userId:.+ => 아이디 가져 올 때 .com 못 가져옴 넣어주면 가져옴
    @GetMapping(value = "/like/{brdSn}/{userId:.+}")
    public ResponseEntity<String> getLike(@PathVariable("brdSn") long brdSn,
                                          @PathVariable("userId") String userId){

        BoardLikeVO boardLike = new BoardLikeVO();
        boardLike.setBrdSn(brdSn);
        boardLike.setUserId(userId);
        //boardLike.setUserId("toywar94@gmail.com");
        log.info("brdSn>>>>>>>>"+brdSn);
        log.info("userId>>>>>>>>"+userId);
        log.info("....boardLike>>>>>>> : " + boardLike);

        // 게시판 번호, 유저아이디로 읽어온다.
        BoardLikeVO getBoardLike = boardLikeService.read(boardLike);


        log.info("....getBoardLike>>>>>> " + getBoardLike);

        //
        // 좋아요가 없으면 빈하트
        if (getBoardLike == null){
            log.info("....null>>>>>> ");
            return new ResponseEntity<>("notExist",HttpStatus.OK);
        // 있으면 채워진 하트
        }else{
            log.info("... else>>>>>> ");
            return new ResponseEntity<>("exist", HttpStatus.OK);
        }

    }

    @PostMapping("/createLike")
    public ResponseEntity<Integer> createLike(@RequestBody BoardLikeVO boardLike) {

        log.info("boardLikeVO : " + boardLike);
        log.info("getBrdSn : " + boardLike.getBrdSn());
        log.info("getUserId : " + boardLike.getUserId());

        //좋아요 누른 게시물 번호, 유저 아이디를 가져와서 set한다
       BoardLikeVO getBoardLike = new BoardLikeVO();
       getBoardLike.setBrdSn(boardLike.getBrdSn());
       getBoardLike.setUserId(boardLike.getUserId());

       log.info("getBoardLike : "+getBoardLike);
        // 게시판 번호, 유저아이디로 좋아요를 읽어온다.
       BoardLikeVO likeExist = boardLikeService.read(getBoardLike);


       //좋아요가 존재하면 삭제한다.
       if (likeExist != null){

           try {
               //좋아요 삭제에 성공하면 좋아요 개수를 반환
               if (boardLikeService.remove(boardLike.getBrdSn(), boardLike.getUserId()) == 1){
                   return new ResponseEntity<>(boardLikeService.getBoardLikeCnt(boardLike.getBrdSn()),HttpStatus.OK);
               }else{
                   return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
               }
           } catch(Exception e) {
               return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);

           }
       //좋아요가 존재x 등록한다.
       }else{

           try {
                //좋아요 등록에 성공하면 개수를 반환한다.
               if(boardLikeService.register(boardLike) == 1){
                   return new ResponseEntity<>(boardLikeService.getBoardLikeCnt(boardLike.getBrdSn()),HttpStatus.OK);
               }else{
                   return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
               }

           } catch(Exception e) {

               return new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);

           }

       }

    }

    @GetMapping(value = "/getAttachList", produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public ResponseEntity<List<BoardAttachVO>> getAttachList(Long brdSn){

        log.info("getAttach>>>>>>>>>" + brdSn);

        return new ResponseEntity<>(service.getAttachList(brdSn), HttpStatus.OK);
    }

    //파일삭제
    private void deleteFiles(List<BoardAttachVO> attachList) {

        if(attachList == null || attachList.size() == 0) {
            return;
        }

        log.info("delete attach file..........");
        log.info(attachList);

       attachList.forEach(attach ->{

           try{
               Path file = Paths.get("C:\\upload\\"+attach.getUploadPath()+"\\"+attach.getUuid()+"_"+attach.getFileName());

               Files.deleteIfExists(file);

               if(Files.probeContentType(file).startsWith("image")) {
                   Path thumbNail = Paths.get("C:\\upload||"+attach.getUploadPath()+"\\s_"+attach.getUuid()+"_"+attach.getFileName());
                   Files.delete(thumbNail);
               }

           }catch (Exception e){
               log.info("delete file error : " + e.getMessage());
           }//end catch
       });//end foreach

    }

}

