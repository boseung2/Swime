package com.swime.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

import java.util.List;

@Data
@Getter
@AllArgsConstructor
public class AdminGroupPageDTO {
    private int groupCnt;
    private List<GroupVO> list;
}
