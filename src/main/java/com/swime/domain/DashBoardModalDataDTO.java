package com.swime.domain;

import lombok.Data;

import java.util.List;

@Data
public class DashBoardModalDataDTO {
    int count;
    List<DashBoardModalDataVO> list;
}
