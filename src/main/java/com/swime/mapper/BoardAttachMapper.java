package com.swime.mapper;

import com.swime.domain.BoardAttachVO;

import java.util.List;

public interface BoardAttachMapper {

    //첨부파일은 수정 개념이 없으므로 작성 안함.

    public void insert(BoardAttachVO vo);

    public int delete(String uuid);

    //특정 게시물의 번호로 첨부파일 검색
    public List<BoardAttachVO> findByBrdSn(Long brdSn);

    //게시글에 파일을 같이 올렸을 경우 게시글 삭제 시 파일까지 삭제해야함.
    //첨부파일 전부 삭제.
    public int deleteAll(Long brdSn);
}
