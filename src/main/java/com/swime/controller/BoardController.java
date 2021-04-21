package com.swime.controller;

import com.swime.domain.*;
import com.swime.service.BoardLikeService;
import com.swime.service.BoardService;
import com.swime.service.ReplyService;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
        BoardCriteria cri = new BoardCriteria(page, 10);
        GroupBoardPageDTO list = service.getListWithPaging(cri, grpSn);

        return new ResponseEntity<>(list, HttpStatus.OK);
    }


//    @GetMapping("/register")
//    public void register(){
//
//    }

    //게시판 생성 페이지
    @GetMapping("/register")
    public void register(@RequestParam("grpSn") long grpSn, Model model){
        model.addAttribute("grpSn", grpSn);
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

    //등록 후 게시판 상세 페이지로 이동
    @PostMapping("/register")
    public String register(BoardVO board, RedirectAttributes rttr) {

        log.info("register...." + board);

        service.register(board);

        rttr.addFlashAttribute("result", board.getSn());

        return "redirect:/board/get?sn="+board.getSn();
    }

    @GetMapping({"/get","/modify"})
    public void get(@RequestParam("sn") Long sn, Model model,
                    @ModelAttribute("cri") BoardCriteria cri) {

        log.info("/get or modify");
        model.addAttribute("board", service.get(sn));
        model.addAttribute("reply", replyService.get(sn));
        //좋아요 처리 나중에 다시 하기----------
        model.addAttribute("isLike", true);
        model.addAttribute("count", boardLikeService.getBoardLikeCnt(1L));

        log.info(">>>>>>>>>>>>>>>>>>>>>>>>>"+service.get(sn));

    }

    @PostMapping("/modify")
    public String modify(BoardVO board, @ModelAttribute("cri") BoardCriteria cri,
                         RedirectAttributes rttr) {

        //상위 고정도 나중에하기.
        BoardVO boardVO = service.get(board.getSn());
        if(board.getTopFix().equals("")) board.setTopFix("BOFI02");

        log.info("modify: " + board);

        if (service.modify(board)) {
            rttr.addFlashAttribute("result", "success");
        }

        rttr.addAttribute("pageNum", cri.getPageNum());
        rttr.addAttribute("amount", cri.getAmount());

        return "redirect:/board/get?sn="+board.getSn();
    }

    @PostMapping("/remove")
    public String remove(@RequestParam("sn") Long sn, long grpSn, @ModelAttribute("cri") BoardCriteria cri,
                         RedirectAttributes rttr) {

        log.info("remove: " + sn);
        if (service.remove(sn)) {
            rttr.addFlashAttribute("result", "success");
        }else{
            rttr.addFlashAttribute("result", "fail");
        }

        rttr.addAttribute("pageNum", cri.getPageNum());
        rttr.addAttribute("amount", cri.getAmount());

        return "redirect:/group/get?sn=" + grpSn;

    }

    //좋아요 기능 구현
    @PostMapping("/clickLike")
    public int like(@RequestParam("brdSn") Long brdSn, @RequestParam("userId") String userId){

        BoardLikeVO boardLike = new BoardLikeVO();

        boardLike.setBrdSn(brdSn);
        boardLike.setUserId(userId);

        return boardLikeService.register(boardLike);

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
