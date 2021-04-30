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


//    @GetMapping("/list")
//    public void list(Model model) {
//
//        log.info("list");
//
//        model.addAttribute("list", service.getList());
//    }

//    @GetMapping("/list")
//    public void list(BoardCriteria cri, Model model){
//        log.info("list: " + cri);
//
//        model.addAttribute("list", service.getListWithPaging(cri));
//        //model.addAttribute("pageMaker", new BoardDTO(cri,123));
//        int total = service.getTotal(cri);
//        log.info("total: " + total);
//        model.addAttribute("pageMaker", new BoardPageDTO(cri, total));
//
//    }

    @GetMapping(value = "/list/{grpSn}/{page}", produces = {MediaType.APPLICATION_JSON_VALUE})
    @ResponseBody
    public ResponseEntity<GroupBoardPageDTO> getList(@PathVariable("grpSn") long grpSn, @PathVariable("page") int page) {
        log.info(">>>>>>>>>>>>>  " + grpSn);
        BoardCriteria cri = new BoardCriteria(page, 3);
        log.info("cri>>>>>>>>>>"+cri);

        GroupBoardPageDTO list = service.getListWithPaging(cri, grpSn);

        return new ResponseEntity<>(list, HttpStatus.OK);
    }


//    @GetMapping("/register")
//    public void register(){
//
//    }

    //게시판 생성 페이지
    @PreAuthorize("isAuthenticated()")
    @GetMapping("/register")
    public void register(@RequestParam("grpSn") long grpSn, String userId,Model model){
        model.addAttribute("grpSn", grpSn);
        model.addAttribute("userId", userId);

        //상위고정하기위해서 그룹참석자의 그룹역할을 가져온다.
        GroupAttendVO groupAttend = new GroupAttendVO();
        groupAttend.setGrpSn(grpSn);
        groupAttend.setUserId(userId);

        GroupAttendVO groupAttendVO = groupAttendService.readByGrpSnUserId(groupAttend);

        log.info("groupAttend 가져왔나용?!!!!!!!!!"+groupAttendVO);

        model.addAttribute("group", groupAttendVO);

        //현재 모임의 참가명단에 접근해서 모임역할을 가져와야한다.
        //-> readByGrpSnUserId() 접근하면 도미
//        GroupAttendVO groupAttend = groupAttendService.get(grpSn);
//        model.addAttribute("group", groupAttend);
//        log.info("groupAttend>>>>>" + groupAttend);
    }


//    @PostMapping("/register")
//    public String register(BoardVO board, RedirectAttributes rttr) {
//
//        log.info("register...." + board);
//
//        service.register(board);
//
//        rttr.addFlashAttribute("result", board.getSn());
//
//        return "redirect:/board/list";
//    }

    @PreAuthorize("isAuthenticated()")
    @PostMapping("/register")
    public String register(BoardVO board, long grpSn, RedirectAttributes rttr) {


        log.info("-----------------------------");
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

        model.addAttribute("group", groupAttendVO);
        model.addAttribute("board", service.get(sn));
        model.addAttribute("reply", replyService.get(sn));

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
        model.addAttribute("reply", replyService.get(sn));
        model.addAttribute("group", groupAttendVO);

        log.info("groupAttend 가져왔나용?!!!!!!!!!"+groupAttendVO);
        log.info("replyServiceGet : "+replyService.get(sn));
        log.info(">>>>>>>>>>>>>>>>>>>>>>>>>"+service.get(sn));
    }


    @PreAuthorize("principal.username == #board.userId")
    @PostMapping("/modify")
    public String modify(BoardVO board, long grpSn, @ModelAttribute("cri") BoardCriteria cri,
                         RedirectAttributes rttr) {

        //상위 고정도 나중에하기.
//        BoardVO boardVO = service.get(board.getSn());
//        if(board.getTopFix().equals("")) board.setTopFix("BOFI02");

        log.info("modify: " + board);
        try{
            if (service.modify(board)) {
                rttr.addFlashAttribute("result", "success");
            }else{
                //fail처리
                //rttr.addFlashAttribute("result", "success");
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
    // userId:.+ => 아이디 가져 올 때 .com 안가져와서 넣어주면 가져옴
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

        BoardLikeVO getBoardLike = boardLikeService.read(boardLike);


        log.info("....getBoardLike>>>>>> " + getBoardLike);

        // 좋아요가 없으면 빈하트
        // 있으면 채워진 하트
        if (getBoardLike == null){
            log.info("....null>>>>>> ");
            return new ResponseEntity<>("notExist",HttpStatus.OK);
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

        //좋아요 누른 게시물 번호, 유저 아이디를 가져온다.
       BoardLikeVO getBoardLike = new BoardLikeVO();
       getBoardLike.setBrdSn(boardLike.getBrdSn());
       getBoardLike.setUserId(boardLike.getUserId());

       log.info("getBoardLike : "+getBoardLike);

       //좋아요가 존재하면 삭제한다.
       if(boardLikeService.read(getBoardLike) != null){
           return boardLikeService.remove(boardLike.getBrdSn(), boardLike.getUserId()) == 1
                   //좋아요 개수를 보낸다.
                   ? new ResponseEntity<>(boardLikeService.getBoardLikeCnt(boardLike.getBrdSn()),HttpStatus.OK)
                   : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
       }else{
           //좋아요가 존재하지 않으면 등록한다.
           return boardLikeService.register(boardLike) == 1
                   ? new ResponseEntity<>(boardLikeService.getBoardLikeCnt(boardLike.getBrdSn()),HttpStatus.OK)
                   : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
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







//    @PostMapping(value = "/new")
//    public ResponseEntity<String> create(@RequestBody BoardVO vo) {
//
//        ResponseEntity<String> entity = null;
//        log.info("BoardVO: " + vo);
//
//        try {
//            int insertCount = service.register(vo);
//            log.info("Board INSERT COUNT: " + insertCount);
//            new ResponseEntity<>("success", HttpStatus.OK);
//
//        }catch(Exception e){
//            e.printStackTrace();
//            entity = new ResponseEntity<>(e.getMessage(),HttpStatus.INTERNAL_SERVER_ERROR);
//
//        }
//        return entity;
//
////        return insertCount == 1
////                ? new ResponseEntity<>("success", HttpStatus.OK)
////                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
//    }
//
//    @GetMapping(value = "/list")
//    public ResponseEntity<List<BoardVO>> getList(@RequestBody BoardCriteria cri) {
//        return new ResponseEntity<>(service.getListWithPaging(cri), HttpStatus.OK);
//    }
//
//
//    @GetMapping(value = "/{sn}")
//    public ResponseEntity<BoardVO> get(
//            @PathVariable("sn") Long sn) {
//        return new ResponseEntity<>(service.get(sn), HttpStatus.OK);
//    }
//
//    @RequestMapping(method = {RequestMethod.PUT, RequestMethod.PATCH},
//            value = "/{sn}")
//    public ResponseEntity<String> modify(
//            @RequestBody BoardVO vo,
//            @PathVariable("sn") Long sn) {
//
//        vo.setSn(sn);
//
//        log.info("sn: " + sn);
//        log.info("modify: " + vo);
//
//        return service.modify(vo)
//                ? new ResponseEntity<>("success", HttpStatus.OK)
//                : new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
//    }

//}
