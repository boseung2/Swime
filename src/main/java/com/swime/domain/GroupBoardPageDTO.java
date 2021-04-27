package com.swime.domain;


import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.ToString;

import java.util.List;

@Getter
@ToString
@AllArgsConstructor
public class GroupBoardPageDTO {

    private int boardCnt;
    private List<BoardVO> list;
}
