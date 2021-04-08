package com.swime.service;

import com.swime.domain.GroupRatingCriteria;
import com.swime.domain.GroupRatingVO;
import com.swime.domain.GroupVO;
import com.swime.mapper.GroupMapper;
import com.swime.mapper.GroupRatingMapper;
import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;
import org.springframework.stereotype.Service;

import java.util.List;

@Log4j
@Service
@AllArgsConstructor
public class GroupRatingServiceImpl implements GroupRatingService{

    private GroupRatingMapper groupRatingMapper;
    private GroupMapper groupMapper;

    @Override
    public int register(GroupRatingVO groupRating) {
        groupRatingMapper.insert(groupRating);
        // 해당 그룹 번호를 불러온다.
        long grpSn = groupRating.getGrpSn();
        // 그 해당하는 그룹을 mapper로 가져와요
        GroupVO group = groupMapper.read(grpSn);
        // 그 가져온놈의 rating을 평균을 가져와서 set한다.
        group.setRating(groupRatingMapper.getRatingByGrpSn(grpSn));
        // 그 가져온놈의 rating의 개수를 가져와서 set한다.
        group.setRatingCount(groupRatingMapper.getRatingCountByGrpSn(grpSn));
        // 그 가져온놈들을 update
        groupMapper.update(group);

        return 1;
    }

    @Override
    public List<GroupRatingVO> getListWithPaging(Long grpSn, GroupRatingCriteria cri) {
        return groupRatingMapper.getListWithPaging(grpSn, cri);
    }

    @Override
    public int modify(GroupRatingVO groupRating) {
        groupRatingMapper.update(groupRating);
        long grpSn = groupRating.getGrpSn();
        GroupVO group = groupMapper.read(grpSn);
        group.setRating(groupRatingMapper.getRatingByGrpSn(grpSn));
        groupMapper.update(group);

        return 1;
    }

    @Override
    public int delete(Long sn) {

        return groupRatingMapper.delete(sn);
    }
}
