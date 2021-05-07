package com.swime.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

import java.util.List;

@Data
@Getter
@AllArgsConstructor
public class AdminBoardPageDTO {
    private int boardCnt;
    private List<BoardVO> list;
}
