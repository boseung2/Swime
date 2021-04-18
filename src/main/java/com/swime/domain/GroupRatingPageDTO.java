package com.swime.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;

import java.util.List;

@Data
@AllArgsConstructor
@Getter
public class GroupRatingPageDTO {

    private Long ratingCnt;
    private List<GroupRatingVO> list;
}
